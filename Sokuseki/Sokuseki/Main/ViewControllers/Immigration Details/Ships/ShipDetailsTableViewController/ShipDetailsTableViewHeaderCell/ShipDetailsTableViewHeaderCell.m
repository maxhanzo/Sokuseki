//
//  ShipDetailsTableViewHeaderCell.m
//  Sokuseki
//
//  Created by Ticket Services on 26/01/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import "ShipDetailsTableViewHeaderCell.h"

@implementation ShipDetailsTableViewHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(float) rowHeight
{
    return 180.0f;
}
@end
