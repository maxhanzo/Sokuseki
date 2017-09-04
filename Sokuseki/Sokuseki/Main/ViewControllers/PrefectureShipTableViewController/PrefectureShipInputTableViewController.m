//
//  PrefectureShipInputTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "PrefectureShipInputTableViewController.h"
#import "PrefectureTableViewCell.h"
#import "ShipTableViewCell.h"
#import "MainViewController.h"
#import "TagParameters.h"
#import "Constants.h"
#import "Utilities.h"


@interface PrefectureShipInputTableViewController ()

@end


@implementation PrefectureShipInputTableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"PrefectureShipUnwindSegue"])
    {
        // Get reference to the destination view controller
        MainViewController *mainViewController = (MainViewController*)[segue destinationViewController];
        
        if(mainViewController){
            [mainViewController setWindingActionID:self.segueID];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.sectionTitles = A_Z_INDEXED_TITLES;
    ;
    
    if([self.segueID isEqualToString: @"InputPrefectureSegue"])
    {
        self.dataCollection = [PrefectureShipInputTableViewController generatePrefectureNames];
    }
    
    else if([self.segueID isEqualToString: @"InputShipSegue"])
    {
        self.dataCollection = [PrefectureShipInputTableViewController generateShipNames];
    }
    
    self.sectionHeaders = [Utilities headerTitlesforNamesCollection:self.dataCollection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *sectionTitles = A_Z_INDEXED_TITLES;
    return [sectionTitles count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [self.sectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *sectionKey = [self.sectionTitles objectAtIndex: section];
    NSArray *sectionCollection = [self.sectionHeaders objectForKey: sectionKey];
    if(sectionCollection)
        return [sectionCollection count];
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionData = [self.sectionHeaders objectForKey:sectionTitle];
    NSString *sectionContent = [sectionData objectAtIndex:indexPath.row];
    
    if([self.segueID isEqualToString: @"InputPrefectureSegue"])
    {
        PrefectureTableViewCell *cell = (PrefectureTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"PrefectureTableViewCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrefectureTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
      
        [cell.lblPrefectureName setText: sectionContent ];
        [cell.imgPrefectureFlag setImage: [Utilities flagForPrefectureName:sectionContent]];
        return cell;
        ;
    }
    
    else if([self.segueID isEqualToString: @"InputShipSegue"])
    {
        ShipTableViewCell *cell = (ShipTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"ShipTableViewCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShipTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setDataWithName: sectionContent];
        return cell;
        ;
    }

    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.segueID isEqualToString: @"InputShipSegue"])
    {
        return [ShipTableViewCell rowHeight];
    }
    
    return [PrefectureTableViewCell rowHeight];
     
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TagParameters *tagParameters = [TagParameters getSharedInstance];
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionData = [self.sectionHeaders objectForKey:sectionTitle];
    NSString *parameterText = [sectionData objectAtIndex:indexPath.row];

    NSString *suffix =@"";
    //Preventing conflicting surnames that have the same spelling as prefecture names.
    if([self.segueID isEqualToString: @"InputPrefectureSegue"])
    {
        suffix = [Utilities prefectureSuffix:parameterText];
    }
    
    
    [tagParameters setParameter: [NSString stringWithFormat: @"%@%@", parameterText, suffix]];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"PrefectureShipUnwindSegue" sender:self];
}

//Prevent extra separators from appearing
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
}

+(NSArray*) generateShipNames
{
    //NSMutableArray* shipNames = [NSMutableArray array];
    //return shipNames;
    return SHIPS_NAMES_ARRAY;
}

+(NSArray*) generatePrefectureNames
{
    //NSMutableArray* prefectureNames = [NSMutableArray array];
    //return prefectureNames;
    return PREFECTURE_NAMES_ARRAY;
}

@end
