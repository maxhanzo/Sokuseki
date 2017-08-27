//
//  YearInputTableViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YearInputTableViewController : UITableViewController

@property(nonatomic, strong) NSArray *immigrationYears;
@property(nonatomic, strong) NSString *segueID;
+(NSArray*) generateYears: (NSInteger) fromYear to:(NSInteger) toYear;
@end
