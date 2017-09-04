//
//  PrefectureListTableViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 26/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface PrefectureListTableViewController : UITableViewController<SWRevealViewControllerDelegate>


@property(nonatomic, strong) NSMutableArray *prefectureArray;
@property(nonatomic, strong) NSArray *prefectureDataSource;

@property(nonatomic, assign) NSInteger topMostNumberOfImmigrants;
@property(nonatomic, assign) BOOL desc;





@end
