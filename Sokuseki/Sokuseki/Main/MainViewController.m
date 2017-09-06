//
//  MainViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 12/13/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "MainViewController.h"
#import "ASJTagsView.h"
#import "NameSurnameInputViewController.h"
#import "YearInputTableViewController.h"
#import "PrefectureShipInputTableViewController.h"
#import "TagParameters.h"
#import "SearchParameters.h"
#import "Constants.h"
#import "Utilities.h"
@import Firebase;

@interface MainViewController ()
    @property (weak, nonatomic) IBOutlet ASJTagsView *tagsView;
    @property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
    @property (atomic, assign) BOOL shouldPerformSegueFromTableViewCell;
- (IBAction)clearAllTapped:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    [self handleTagBlocks];
    self.tagTypes = [[NSMutableDictionary alloc] init];
    [self.filterTypeSelectionTableView setAllowsMultipleSelection:YES];
    self.shouldPerformSegueFromTableViewCell = YES;
    
}

-(void) viewWillAppear:(BOOL)animated
{
    self.revealViewController.delegate = self;
    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleTagBlocks
{
    __weak typeof(self) weakSelf = self;
    [_tagsView setTapBlock:^(NSString *tagText, NSInteger idx)
     {
        // NSString *message = [NSString stringWithFormat:@"You tapped: %@", tagText];
        // [weakSelf showAlertMessage:message];
     }];
    
    [_tagsView setDeleteBlock:^(NSString *tagText, NSInteger idx)
     {
         //NSString *message = [NSString stringWithFormat:@"You deleted: %@", tagText];
         //[weakSelf showAlertMessage:message];
         [weakSelf.tagsView deleteTagAtIndex:idx];
         
         NSNumber* inputTagType = [self.tagTypes objectForKey: tagText];
         if(inputTagType)
         {
             NSInteger tagTypeCode = [inputTagType integerValue];
             switch(tagTypeCode)
             {
                 case NAMETAG:
                 {
                     [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:1 inSection:0] animated:YES];
                 } break;
                 case SURNAMETAG:
                 {
                     [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:2 inSection:0] animated:YES];
                 } break;
                 case NAMEKANJITAG:
                 {
                     [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:8 inSection:0] animated:YES];
                 } break;
                 case SURNAMEKANJITAG:
                 {
                     [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:9 inSection:0] animated:YES];
                 } break;
                 case PREFECTURETAG:
                 {
                     [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:4 inSection:0] animated:YES];
                 } break;
                 case SHIPTAG:
                 {
                     [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:5 inSection:0] animated:YES];
                 } break;
                 case YEARTAG:
                 {
                     [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:6 inSection:0] animated:YES];
                 } break;
                 default:
                 {
                     [self clearAllTapped:nil];
                 } break;
             }
             
             [self.tagTypes removeObjectForKey: tagText];
         }
         
         
     }];
}

//Create search parameters
//
// Legacy stuff:
// #define NameKanjiKey 0
// #define NameRomajiKey 1
// #define SurnameKanjiKey 2
// #define SurnameRomajiKey 3
// #define ImmigrationYearKey 4
// #define PrefectureNameKey 5
// #define ShipNameKey 6

-(NSDictionary*) createSearchParameters
{

    NSMutableDictionary *shinAshiatoParameters = nil;
    NSArray *tagKeys  = [self.tagTypes allKeys];
    if([tagKeys count]>0)
    {
        shinAshiatoParameters = [NSMutableDictionary dictionary];
    }
    for(NSString *tagKey in tagKeys)
    {
        //Tag object contains the tag type. We need to adapt this because we're using legacy components.
        NSNumber *tagObject = [self.tagTypes objectForKey: tagKey];
        if(tagObject)
        {
            NSInteger sokusekiKey = [tagObject integerValue];
            switch (sokusekiKey)
            {
                case NAMETAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", NameRomajiKey]];
                } break;
                case SURNAMETAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", SurnameRomajiKey]];
                } break;
                case NAMEKANJITAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", NameKanjiKey]];
                } break;
                case SURNAMEKANJITAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", SurnameKanjiKey]];
                } break;
                case PREFECTURETAG:
                {
                    NSString *prefectureName = [Utilities removePrefectureSuffix:tagKey];
                    [shinAshiatoParameters setObject: prefectureName forKey: [NSString stringWithFormat: @"%i", PrefectureNameKey]];
                } break;
                case SHIPTAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", ShipNameKey]];
                } break;
                case YEARTAG:
                {
                    [shinAshiatoParameters setObject: tagKey forKey: [NSString stringWithFormat: @"%i", ImmigrationYearKey]];
                } break;
                default:break;
            }
        }
    }

    return shinAshiatoParameters;
}


-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
    TagParameters *tagParameters = [TagParameters getSharedInstance];
    
    if([segue.identifier isEqualToString:@"NameSurnameInputUnwindSegue"])
    {
        NSNumber *tagNumber = [NSNumber numberWithInteger: 0];
        if([self.windingActionID isEqualToString:@"InputNameSegue"])
        {
            tagNumber = [NSNumber numberWithInt: NAMETAG];
        }
        
        else if([self.windingActionID isEqualToString:@"InputSurnameSegue"])
        {
            tagNumber = [NSNumber numberWithInt: SURNAMETAG];
        }
        
        else if([self.windingActionID isEqualToString:@"InputNameKanjiSegue"])
        {
            tagNumber = [NSNumber numberWithInt: NAMEKANJITAG];
        }
        
        else if([self.windingActionID isEqualToString:@"InputSurnameKanjiSegue"])
        {
            tagNumber = [NSNumber numberWithInt: SURNAMEKANJITAG];
        }
        
        //Prevent repeated tags from being added
        NSString* parameter = tagParameters.parameter;
        
        if(![self.tagTypes objectForKey: parameter]){
            [self addTagWithTitle: parameter];
            [self.tagTypes setObject: tagNumber forKey: parameter];
        }
        
    }
    
    else if([segue.identifier isEqualToString:@"YearUnwindSegue"])
    {
        //Prevent repeated tags from being added
        NSString* parameter = tagParameters.parameter;
        
        if(![self.tagTypes objectForKey: parameter]){
            [self addTagWithTitle:tagParameters.parameter];
            [self.tagTypes setObject: [NSNumber numberWithInt: YEARTAG] forKey: tagParameters.parameter];
        }
    }
    
    else if([segue.identifier isEqualToString:@"PrefectureShipUnwindSegue"])
    {
        if([self.windingActionID isEqualToString:@"InputPrefectureSegue"])
        {
            //Prevent repeated tags from being added
            NSString* parameter = tagParameters.parameter;
            
            if(![self.tagTypes objectForKey: parameter]){
                [self addTagWithTitle:tagParameters.parameter];
                [self.tagTypes setObject: [NSNumber numberWithInt: PREFECTURETAG] forKey: tagParameters.parameter];}
        }
        
        else if([self.windingActionID isEqualToString:@"InputShipSegue"])
        {
            //Prevent repeated tags from being added
            NSString* parameter = tagParameters.parameter;
            
            if(![self.tagTypes objectForKey: parameter]){
                [self addTagWithTitle:tagParameters.parameter];
                [self.tagTypes setObject: [NSNumber numberWithInt: SHIPTAG] forKey: tagParameters.parameter];
            }
        }
        
    }
    
    //Deselect tableview cells, because user has aborted input action.
    //else if([segue.identifier isEqualToString:@""])
    /*
     CancelInputNameSurnameUnwindSegue
     CancelUnwindYearsSegue 
     CancelPrefectureShipUnwindSegue
     */
    
    else if([segue.identifier isEqualToString: @"CancelInputNameSurnameUnwindSegue"])
    {
        NameSurnameInputViewController* sourceViewController = (NameSurnameInputViewController*)segue.sourceViewController;
        NSString *sourceIdentifier = sourceViewController.segueID;
        
        if([sourceIdentifier isEqualToString:@"InputNameSegue"])
        {
            [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:1 inSection:0] animated:YES];
        }
        
        if([sourceIdentifier isEqualToString:@"InputSurnameSegue"])
        {
            [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:2 inSection:0] animated:YES];
        }
        
        if([sourceIdentifier isEqualToString:@"InputNameKanjiSegue"])
        {
            [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:8 inSection:0] animated:YES];
        }
        
        if([sourceIdentifier isEqualToString:@"InputSurnameKanjiSegue"])
        {
            [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:9 inSection:0] animated:YES];
        }
    }
    
    else if([segue.identifier isEqualToString: @"CancelUnwindYearsSegue"]){
        
        YearInputTableViewController* inputViewController = (YearInputTableViewController*)segue.sourceViewController;
        NSString *sourceIdentifier = inputViewController.segueID;

        if([sourceIdentifier isEqualToString:@"InputYearSegue"])
        {
            [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:6 inSection:0] animated:YES];
        }
    }
    
    else if([segue.identifier isEqualToString: @"CancelPrefectureShipUnwindSegue"])
    {
        PrefectureShipInputTableViewController* inputViewController = (PrefectureShipInputTableViewController*)segue.sourceViewController;
        NSString *sourceIdentifier = inputViewController.segueID;

        
        if([sourceIdentifier isEqualToString:@"InputPrefectureSegue"])
        {
            [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:4 inSection:0] animated:YES];
        }
        
        if([sourceIdentifier isEqualToString:@"InputShipSegue"])
        {
            [self.filterTypeSelectionTableView deselectRowAtIndexPath: [NSIndexPath indexPathForRow:5 inSection:0] animated:YES];
        }
    }
    
    else if([segue.identifier isEqualToString: @"SignOutUnwindSegue"])
    {
        NSError *signOutError;
        [[FIRAuth auth] signOut:&signOutError];
        [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self setWindingActionID:@""];
    [tagParameters resetInstance];
}

- (void)addTagWithTitle: (NSString*) title
{
    [_tagsView addTag:title];
}


- (IBAction)clearAllTapped:(id)sender
{
    [_tagsView deleteAllTags];
    [self.tagTypes removeAllObjects];
    for (NSInteger i = 0; i<11; i++)
    {
        [self.filterTypeSelectionTableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO];
    }
}


-(IBAction) searchImmigrant: (id) sender
{
    NSDictionary *shinAshiatoSearchParameters = [self createSearchParameters];
    if(shinAshiatoSearchParameters)
    {
        SearchParameters *searchParameters = [SearchParameters getSharedInstance];
        searchParameters.searchAshiatoParameters = shinAshiatoSearchParameters;
        [self performSegueWithIdentifier:@"SearchImmigrantSegue" sender:sender];
    }
    
    else
    {
        [self showAlertMessage:@"At least one parameter is needed."];
    }
}

- (void)showAlertMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - SWRevealViewController stuff
- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
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

#pragma mark - UITableView DataSource & Delegate

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    switch (indexPath.row)
    {
       
        case 0:
            cellIdentifier = @"NameSurnameSection";
            break;
        case 1:
            cellIdentifier = @"NameTableViewCell";
            break;
        case 2:
            cellIdentifier = @"SurnameTableViewCell";
            break;
        case 3:
            cellIdentifier = @"TripDetailsSection";
            break;
        case 4:
            cellIdentifier = @"PrefectureTableViewCell";
            break;
        case 5:
            cellIdentifier = @"ShipTableViewCell";
            break;
        case 6:
            cellIdentifier = @"YearTableViewCell";
            break;
        case 7:
            cellIdentifier = @"NihongoSection";
            break;
        case 8:
            cellIdentifier = @"NamaeTableViewCell";
            break;
        case 9:
            cellIdentifier = @"MyoujiTableViewCell";
            break;
        case 10:
            cellIdentifier = @"ClearAllTableViewCell";
            break;
        default:
            break;


            
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath: indexPath];
    
    return cell;

}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.isSelected) {
        self.shouldPerformSegueFromTableViewCell = NO;
    }
    
    return indexPath;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 10)
    {
        [self clearAllTapped:nil];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //use this for row u want to prevent to deSelect
    if(indexPath.row>0)
    {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch(indexPath.row)
    {
        case 0:
        case 3:
        case 7:
            return 15.0f;
        default:
            return 35.0f;
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //TODO: Review this.
    if ([[segue identifier] isEqualToString:@"InputNameSegue"])
    {
        UINavigationController* nameSurnameInputRootViewController = (UINavigationController*)segue.destinationViewController;
        NameSurnameInputViewController* nameSurnameInputViewController = (NameSurnameInputViewController*)[nameSurnameInputRootViewController.childViewControllers firstObject];
        
        nameSurnameInputViewController.navigationItem.title = @"Name";
        
        if(nameSurnameInputViewController)
        {
            [nameSurnameInputViewController setSegueID:@"InputNameSegue"];
        }
    }
    
    else if ([[segue identifier] isEqualToString:@"InputSurnameSegue"])
    {
        UINavigationController* nameSurnameInputRootViewController = (UINavigationController*)segue.destinationViewController;
        
        NameSurnameInputViewController* nameSurnameInputViewController = (NameSurnameInputViewController*)[nameSurnameInputRootViewController.childViewControllers firstObject];
        
        nameSurnameInputViewController.navigationItem.title = @"Surname";
        
        if(nameSurnameInputViewController)
        {
            [nameSurnameInputViewController setSegueID:@"InputSurnameSegue"];
        }
    }
    
    else if ([[segue identifier] isEqualToString:@"InputNameKanjiSegue"])
    {
        UINavigationController* nameSurnameInputRootViewController = (UINavigationController*)segue.destinationViewController;
        
        
        NameSurnameInputViewController* nameSurnameInputViewController = (NameSurnameInputViewController*)[nameSurnameInputRootViewController.childViewControllers firstObject];
        
        nameSurnameInputViewController.navigationItem.title = @"名前";
        
        if(nameSurnameInputViewController)
        {
            [nameSurnameInputViewController setSegueID:@"InputNameKanjiSegue"];
        }
    }
    
    else if ([[segue identifier] isEqualToString:@"InputSurnameKanjiSegue"])
    {
        UINavigationController* nameSurnameInputRootViewController = (UINavigationController*)segue.destinationViewController;
        
        nameSurnameInputRootViewController.navigationItem.title = @"名字";
        NameSurnameInputViewController* nameSurnameInputViewController = (NameSurnameInputViewController*)[nameSurnameInputRootViewController.childViewControllers firstObject];
        
        nameSurnameInputViewController.navigationItem.title = @"名字";
        
        if(nameSurnameInputViewController)
        {
            [nameSurnameInputViewController setSegueID:@"InputSurnameKanjiSegue"];
        }
    }
    
    
    else if ([[segue identifier] isEqualToString:@"InputYearSegue"])
    {
        UINavigationController* rootViewController = (UINavigationController*)segue.destinationViewController;
        YearInputTableViewController* yearInputTableViewController = (YearInputTableViewController*)[rootViewController.childViewControllers firstObject];
        
        yearInputTableViewController.navigationItem.title = @"Immigration Year";
        
        if(yearInputTableViewController)
        {
            [yearInputTableViewController setSegueID:@"InputYearSegue"];
        }
    }
    
    else if ([[segue identifier] isEqualToString:@"InputShipSegue"])
    {
        UINavigationController* rootViewController = (UINavigationController*)segue.destinationViewController;
        PrefectureShipInputTableViewController* shipInputTableViewController = (PrefectureShipInputTableViewController*)[rootViewController.childViewControllers firstObject];
        
        shipInputTableViewController.navigationItem.title = @"Ship";
        
        if(shipInputTableViewController)
        {
            [shipInputTableViewController setSegueID:@"InputShipSegue"];
        }
    }
    
    else if ([[segue identifier] isEqualToString:@"InputPrefectureSegue"])
    {
        UINavigationController* rootViewController = (UINavigationController*)segue.destinationViewController;
        PrefectureShipInputTableViewController* prefectureInputTableViewController = (PrefectureShipInputTableViewController*)[rootViewController.childViewControllers firstObject];
        
        prefectureInputTableViewController.navigationItem.title = @"Prefecture";
        
        if(prefectureInputTableViewController)
        {
            [prefectureInputTableViewController setSegueID:@"InputPrefectureSegue"];
        }
    }
    
    //Search
    else if ([[segue identifier] isEqualToString:@"SearchImmigrantSegue"])
    {
        NSArray *tagKeys = [self.tagTypes allKeys];
        SearchParameters* searchParameters = [SearchParameters getSharedInstance];
        for(NSString *tagKey in tagKeys)
        {
            NSNumber *tagKeyType = [self.tagTypes objectForKey: tagKey];
            NSInteger tagType = [tagKeyType integerValue];
            switch(tagType)
            {
                case  NAMETAG : searchParameters.immigrantName = tagKey;
                    break;
                case  SURNAMETAG : searchParameters.immigrantSurname = tagKey;
                    break;
                case  NAMEKANJITAG : searchParameters.immigrantNameKanji = tagKey;
                    break;
                case  SURNAMEKANJITAG: searchParameters.immigrantSurnameKanji = tagKey;
                    break;
                case  PREFECTURETAG: searchParameters.immigrantPrefecture = tagKey;
                    break;
                case  SHIPTAG: searchParameters.immigrantShip = tagKey;
                    break;
                case  YEARTAG:
                    searchParameters.immigrationYear = tagKey;
                    break;
                default: break;
                    
            }
            
        }
    }
    
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{

    return self.shouldPerformSegueFromTableViewCell;
}


//
//#pragma mark state preservation / restoration
//
//- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
//{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    
//    // Save what you need here
//    
//    [super encodeRestorableStateWithCoder:coder];
//}
//
//
//- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
//{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    
//    // Restore what you need here
//    
//    [super decodeRestorableStateWithCoder:coder];
//}
//
//
//- (void)applicationFinishedRestoringState
//{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//    
//    // Call whatever function you need to visually restore
//    [self customSetup];
//}

@end
