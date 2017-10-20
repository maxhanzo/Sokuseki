//
//  NameSurnameInputViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "NameSurnameInputViewController.h"
#import "TagParameters.h"
#import "MainViewController.h"
#import "DBManager.h"

@interface NameSurnameInputViewController ()
@property(nonatomic, strong) UISearchController *searchController;
@end

@implementation NameSurnameInputViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.txtInputNameSurname resignFirstResponder];
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"NameSurnameInputUnwindSegue"])
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
//    self.txtInputNameSurname.delegate =self;
//    [self.txtInputNameSurname becomeFirstResponder];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.searchBar.delegate = self;
    self.searchController.delegate =self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    
    //If your collection of data is sorted, you won't need this.
    self.textEntries =  [self.textEntries sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.textSuggestions = [NSMutableArray array];

    //Placeholder text
    NSString *placeHolderText = nil;
    
    DBManager *dbManager = [DBManager getSharedInstance];

    
    if([self.segueID isEqualToString:@"InputNameSegue"])
    {
        //self.textEntries = @[@"HIROSHI", @"SATOSHI", @"MITSUYOSHI", @"TETSUO", @"YOSHIO", @"AKIRA", @"KAZUO", @"SEIJI", @"MAKOTO", @"TSUTOMU", @"TOSHIRO", @"MASAO", @"MITSUMASA"];
        self.textEntries = [dbManager retrieveNamesPredictiveSearchbar];
        placeHolderText = @"Ex: Toshiro, Hiroko, Yoshio, Akemi";
    }
    else if([self.segueID isEqualToString:@"InputSurnameSegue"])
    {
        
        self.textEntries = [dbManager retrieveSurnamesPredictiveSearchbar];
        placeHolderText = @"Ex: Sato, Tanaka, Watanabe";
    }
    else if([self.segueID isEqualToString:@"InputNameKanjiSegue"])
    {
        self.textEntries = [dbManager retrieveNamesKanjiPredictiveSearchbar];
        placeHolderText = @"Ex: 利郎, ひろ子, 義雄, 明美";
    }
    else if ([self.segueID isEqualToString:@"InputSurnameKanjiSegue"])
    {
        self.textEntries = [dbManager retrieveSurnamesKanjiPredictiveSearchbar];
        placeHolderText = @"Ex: 佐藤, 田中, 渡邉";
    }
    
    [self.searchController.searchBar setPlaceholder:placeHolderText];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)inputNameSurname:(id)sender;
{
    NSString* inputValue = self.txtInputNameSurname.text;
    if(inputValue)
    {
        TagParameters *tagParameters = [TagParameters getSharedInstance];
        NSString *trimmedInputValue =[inputValue stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        
        if (![trimmedInputValue isEqualToString: @""])
        {
            
        
        
        [tagParameters setParameter: [trimmedInputValue uppercaseString]];
            [self performSegueWithIdentifier:@"NameSurnameInputUnwindSegue" sender:self];
        }
        
        else
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                            message:@"Fill the field."
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
            [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
        }
    }


    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                       message:@"Fill the field."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


#pragma mark - UISearchBar delegate
-(void) searchData: (NSString*) data
{
    [self.textSuggestions removeAllObjects];
    
    for (NSString* item in self.textEntries)
    {
        if ([item rangeOfString:data
                        options:(NSAnchoredSearch | NSCaseInsensitiveSearch)].location != NSNotFound)
            [self.textSuggestions addObject:item];
    }
    
    [self.tableView reloadData];
}


-(void) clearData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.searchController.searchBar resignFirstResponder];
        [self.textSuggestions removeAllObjects];
        [self.tableView reloadData];
    });
    
}


#pragma mark - Table view data source

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.textSuggestions)
    {
        return [self.textSuggestions count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
    
    
    NSString* cellText = [self.textSuggestions objectAtIndex:indexPath.row];
    [cell.textLabel setText: cellText];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString* inputValue = [self.textSuggestions objectAtIndex: indexPath.row];
    if(inputValue)
    {
        TagParameters *tagParameters = [TagParameters getSharedInstance];
        NSString *trimmedInputValue =[inputValue stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        
        if (![trimmedInputValue isEqualToString: @""])
        {
            [tagParameters setParameter: [trimmedInputValue uppercaseString]];
            [self performSegueWithIdentifier:@"NameSurnameInputUnwindSegue" sender:self];
        }
 
    }
}

-(void) updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString* substring = searchController.searchBar.text;
    [self searchData:substring];
}


//Workarround
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.1];
}

- (void) showKeyboard
{
    [self.searchController.searchBar becomeFirstResponder];
}


@end
