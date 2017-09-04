//
//  PrefectureDetailsTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 28/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//


#define PrefectureMapTableViewCell_ID 0
#define PrefectureNameTableViewCell_ID 1
#define PrefectureFlagTableViewCell_ID 2
#define PrefectureRegionDetailsTableViewCell_ID 3


#import "PrefectureDetailsTableViewController.h"
#import "PrefectureMapTableViewCell.h"
#import "PrefectureNameTableViewCell.h"
#import "PrefectureFlagTableViewCell.h"
#import "PrefectureRegionDetailsTableViewCell.h"
#import "Utilities.h"

@interface PrefectureDetailsTableViewController ()

@end

@implementation PrefectureDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [self.prefectureInfo.name uppercaseString];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch(indexPath.row)
    {
        case PrefectureMapTableViewCell_ID:{
            PrefectureMapTableViewCell *cell = (PrefectureMapTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PrefectureMapTableViewCell"];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrefectureMapTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            [cell.imgPrefectureFlag setImage: self.prefectureInfo.map];
            
            return cell;
        } break;
        case PrefectureNameTableViewCell_ID:
        {
            PrefectureNameTableViewCell *cell = (PrefectureNameTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PrefectureNameTableViewCell"];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrefectureNameTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            [cell.lblPrefectureKanjiName setText: self.prefectureInfo.kanji];
            NSString *prefectureSuffix = [Utilities prefectureSuffix:[self.prefectureInfo.name uppercaseString]];
            [cell.lblPrefectureRomajiName setText: [NSString stringWithFormat: @"%@%@", self.prefectureInfo.name, [prefectureSuffix lowercaseString]]];
            
            return cell;
        } break;
        case PrefectureFlagTableViewCell_ID:{
            PrefectureFlagTableViewCell *cell = (PrefectureFlagTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PrefectureFlagTableViewCell"];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrefectureFlagTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            [cell.imgPrefectureFlag setImage: [Utilities flagForPrefectureName:self.prefectureInfo.name]];
            return cell;
        } break;
        case PrefectureRegionDetailsTableViewCell_ID:{
            PrefectureRegionDetailsTableViewCell *cell = (PrefectureRegionDetailsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PrefectureRegionDetailsTableViewCell"];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrefectureRegionDetailsTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            [cell.lblIslandName setText: self.prefectureInfo.island];
            [cell.lblRegionName setText: self.prefectureInfo.region];
            [cell.lblCapitalCity setText: self.prefectureInfo.capital];
            
            
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [formatter setLocale: [NSLocale currentLocale]];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [formatter setMinimumFractionDigits:2];
            [formatter setMaximumFractionDigits:2];
            [formatter setGeneratesDecimalNumbers:YES];
            [formatter setAlwaysShowsDecimalSeparator:YES];
            
            NSString *finalAreaValue = [formatter stringFromNumber:self.prefectureInfo.area];
            [cell.lblArea setText: [NSString stringWithFormat: @"%@ km²" ,finalAreaValue]];
            
            return cell;
        } break;
        
        default:
            return nil;
            break;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch(indexPath.row)
    {
        case PrefectureMapTableViewCell_ID:
            return [PrefectureMapTableViewCell rowHeight];
            break;
        case PrefectureNameTableViewCell_ID:
            return [PrefectureNameTableViewCell rowHeight];
            break;
        case PrefectureFlagTableViewCell_ID:
            return [PrefectureFlagTableViewCell rowHeight];
            break;
        case PrefectureRegionDetailsTableViewCell_ID:
        default:
            return [PrefectureRegionDetailsTableViewCell rowHeight];
            break;
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
@end
