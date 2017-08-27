//
//  PrefectureTableViewCell.m
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "PrefectureTableViewCell.h"

@implementation PrefectureTableViewCell

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
    [self.lblPrefectureName setText: name];
    [self.imgPrefectureFlag setImage: flag];
}


+(float) rowHeight
{
    return 43.5f;
}


@end
