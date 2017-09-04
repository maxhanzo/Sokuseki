//
//  SurnameDetailsTableViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 30/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Surname.h"

@interface SurnameDetailsTableViewController : UITableViewController
@property(nonatomic, strong) Surname *surname;
@property(nonatomic, strong) NSArray* surnamesArray;
@property(nonatomic, strong) NSNumber* ranking;
@end
