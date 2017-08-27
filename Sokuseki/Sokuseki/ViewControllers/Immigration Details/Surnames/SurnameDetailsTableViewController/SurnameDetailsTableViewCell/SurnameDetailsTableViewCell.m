//
//  SurnameDetailsTableViewCell.m
//  Sokuseki
//
//  Created by Ticket Services on 19/01/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import "SurnameDetailsTableViewCell.h"

@implementation SurnameDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setSurnameKanji: (NSString*) kanji withNumberOfPeople: (NSNumber*) people
{
    //Later: When thinking of globalization stuff, consider developing a method that deals whith
    //language. For example: 4 People, 4 Pessoas, 4人, etc.
    NSString *suffix = @" People";
    NSString *surnameInfo = [NSString stringWithFormat: @"%@ • %@%@", kanji, [people stringValue], suffix];
    [self.lblSurnameKanji setText: surnameInfo];
}

+(float) rowHeight
{
    return 44.0f;
}
@end
