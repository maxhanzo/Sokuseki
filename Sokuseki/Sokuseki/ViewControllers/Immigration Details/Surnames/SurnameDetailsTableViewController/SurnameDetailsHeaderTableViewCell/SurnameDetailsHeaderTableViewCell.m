//
//  SurnameDetailsHeaderTableViewCell.m
//  Sokuseki
//
//  Created by Ticket Services on 19/01/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import "SurnameDetailsHeaderTableViewCell.h"
#import "Utilities.h"
@implementation SurnameDetailsHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setHeaderWithRomaji: (NSString*) romaji withRanking: (NSNumber*) ranking withPossibleWritings: (NSNumber*) possibleWritings withOccurences: (NSNumber*) occurences
{
    [self.lblSurnameRomaji setText: romaji];
    NSString *rankingInfo = [NSString stringWithFormat: @"Ranking: %@ place", [Utilities cardinalNumber:ranking]];
    [self.lblRanking setText: rankingInfo];
    NSString *waysToWrite = [NSString stringWithFormat: @"Ways to write: %@", [possibleWritings stringValue]];
    [self.lblPossibleWritings setText: waysToWrite];
    NSString *numberOfPeople = [NSString stringWithFormat: @"%@ People", [occurences stringValue]];
    [self.lblOccurences setText:numberOfPeople];
}

+(float) rowHeight
{
    return 170.0f;
}
@end
