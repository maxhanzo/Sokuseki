//
//  PrefectureStatsTableViewFooter.m
//  Sokuseki
//
//  Created by Max Ueda on 26/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "PrefectureStatsTableViewFooter.h"

@implementation PrefectureStatsTableViewFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setTotalRecordsText: (NSString*) numberOfRecords withSuffix: (NSString*) suffix
{
    NSString *txtMessage = [NSString stringWithFormat: @"%@ %@", numberOfRecords, suffix];
    [self.lblTotalRecords setText: txtMessage];
}
+(float) rowHeight
{
    return 40.0f;
}
@end
