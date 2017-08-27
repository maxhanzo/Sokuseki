//
//  SurnamesTableViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 30/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "TopTenSurnameTableViewCell.h"
#import "RegularSurnameTableViewCell.h"
#import "Surname.h"


@interface SurnamesTableViewController : UITableViewController<SWRevealViewControllerDelegate>
@property(nonatomic, strong)  UISearchController *searchController;
@property(nonatomic, strong) UITableView *resultsTableController;
@property(nonatomic, strong) Surname *selectedSurname;
@property(nonatomic, strong) NSNumber *surnameRanking;


@end
