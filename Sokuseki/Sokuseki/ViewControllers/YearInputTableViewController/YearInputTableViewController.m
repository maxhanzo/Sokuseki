//
//  YearInputTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "YearInputTableViewController.h"
#import "YearTableViewCell.h"
#import "MainViewController.h"
#import "TagParameters.h"

@interface YearInputTableViewController ()

@end

@implementation YearInputTableViewController

@synthesize segueID;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"YearUnwindSegue"])
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
    

    self.immigrationYears = [YearInputTableViewController generateYears:1908 to:1984];

    
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
    return  [self.immigrationYears count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YearTableViewCell *cell = (YearTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"YearTableViewCell"];
    
    if(!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YearTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell.lblYear setText: [self.immigrationYears objectAtIndex: indexPath.row]];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TagParameters *tagParameters = [TagParameters getSharedInstance];
    [tagParameters setParameter: [self.immigrationYears objectAtIndex: indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"YearUnwindSegue" sender:self];
}

//Prevent extra separators from appearing
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Initialization methods
+(NSArray*) generateYears: (NSInteger) fromYear to:(NSInteger) toYear
{
    NSMutableArray *immigrationYears = [NSMutableArray array];
    for (NSInteger i = fromYear; i<(toYear + 1); i++)
    {
        NSNumber *year = [NSNumber numberWithInteger: i];
        [immigrationYears addObject:[year stringValue]];
    }
    
    return immigrationYears;
}
@end
