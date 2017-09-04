//
//  ShipDetailsTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 30/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ShipDetailsTableViewController.h"
#import "ShipJourneyTableViewCell.h"
#import "ShipDetailsTableViewHeaderCell.h"
#import "GroupDetailTableViewFooterCell.h"
#import "DBManager.h"
#import "Utilities.h"
#import "JourneyDetailsTableViewController.h"

@interface ShipDetailsTableViewController ()
@property(nonatomic, strong) Voyage *selectedJourney;
@end

@implementation ShipDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DBManager *dbManager = [DBManager getSharedInstance];
    self.shipJourneys = [dbManager retrieveVoyageFromShipName:self.steamer.shipName];
    
    
    self.navigationItem.title = self.steamer.shipName;
    
    
//    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"JapaneseImmigrationPoster"]];
//    [tempImageView setFrame:self.tableView.frame];
//    
//    self.tableView.backgroundView = tempImageView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(self.shipJourneys)
    {
        return [self.shipJourneys count] + 1;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger results = [self.shipJourneys count];
    
    NSInteger footerIndex = results;
//    
//    if(indexPath.row == 0)
//    {
//        ShipDetailsTableViewHeaderCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ShipDetailsTableViewHeaderCell"];
//        
//        if(!cell)
//        {
//            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShipDetailsTableViewHeaderCell" owner:self options:nil];
//            cell = [nib objectAtIndex:0];
//        }
//        
//        [cell.lblShipCompany setText: self.steamer.companyName];
//        UIImage *shipAvatar = [Utilities pictureForShipName:self.steamer.shipName withJourneyDate: [NSDate date]];
//        if(shipAvatar)
//            [cell.imgShipAvatar setImage: shipAvatar];
//        return cell;
//
//    }
//    else
    if(indexPath.row == footerIndex)
    {
        GroupDetailTableViewFooterCell *cell = (GroupDetailTableViewFooterCell*)[tableView dequeueReusableCellWithIdentifier:@"GroupDetailTableViewFooterCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GroupDetailTableViewFooterCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setTotalRecordsText: [NSString stringWithFormat: @"%li", (long)results] withTotalPassengers:[NSString stringWithFormat: @"%li", (long)[self totalPassengers]] ];
        
        return cell;
        
    }
    else
    {
        Voyage* journey = [self.shipJourneys objectAtIndex: indexPath.row];
    
    
        ShipJourneyTableViewCell *cell = (ShipJourneyTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"ShipJourneyTableViewCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShipJourneyTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
    
        if(journey)
        {
            NSString* textDate = [Utilities stringFromDate:journey.departureDate];
            NSString *journeyInfo = [NSString stringWithFormat: @"%@ • %li passengers", textDate, (long)journey.numberOfImmigrants];
            [cell.lblJourneyInfo setText: journeyInfo];
        }
        return cell;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger footerIndex = [self.shipJourneys count] ;
    
//    if(indexPath.row == 0)
//    {
//        return [ShipDetailsTableViewHeaderCell rowHeight];
//    }

     if(indexPath.row == footerIndex)
    {
        return [GroupDetailTableViewFooterCell rowHeight];
    }

    return [ShipJourneyTableViewCell rowHeight];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];

         NSInteger footerIndex = [self.shipJourneys count]  ;
        if(indexPath.row < footerIndex)
        {
            NSInteger index = indexPath.row;
            self.selectedJourney = (Voyage*) [self.shipJourneys objectAtIndex: index];
            [self performSegueWithIdentifier:@"JourneyDetailsSegue" sender:self];
        }
}

//Prevent extra separators from appearing
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

#pragma mark - Segue stuff

-(IBAction)prepareForUnwind: (UIStoryboard*) segue
{

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString: @"JourneyDetailsSegue"])
    {
        UINavigationController* journeyDetailNavigationViewController = (UINavigationController*)segue.destinationViewController;
        
        
        JourneyDetailsTableViewController* journeyDetailsTableViewController = (JourneyDetailsTableViewController*)[journeyDetailNavigationViewController.childViewControllers firstObject];
        
        if(journeyDetailsTableViewController)
        {
            [journeyDetailsTableViewController setJourney:self.selectedJourney];
        }
    }
}


#pragma mark - Utilities
-(NSInteger) totalPassengers
{
    NSInteger totalPassengers = 0;
    for (Voyage *journey in self.shipJourneys)
    {
        totalPassengers += journey.numberOfImmigrants;
    }
    return totalPassengers;
}

@end
