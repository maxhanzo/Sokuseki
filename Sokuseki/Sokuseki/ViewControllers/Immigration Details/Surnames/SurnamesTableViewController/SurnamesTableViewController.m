//
//  SurnamesTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 30/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "SurnamesTableViewController.h"
#import "SurnameDetailsTableViewController.h"
#import "DBManager.h"

@interface SurnamesTableViewController ()

@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property(nonatomic, strong) NSArray *surnamesArray;
@property(nonatomic, strong) NSArray *searchResults;
@property(nonatomic, strong) NSArray *sectionTitles;
@property(nonatomic, strong) NSDictionary *sectionHeaders;

@end

@implementation SurnamesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithAllData];
    self.selectedSurname = nil;
    self.surnameRanking = @0;
    [self.tableView registerNib:[UINib nibWithNibName:@"TopTenSurnameTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TopTenSurnameTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RegularSurnameTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RegularSurnameTableViewCell"];
  
    self.sectionTitles = TEN_INDEXED_TITLES;
    
    self.sectionHeaders = [self sectionsWithHeadersFromData:self.surnamesArray];
//    self.searchController.delegate = self;
//    self.resultsTableController = [[UITableView alloc] init];
//    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
//    self.searchController.searchResultsUpdater = self;
//    [self.searchController.searchBar sizeToFit];
//    self.tableView.tableHeaderView = self.searchController.searchBar;
    

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController* surnameDetailNavigationViewController = (UINavigationController*)segue.destinationViewController;
    
    surnameDetailNavigationViewController.navigationItem.title = @"Surname Details";
    SurnameDetailsTableViewController* surnameDetailsTableViewController = (SurnameDetailsTableViewController*)[surnameDetailNavigationViewController.childViewControllers firstObject];
    
    if(surnameDetailsTableViewController)
    {
        [surnameDetailsTableViewController setSurname: self.selectedSurname];
        [surnameDetailsTableViewController setRanking:self.surnameRanking];
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.revealViewController.delegate = self;
    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    
    [self.tableView reloadData];
}

-(NSInteger) calculateTotalNumberOfImmigrants
{
    NSInteger total = 0;
    Surname *surname = [self.surnamesArray objectAtIndex:0];
    if(surname)
    {
        total = [surname.numberOfImmigrants integerValue];
    }
    
    return total;
}




#pragma mark - Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionTitles count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [self.sectionTitles objectAtIndex:section];
//}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionKey = [self.sectionTitles objectAtIndex: section];
    NSArray *sectionCollection = [self.sectionHeaders objectForKey: sectionKey];
    if(sectionCollection)
        return [sectionCollection count];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger totalNumberOfImmigrants = [self calculateTotalNumberOfImmigrants];
    NSString *sectionKey = [self.sectionTitles objectAtIndex: indexPath.section];
    Surname  *surname = nil;
    //surname = [self.surnamesArray objectAtIndex: indexPath.row];
    NSArray *sectionData = [self.sectionHeaders objectForKey: sectionKey];
    surname = [sectionData objectAtIndex: indexPath.row];
    
    if(indexPath.section!=0){
        
        RegularSurnameTableViewCell *cell = (RegularSurnameTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"RegularSurnameTableViewCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RegularSurnameTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        
        [cell setDataWithSurname: surname];
        [cell resizePercentageBarWithTotalValue: [NSNumber numberWithInteger: totalNumberOfImmigrants]];
        return cell;
    }
    
    if(indexPath.row <10)
    {
        TopTenSurnameTableViewCell *cell = (TopTenSurnameTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"TopTenSurnameTableViewCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TopTenSurnameTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setDataWithSurname: surname withRankingPosition: [NSNumber numberWithInteger: (indexPath.row + 1)]];
        [cell resizePercentageBarWithTotalValue: [NSNumber numberWithInteger: totalNumberOfImmigrants]];
        [cell setRanking: (indexPath.row + 1)];
        
        return cell;
    }
    
    RegularSurnameTableViewCell *cell = (RegularSurnameTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"RegularSurnameTableViewCell"];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RegularSurnameTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    [cell setDataWithSurname: surname];
    [cell resizePercentageBarWithTotalValue: [NSNumber numberWithInteger: totalNumberOfImmigrants]];
    return cell;
    
}



//selectedSurname
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedSurname = [self.surnamesArray objectAtIndex: indexPath.row];
    
    NSString *sectionKey = [self.sectionTitles objectAtIndex: indexPath.section];
    NSArray *sectionData = [self.sectionHeaders objectForKey: sectionKey];
    
    self.selectedSurname = [sectionData objectAtIndex: indexPath.row];
    //This is wrong.
    NSInteger ranking = (indexPath.section!=0)? (indexPath.row + 1)*indexPath.section: (indexPath.row + 1);
    self.surnameRanking = [NSNumber numberWithInteger:ranking];
    [self performSegueWithIdentifier:@"SurnameDetailsSegue" sender:self];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TopTenSurnameTableViewCell rowHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}


-(void) initWithAllData
{
    DBManager *dbManager = [DBManager getSharedInstance];
    self.surnamesArray = [dbManager retrieveAllSurnames];
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.surnamesArray count]];

}

-(NSDictionary*) sectionsWithHeadersFromData: (NSArray*) data
{
    NSInteger totalRecords = [data count];
    NSInteger totalPages = [self.sectionTitles count];
    NSInteger pageSize = totalRecords/totalPages;
    NSInteger extraPageSize = totalRecords%totalPages;
    
    totalPages = (extraPageSize ==0)? totalPages +1 : totalPages;
    
    NSMutableDictionary *sectionDataWithHeaders = [NSMutableDictionary dictionary];
    
    for (NSInteger i=0; i<totalPages; i++)
    {
        NSRange range = (i!=totalPages-1)? NSMakeRange(i*pageSize, pageSize): NSMakeRange(i*pageSize, pageSize+extraPageSize);
        
        NSArray *page = [data subarrayWithRange: range];
        [sectionDataWithHeaders setObject: page forKey: [NSString stringWithFormat: @"%lu", (long)(i + 1)]];
    }
    
    return sectionDataWithHeaders;
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
