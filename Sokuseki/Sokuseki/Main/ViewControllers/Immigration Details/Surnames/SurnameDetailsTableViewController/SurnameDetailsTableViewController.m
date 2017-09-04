//
//  SurnameDetailsTableViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 30/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "SurnameDetailsTableViewController.h"
#import "SurnameDetailsHeaderTableViewCell.h"
#import "SurnameDetailsTableViewCell.h"
#import "SurnameDetail.h"
#import "DBManager.h"

@interface SurnameDetailsTableViewController ()

@end

@implementation SurnameDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DBManager *dbManager = [DBManager getSharedInstance];
    self.surnamesArray = [NSArray array];
    if(self.surname)
    {
        self.surnamesArray = [dbManager retrieveSurnameDetailsFromSurname: self.surname];
    }
    
    if(!self.ranking)
    {
        self.ranking = @0;
    }
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
    return [self.surnamesArray count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if(indexPath.row == 0)
    {
        SurnameDetailsHeaderTableViewCell *cell = (SurnameDetailsHeaderTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"SurnameDetailsHeaderTableViewCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SurnameDetailsHeaderTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        NSNumber* possibleWritings = [NSNumber numberWithInteger: [self.surnamesArray count]];
        
        [cell setHeaderWithRomaji:self.surname.romaji withRanking:self.ranking withPossibleWritings: possibleWritings withOccurences:self.surname.numberOfImmigrants];
        
        return cell;
    }
    
    else
    {
        SurnameDetailsTableViewCell *cell = (SurnameDetailsTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"SurnameDetailsTableViewCell"];
    
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SurnameDetailsTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSInteger surnameIndex = indexPath.row - 1;
        SurnameDetail* surnameDetail = [self.surnamesArray objectAtIndex: surnameIndex];
       
        if(surnameDetail)
        {
            [cell setSurnameKanji:surnameDetail.kanjiReading withNumberOfPeople:surnameDetail.numberOfImmigrants];
        }
        
        return cell;
        
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 0)
    {
        return [SurnameDetailsTableViewCell rowHeight];
    }
    
    return [SurnameDetailsHeaderTableViewCell rowHeight];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}


@end
