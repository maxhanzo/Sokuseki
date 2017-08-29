//
//  ShipsTableViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 30/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface ShipsTableViewController : UITableViewController<SWRevealViewControllerDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property(nonatomic, strong)  UISearchController *searchController;
@property(nonatomic, strong) NSArray *textEntries;
@property(nonatomic, strong) NSMutableArray *shipsSuggestions;

@property(nonatomic, strong) NSArray *shipsArray;

@end
