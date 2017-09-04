//
//  RegularSurnameTableViewCell.m
//  Sokuseki
//
//  Created by Ticket Services on 17/01/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import "RegularSurnameTableViewCell.h"
#import "Surname.h"

@implementation RegularSurnameTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void) setDataWithSurname: (Surname*) surname 
{
    NSString *surnameData = [NSString stringWithFormat: @"%@ • %@", surname.romaji, [surname.numberOfImmigrants stringValue]];
    self.lblSurname.text = surnameData;
    self.numberOfImmigrants = surname.numberOfImmigrants;
    
}


-(void) resizePercentageBarWithTotalValue: (NSNumber*) totalValue
{
    float currentNumber = [self.numberOfImmigrants floatValue];
    float total = [totalValue floatValue];
    float percentage = (currentNumber*100)/total;
    
    CGFloat barNewWidth = MAXIMUM_BAR_WIDTH_SURNAMES*percentage/100;
    
    if(barNewWidth < MINIMUM_BAR_WIDTH)
    {
        barNewWidth = MINIMUM_BAR_WIDTH;
    }
    
    
    self.vwBar.frame = CGRectMake(self.vwBar.frame.origin.x, self.vwBar.frame.origin.y, barNewWidth, self.vwBar.frame.size.height);}


+(float) rowHeight
{
    return 44.0f;
}
@end
