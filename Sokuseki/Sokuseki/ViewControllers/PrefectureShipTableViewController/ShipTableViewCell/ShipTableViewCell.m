//
//  ShipTableViewCell.m
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ShipTableViewCell.h"
#import "Utilities.h"
@implementation ShipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setName: (NSString*) name withFlag: (UIImage*) flag
{
    [self.lblShipName setText: name];
    [self.imgShipFlag setImage: flag];
}

-(void) setDataWithName: (NSString*) name
{
    [self.lblShipName setText: name];
    UIImage *shipFlag = [Utilities flagForShipName:name];
    
    if(shipFlag)
    {
        [self.imgShipFlag setImage: shipFlag];
    }
    
}


+(float) rowHeight
{
    return 43.5f;
}

@end
