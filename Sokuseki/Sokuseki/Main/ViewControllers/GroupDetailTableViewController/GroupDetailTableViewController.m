//
//  GroupDetailTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 12/18/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "GroupDetailTableViewController.h"
#import "ImmigrantDetailTableViewCell.h"
#import "GroupDetailTableViewHeaderCell.h"
#import "GroupDetailTableViewFooterCell.h"
#import "DBManager.h"

@interface GroupDetailTableViewController ()

@end

@implementation GroupDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
        
        NSArray* searchResults  = [DBManager searchImmigrantWithGroupID:(long)self.selectedImmigrant.getGroupID];
        if(searchResults)
        {
            if([searchResults count]>0)
                dispatch_async(dispatch_get_main_queue(),^{
                    self.immigrantGroupResults = searchResults;
                    [self.tableView reloadData];
                });
        }
        
    });
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
    NSInteger results = [self.immigrantGroupResults count];
    if(results!=0)
    {
        return results + 2;
    }
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger results = [self.immigrantGroupResults count];
    
    NSInteger footerIndex = results + 1;
    if(indexPath.row == 0)
    {
        GroupDetailTableViewHeaderCell *cell = (GroupDetailTableViewHeaderCell*)[tableView dequeueReusableCellWithIdentifier:@"GroupDetailTableViewHeaderCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GroupDetailTableViewHeaderCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setDataWithImmigrant:self.selectedImmigrant];
        
        return cell;
    }
    
    else if(indexPath.row == footerIndex)
    {
        GroupDetailTableViewFooterCell *cell = (GroupDetailTableViewFooterCell*)[tableView dequeueReusableCellWithIdentifier:@"GroupDetailTableViewFooterCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GroupDetailTableViewFooterCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setTotalPeopleText: [NSString stringWithFormat: @"%li", results]];
        
        return cell;

    }
    else
    {
        ImmigrantDetailTableViewCell *cell = (ImmigrantDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ImmigrantDetailTableViewCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ImmigrantDetailTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        Immigrant *immigrant = [self.immigrantGroupResults objectAtIndex: (indexPath.row -1)];
        [cell setDataWithImmigrant:immigrant];
        
        return cell;
    }
    
    
    
    
    
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger footerIndex = [self.immigrantGroupResults count] + 1 ;
    
    if(indexPath.row == 0)
    {
        return [GroupDetailTableViewHeaderCell rowHeight];
    }
    
    else if(indexPath.row == footerIndex)
    {
        return [GroupDetailTableViewFooterCell rowHeight];
    }
    
    else
    {
        return [ImmigrantDetailTableViewCell rowHeight];
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
