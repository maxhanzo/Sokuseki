//
//  ShipDetailsTableViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 30/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Voyage.h"
#import "Steamer.h"

@interface ShipDetailsTableViewController : UITableViewController
@property(nonatomic, strong) Steamer* steamer;
@property(nonatomic, strong) NSArray *shipJourneys;
-(NSInteger) totalPassengers;
@end
