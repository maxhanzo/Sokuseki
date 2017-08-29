//
//  ImmigrantResultsViewControllerTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ImmigrantResultsViewControllerTableViewController.h"
#import "ImmigrantsResultsTableViewCell.h"
#import "ImmigrantsResultsTableViewFooter.h"
#import "SearchParameters.h"
#import "DBManager.h"
#import "GroupDetailTableViewController.h"

@interface ImmigrantResultsViewControllerTableViewController ()

@end

@implementation ImmigrantResultsViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedImmigrant = nil;
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.tableView.backgroundView = self.activityIndicator;
    [self.activityIndicator startAnimating];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
        SearchParameters *searchParameters = [SearchParameters getSharedInstance];
        NSArray* searchResults  = [DBManager searchImmigrantWithData:searchParameters.searchAshiatoParameters];
        if(searchResults)
        {
            [self.activityIndicator stopAnimating];
            if([searchResults count]>0)
            dispatch_async(dispatch_get_main_queue(),^{
                self.immigrantResults = searchResults;
                [self.activityIndicator stopAnimating];
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                [self.tableView reloadData];
            });
            
            else
            {
                    //Display a text when the UITableView has no data
                     dispatch_async(dispatch_get_main_queue(),^{
                
                    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
                
                    messageLabel.text = @"No results!";
                
                    messageLabel.textColor = [UIColor blackColor];
                    messageLabel.numberOfLines = 0;
                    messageLabel.textAlignment = NSTextAlignmentCenter;
                    messageLabel.font = [UIFont fontWithName:@"System" size:20];
                    [messageLabel sizeToFit];
                
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                         self.tableView.backgroundView = messageLabel;
                     });
                
            }
        }
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(self.immigrantResults)
    {
        self.tableView.backgroundView = nil;
        return [self.immigrantResults count] + 1;
    }
    
    return 1;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger footerIndex = [self.immigrantResults count];
    
    if(indexPath.row != footerIndex)
    {
        ImmigrantsResultsTableViewCell *cell = (ImmigrantsResultsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ImmigrantsResultsTableViewCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ImmigrantsResultsTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        Immigrant *immigrant = [self.immigrantResults objectAtIndex: indexPath.row];
        [cell setDataFromImmigrant:immigrant];

        return cell;
    }
    
    ImmigrantsResultsTableViewFooter *cell = (ImmigrantsResultsTableViewFooter*)[tableView dequeueReusableCellWithIdentifier:@"ImmigrantsResultsTableViewFooter"];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ImmigrantsResultsTableViewFooter" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSNumber *totalResults = [NSNumber numberWithInteger: [self.immigrantResults count]];
    [cell.lblTotalRecords setText: [totalResults stringValue]];
    if(footerIndex==0) {
        [cell setHidden:YES];
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger totalRecords = [self.immigrantResults count];
    if(indexPath.row == totalRecords)
    {
        return [ImmigrantsResultsTableViewFooter rowHeight];
    }
    
    return [ImmigrantsResultsTableViewCell rowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger totalRecords = [self.immigrantResults count];
    
    if(indexPath.row != totalRecords )
    {
        self.selectedImmigrant = (Immigrant*)[self.immigrantResults objectAtIndex: indexPath.row];
        [self performSegueWithIdentifier:@"GroupDetailSegue" sender:self];
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
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController* groupDetailNavigationViewController = (UINavigationController*)segue.destinationViewController;
    
    groupDetailNavigationViewController.navigationItem.title = @"Details";
    GroupDetailTableViewController* groupDetailTableViewControllerViewController = (GroupDetailTableViewController*)[groupDetailNavigationViewController.childViewControllers firstObject];
    
    if(groupDetailTableViewControllerViewController)
    {
        [groupDetailTableViewControllerViewController setSelectedImmigrant: self.selectedImmigrant];
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue
{

}

@end
