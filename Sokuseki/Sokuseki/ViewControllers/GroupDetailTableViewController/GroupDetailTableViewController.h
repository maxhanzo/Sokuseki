//
//  GroupDetailTableViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 12/18/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Immigrant.h"

@interface GroupDetailTableViewController : UITableViewController
@property(nonatomic, strong) NSArray *immigrantGroupResults;
@property(nonatomic, strong) Immigrant* selectedImmigrant;
@end
