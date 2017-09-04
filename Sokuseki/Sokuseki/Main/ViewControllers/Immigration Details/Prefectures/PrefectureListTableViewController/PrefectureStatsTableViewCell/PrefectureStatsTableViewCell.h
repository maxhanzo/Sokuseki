//
//  PrefectureStatsTableViewCell.h
//  Sokuseki
//
//  Created by Max Ueda on 26/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefectureStatistics.h"

#define MAXIMUM_BAR_WIDTH 240.0f
#define MINIMUM_BAR_WIDTH 10.0f

@interface PrefectureStatsTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblPrefectureName;
@property(nonatomic, weak) IBOutlet UIImageView *imgPrefectureFlag;
@property(nonatomic, weak) IBOutlet UIView *vwBarView;
@property(nonatomic, assign) NSUInteger numberOfPeople;


-(void) resizePercentageBarWithTotalValue: (NSNumber*) totalValue;
-(void) setPrefectureDataWithName: (NSString*) prefectureName withNumberOfImmigrants: (NSNumber*) numberOfImmigrants;
-(void) setPrefectureDataWithPrefecture: (PrefectureStatistics*) prefecture;
-(void) setBarColor: (UIColor*) color;
+(float) rowHeight;

@end


