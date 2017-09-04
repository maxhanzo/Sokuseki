//
//  MenuTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 12/15/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "MenuTableViewController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define URLEMail @"mailto:contact@uedasoft-it.com?subject=title&body=content"


@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    switch ( indexPath.row )
    {
        case 0:
            CellIdentifier = @"HeaderCell";
            break;
            
        case 1:
            CellIdentifier = @"ImmigrationDetailsSection";
            break;
            
        case 2:
            CellIdentifier = @"ImmigrantsCell";
            break;
            
        case 3:
            CellIdentifier = @"PrefecturesCell";
            break;
            
        case 4:
            CellIdentifier = @"SurnamesCell";
            break;
            
        case 5:
            CellIdentifier = @"HistorySection";
            break;
            
        case 6:
            CellIdentifier = @"ImmigrationYearsCell";
            break;
            
        case 7:
            CellIdentifier = @"ShipsCell";
            break;
            
        case 8:
            CellIdentifier = @"ContactsSection";
            break;
            
        case 9:
            CellIdentifier = @"SocialMediaCell";
            break;
            
        case 10:
            CellIdentifier = @"EmailCell";
            break;
        case 11:
            CellIdentifier = @"AboutCell";
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ( indexPath.row )
    {
        case 0:
            return 100.0f;
            break;
        case 1:
        case 5:
        case 8:
            return 29.0f;
            break;
            
        case 2:
        case 3:
        case 4:
        case 6:
        case 7:
        case 9:
        case 10:
        case 11:
            return 44.0f;
            break;
        default:
            return IS_IPHONE_5 ? 100: 200;
            break;
    }
    
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 10)
    {
        //Solve deprecations later
        NSString *url = [URLEMail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
        [[UIApplication sharedApplication]  openURL: [NSURL URLWithString: url]];
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

#pragma mark state preservation / restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO call whatever function you need to visually restore
}

@end
