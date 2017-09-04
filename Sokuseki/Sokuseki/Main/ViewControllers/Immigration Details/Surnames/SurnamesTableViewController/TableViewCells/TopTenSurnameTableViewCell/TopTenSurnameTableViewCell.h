//
//  TopTenSurnameTableViewCell.h
//  Sokuseki
//
//  Created by Ticket Services on 17/01/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#define MAXIMUM_BAR_WIDTH_TOPTEN 240.0f
#define MINIMUM_BAR_WIDTH 10.0f

#import <UIKit/UIKit.h>
#import "Surname.h"


@interface TopTenSurnameTableViewCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *lblRankingPosition;
@property(nonatomic, weak) IBOutlet UILabel *lblSurname;
@property(nonatomic, weak) IBOutlet UIView *vwBar;
@property(nonatomic, strong) NSNumber *numberOfImmigrants;

-(void) setDataWithSurname: (Surname*) surname withRankingPosition: (NSNumber*) rankingPosition;
-(void) resizePercentageBarWithTotalValue: (NSNumber*) totalValue;
-(void) setRanking: (NSInteger) ranking;
+(float) rowHeight;
@end
