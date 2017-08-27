//
//  PrefectureRegionDetailsTableViewCell.h
//  Sokuseki
//
//  Created by Max Ueda on 28/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrefectureRegionDetailsTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblCapitalCity;
@property(nonatomic, weak) IBOutlet UILabel *lblIslandName;
@property(nonatomic, weak) IBOutlet UILabel *lblRegionName;
@property(nonatomic, weak) IBOutlet UILabel *lblArea;
+(float) rowHeight;
@end
