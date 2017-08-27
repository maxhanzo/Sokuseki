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
    if(self.shipsArray)
    {
        return [self.shipsArray count];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    Steamer *selectedSteamer = [self.shipsArray objectAtIndex:indexPath.row];
    if(selectedSteamer){
        self.selectedShip = selectedSteamer;
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


@end
