//
//  ImmigrantsResultsTableViewFooter.m
//  Sokuseki
//
//  Created by Max Ueda on 12/17/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ImmigrantsResultsTableViewFooter.h"

@implementation ImmigrantsResultsTableViewFooter

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
    return 43.0f;
}

@end
