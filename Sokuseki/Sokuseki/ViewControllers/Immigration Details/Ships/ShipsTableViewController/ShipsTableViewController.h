//
//  ShipsTableViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 30/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface ShipsTableViewController : UITableViewController<SWRevealViewControllerDelegate>
@property(nonatomic, strong) NSArray *shipsArray;

@end
