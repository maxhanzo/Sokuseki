//
//  ImmigrantsResultsTableViewFooter.h
//  Sokuseki
//
//  Created by Max Ueda on 12/17/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImmigrantsResultsTableViewFooter : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel* lblTotalRecords;
+(float) rowHeight;
@end
