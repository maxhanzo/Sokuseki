//
//  PrefectureListTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 26/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "PrefectureListTableViewController.h"
#import "PrefectureStatsTableViewCell.h"
#import "PrefectureStatsTopTableViewCell.h"
#import "PrefectureStatsTableViewFooter.h"
#import "PrefectureDetailsTableViewController.h"
#import "PrefectureInfo.h"
#import "DBManager.h"


@interface PrefectureListTableViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property (nonatomic, strong) PrefectureInfo* prefectureInfo;
@end

@implementation PrefectureListTableViewController

- (void)viewDidLoad
{
    //lblTotal.text = [NSString stringWithFormat: @"%i Imigrantes (1908 - 1984)", 245677];
    self.prefectureInfo = nil;
    
    self.prefectureArray = [NSMutableArray array];
    
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:5573] withName: @"Nagasaki"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:4378] withName: @"Yamagata"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:20211] withName: @"Okinawa"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:2491] withName: @"Ibaraki"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:18] withName: @"Karafuto"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:7404] withName: @"Tokyo"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:4807] withName: @"Osaka"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:14133] withName: @"Hiroshima"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1221] withName: @"Shiga"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1307] withName: @"Chiba"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:4384] withName: @"Miyagi"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1257] withName: @"Nara"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:6098] withName: @"Wakayama"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:2445] withName: @"Mie"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:20124] withName: @"Fukuoka"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:5303] withName: @"Ehime"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:4549] withName: @"Shizuoka"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1780] withName: @"Shimane"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:18] withName: @"Korea"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1337] withName: @"Saitama"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:6327] withName: @"Kochi"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:4536] withName: @"Saga"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:6724] withName: @"Okayama"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:7467] withName: @"Kagoshima"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1722] withName: @"Tottori"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:12553] withName: @"Fukushima"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:2958] withName: @"Kagawa"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1344] withName: @"Toyama"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:4246] withName: @"Aichi"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:7735] withName: @"Yamaguchi"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1897] withName: @"Kyoto"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:3120] withName: @"Miyazaki"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1237] withName: @"Tochigi"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:2491] withName: @"Oita"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1727] withName: @"Yamanashi"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:2469] withName: @"Kanagawa"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:2928] withName: @"Gunma"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:16249] withName: @"Hokkaido"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1482] withName: @"Aomori"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1364] withName: @"Fukui"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:2447] withName: @"Akita"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:2109] withName: @"Gifu"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:5817] withName: @"Hyogo"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1705] withName: @"Ishikawa"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:23888] withName: @"Kumamoto"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:1296] withName: @"Tokushima"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:2519] withName: @"Niigata"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:4024] withName: @"Nagano"]];
    [self.prefectureArray addObject: [PrefectureStatistics prefectureWithNumberOfImmigrants: [NSNumber numberWithInteger:2458] withName: @"Iwate"]];
    
    NSSortDescriptor *sortDescriptorDesc = [NSSortDescriptor sortDescriptorWithKey:@"numberOfImmigrants" ascending:NO selector:@selector(compare:)];
    
    self.prefectureDataSource = [self.prefectureArray sortedArrayUsingDescriptors:@[ sortDescriptorDesc ]];
    PrefectureStatistics *topMostPrefecture = (PrefectureStatistics*)[_prefectureDataSource objectAtIndex: 0];
    self.topMostNumberOfImmigrants = [topMostPrefecture.numberOfImmigrants integerValue];
}


-(void) viewWillAppear:(BOOL) animated
{
    [super viewWillAppear:animated];
    self.revealViewController.delegate = self;
    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    [self.tableView reloadData];
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
    return [self.prefectureArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row <[self.prefectureDataSource count])
    {
        
        PrefectureStatistics *prefecture = (PrefectureStatistics*)[self.prefectureDataSource objectAtIndex: indexPath.row];
        
        if([prefecture.numberOfImmigrants integerValue] == self.topMostNumberOfImmigrants)
        {
            PrefectureStatsTopTableViewCell *cell = (PrefectureStatsTopTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"PrefectureStatsTopTableViewCell"];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrefectureStatsTopTableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            [cell setPrefectureDataWithPrefecture: prefecture];
            [cell resizePercentageBarWithTotalValue: [NSNumber numberWithInteger: self.topMostNumberOfImmigrants]];

            
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
            
            [cell setPrefectureDataWithPrefecture: prefecture];
            [cell resizePercentageBarWithTotalValue: [NSNumber numberWithInteger: self.topMostNumberOfImmigrants]];
            return cell;
        }
    }
    
    else
    {
        PrefectureStatsTableViewFooter *cell = (PrefectureStatsTableViewFooter*)[self.tableView dequeueReusableCellWithIdentifier:@"PrefectureStatsTableViewFooter"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PrefectureStatsTableViewFooter" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        NSNumber* numberOfImmigrants = [NSNumber numberWithInteger:245677];
        [cell setTotalRecordsText: [numberOfImmigrants stringValue] withSuffix: @"Records."];
        return cell;

    }
    
    return nil;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger results = [self.prefectureDataSource count];
    if(indexPath.row< results)
    {
        PrefectureStatistics* statistics = (PrefectureStatistics*)[self.prefectureDataSource objectAtIndex: indexPath.row];
        if(statistics)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
                DBManager *dbManager = [DBManager getSharedInstance];
                PrefectureInfo* prefectureInfo = [dbManager retrievePrefectureInfoWithName: statistics.name];
                
                if(prefectureInfo)
                {
                    self.prefectureInfo = prefectureInfo;
                    [self performSegueWithIdentifier: @"PrefectureDetailsSegue" sender:nil];
                   
                }
            });
        }
    
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row <[self.prefectureDataSource count])
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


#pragma mark - Segue stuff
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"PrefectureDetailsSegue"])
    {
        // Get reference to the destination view controller
        UINavigationController *prefectureDetailsNavigationController = (UINavigationController*)[segue destinationViewController];
        prefectureDetailsNavigationController.navigationItem.title = self.prefectureInfo.name;
        if(prefectureDetailsNavigationController){
            
            
            PrefectureDetailsTableViewController *prefectureDetailsTableViewController = (PrefectureDetailsTableViewController*)[prefectureDetailsNavigationController.childViewControllers firstObject];
            
            
            if(prefectureDetailsTableViewController){
                [prefectureDetailsTableViewController setPrefectureInfo:self.prefectureInfo];
            }
        
        }
    }
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

@end
