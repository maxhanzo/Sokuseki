//
//  PrefectureFlagTableViewCell.m
//  Sokuseki
//
//  Created by Max Ueda on 28/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "PrefectureFlagTableViewCell.h"

@implementation PrefectureFlagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+(float) rowHeight{
    return 43.0f;
}

@end
