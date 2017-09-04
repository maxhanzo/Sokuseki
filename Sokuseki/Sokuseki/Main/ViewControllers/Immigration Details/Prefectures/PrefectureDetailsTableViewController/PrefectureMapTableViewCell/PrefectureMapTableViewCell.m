//
//  PrefectureMapTableViewCell.m
//  Sokuseki
//
//  Created by Max Ueda on 28/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "PrefectureMapTableViewCell.h"

@implementation PrefectureMapTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(float) rowHeight{
    return 166.0f;
}
@end
