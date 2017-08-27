//
//  JourneyDetailsTableViewController.m
//  Sokuseki
//
//  Created by Ticket Services on 26/01/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import "JourneyDetailsTableViewController.h"
#import "ShipDetailsTableViewHeaderCell.h"

#import "PrefectureStatsTopTableViewCell.h"
#import "PrefectureStatsTableViewCell.h"
#import "PrefectureStatsTableViewFooter.h"
#import "Passenger.h"
#import "DBManager.h"

@interface JourneyDetailsTableViewController ()


@end
@implementation JourneyDetailsTableViewController

- (void)viewDidLoad
{
    //lblTotal.text = [NSString stringWithFormat: @"%i Imigrantes (1908 - 1984)", 245677];
    
    DBManager *dbManager = [DBManager getSharedInstance];
    
    NSArray* passengers = [dbManager retrievePassengersFromVoyage:self.journey];
    
    NSSortDescriptor *sortDescriptorDesc = [NSSortDescriptor sortDescriptorWithKey:@"totalNumberOfImmigrants" ascending:NO selector:@selector(compare:)];
    
    self.passengersArray  = [passengers sortedArrayUsingDescriptors:@[ sortDescriptorDesc ]];
    
    Passenger *topMostPassengerGroup = (Passenger*)[self.passengersArray objectAtIndex: 0];
    self.topMostNumberOfImmigrants = topMostPassengerGroup.numberOfImmigrants;
}


-(void) viewWillAppear:(BOOL) animated
{
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.passengersArray count] + 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShipDetailsTableViewHeaderCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ShipDetailsTableViewHeaderCell"];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShipDetailsTableViewHeaderCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell.lblShipCompany setText: self.journey.shipCompany];
    UIImage *shipAvatar = [Utilities pictureForShipName:self.journey.shipName withJourneyDate: self.journey.departureDate];
    if(shipAvatar)
        [cell.imgShipAvatar setImage: shipAvatar];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return [ShipDetailsTableViewHeaderCell rowHeight];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row ==[self.passengersArray count])
    {
        
        PrefectureStatsTableViewFooter *cell = (PrefectureStatsTableViewFooter*)[self.tableView dequeueReusableCellWithIdentifier:@"PrefectureStatsTableViewFooter"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrefectureStatsTableViewFooter" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        NSNumber* numberOfImmigrants = [self allPassengers];
        [cell setTotalRecordsText: [numberOfImmigrants stringValue] withSuffix: @"People."];
        return cell;
        
    }
    
    else{
        Passenger *passenger = (Passenger*)[self.passengersArray objectAtIndex: indexPath.row ];
        
        if(passenger.numberOfImmigrants == self.topMostNumberOfImmigrants)
        {
            PrefectureStatsTopTableViewCell *cell = (PrefectureStatsTopTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"PrefectureStatsTopTableViewCell"];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrefectureStatsTopTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            [cell setPrefectureDataWithName: passenger.prefectureName withNumberOfImmigrants:passenger.totalNumberOfImmigrants];
            [cell resizePercentageBarWithTotalValue: [NSNumber numberWithInteger: self.topMostNumberOfImmigrants]];
            [cell.imgPrefectureFlag setImage: [Utilities flagForPrefectureName:passenger.prefectureName]];
            
            return cell;
        }
        else
        {
            PrefectureStatsTableViewCell *cell = (PrefectureStatsTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"PrefectureStatsTableViewCell"];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrefectureStatsTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
            }
            
            [cell setPrefectureDataWithName: passenger.prefectureName withNumberOfImmigrants:passenger.totalNumberOfImmigrants];
            [cell resizePercentageBarWithTotalValue: [NSNumber numberWithInteger: self.topMostNumberOfImmigrants]];
            [cell.imgPrefectureFlag setImage: [Utilities flagForPrefectureName:passenger.prefectureName]];
            
            return cell;
            
        }
    }
    
    
    
    return nil;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row <[self.passengersArray count])
    {
        return [PrefectureStatsTableViewCell rowHeight];
    }
    
    else return [PrefectureStatsTableViewFooter rowHeight];
    
}

//Prevent extra separators from appearing
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
}


-(NSNumber*) allPassengers
{
    NSInteger allPassengers = 0;
    if(self.passengersArray)
    {
        for(Passenger *passenger in _passengersArray)
        {
            allPassengers += passenger.numberOfImmigrants;
        }
    }
    return [NSNumber numberWithInteger: allPassengers];
}

@end
