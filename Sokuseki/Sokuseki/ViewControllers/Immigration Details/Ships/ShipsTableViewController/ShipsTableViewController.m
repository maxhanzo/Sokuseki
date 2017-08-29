//
//  ShipsTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 30/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ShipsTableViewController.h"
#import "ShipDetailsTableViewController.h"
#import "DBManager.h"
#import "Steamer.h"
#import "ShipTableViewCell.h"

@interface ShipsTableViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property(nonatomic, strong) Steamer *selectedShip;
@end

@implementation ShipsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DBManager *dbManager = [DBManager getSharedInstance];
    self.shipsArray = [dbManager retrieveAllSteamers];
    self.selectedShip = nil;
    
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.searchBar.delegate = self;
    self.searchController.delegate =self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //If your collection of data is sorted, you won't need this.
    self.textEntries =  [self.textEntries sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.shipsSuggestions = [NSMutableArray array];
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.revealViewController.delegate = self;
    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
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
    if(self.searchController.isActive)
    {
        if(self.shipsSuggestions)
        {
            return [self.shipsSuggestions count];
        }
    }

    
    if(self.shipsArray)
    {
        return [self.shipsArray count];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.searchController.isActive)
    {
        static NSString *CellIdentifier = @"ShipCommonCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
        
        
        Steamer* steamer = [self.shipsSuggestions objectAtIndex:indexPath.row];
        NSString* cellText = steamer.shipName ?: @"";
        [cell.textLabel setText: cellText];
        
        return cell;
    }
    
    
    Steamer* steamer = [self.shipsArray objectAtIndex: indexPath.row];
    
    if(steamer){
        ShipTableViewCell *cell = (ShipTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"ShipTableViewCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShipTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setDataWithName:steamer.shipName];
        return cell;
    }
    

    
    return nil;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.searchController.isActive)
    {
        Steamer* searchControllerSteamer = [self.shipsSuggestions objectAtIndex:indexPath.row];
        self.selectedShip = searchControllerSteamer;
        [self clearData];
    }
    
    else
    {
        Steamer *selectedSteamer = [self.shipsArray objectAtIndex:indexPath.row];
        if(selectedSteamer){
            self.selectedShip = selectedSteamer;
        }
    }
    [self performSegueWithIdentifier: @"ShipDetailsSegue" sender: self];
}

#pragma mark - SWRevealViewController stuff
- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if (revealController.frontViewPosition == FrontViewPositionRight) {
        UIView *lockingView = [UIView new];
        lockingView.translatesAutoresizingMaskIntoConstraints = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:revealController action:@selector(revealToggle:)];
        [lockingView addGestureRecognizer:tap];
        [lockingView addGestureRecognizer:revealController.panGestureRecognizer];
        [lockingView setTag:9999];
        [revealController.frontViewController.view addSubview:lockingView];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(lockingView);
        
        [revealController.frontViewController.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"|[lockingView]|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        [revealController.frontViewController.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lockingView]|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        [lockingView sizeToFit];
    }
    else{
        [[revealController.frontViewController.view viewWithTag:9999] removeFromSuperview];
        [self.navigationController.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
    }
}


#pragma mark - Segue stuff
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue
{
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString: @"ShipDetailsSegue"])
    {
        UINavigationController* shipDetailNavigationViewController = (UINavigationController*)segue.destinationViewController;
        
        
        ShipDetailsTableViewController* shipDetailsTableViewController = (ShipDetailsTableViewController*)[shipDetailNavigationViewController.childViewControllers firstObject];
        
        if(shipDetailsTableViewController)
        {
            [shipDetailsTableViewController setSteamer:self.selectedShip];
        }
    }
}



#pragma mark - UISearchBar delegate

-(void) updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString* substring = searchController.searchBar.text;
    [self searchData:substring];
}


-(void) searchData: (NSString*) data
{
    [self.shipsSuggestions removeAllObjects];
    
    for (Steamer* item in self.shipsArray)
    {
        if ([item.shipName rangeOfString:data
                               options:(NSAnchoredSearch | NSCaseInsensitiveSearch)].location != NSNotFound)
            [self.shipsSuggestions addObject:item];
    }
    
    [self.tableView reloadData];
}


-(void) clearData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.searchController setActive: NO];
        [self.shipsSuggestions removeAllObjects];
        [self.tableView reloadData];
    });
    
}

@end
