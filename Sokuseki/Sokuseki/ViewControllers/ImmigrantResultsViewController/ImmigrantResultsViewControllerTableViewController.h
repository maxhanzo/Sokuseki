//
//  ImmigrantResultsViewControllerTableViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Immigrant.h"

@interface ImmigrantResultsViewControllerTableViewController : UITableViewController
@property(nonatomic, strong) NSArray *immigrantResults;
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property(nonatomic, strong) Immigrant *selectedImmigrant;

@end
