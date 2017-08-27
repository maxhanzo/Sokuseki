//
//  RegularSurnameTableViewCell.h
//  Sokuseki
//
//  Created by Ticket Services on 17/01/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//


#define MAXIMUM_BAR_WIDTH_SURNAMES 270.0f
#define MINIMUM_BAR_WIDTH 10.0f

#import <UIKit/UIKit.h>
#import "Surname.h"

@interface RegularSurnameTableViewCell : UITableViewCell


@property(nonatomic, weak) IBOutlet UILabel *lblSurname;
@property(nonatomic, weak) IBOutlet UIView *vwBar;
@property(nonatomic, strong) NSNumber *numberOfImmigrants;

-(void) setDataWithSurname: (Surname*) surname;
-(void) resizePercentageBarWithTotalValue: (NSNumber*) totalValue;
+(float) rowHeight;
@end
