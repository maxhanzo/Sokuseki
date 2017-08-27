//
//  ImmigrantDetailTableViewCell.m
//  Sokuseki
//
//  Created by Max Ueda on 12/18/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ImmigrantDetailTableViewCell.h"

@implementation ImmigrantDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setDataWithImmigrant: (Immigrant*) immigrant
{
    [self.lblNameKanji setText: [NSString stringWithFormat: @"%@%@", immigrant.surnameKanji, immigrant.nameKanji] ];
    [self.lblNameRomaji setText: [NSString stringWithFormat:@"%@ %@", immigrant.nameRomaji, immigrant.surnameRomaji]];
}

+(float) rowHeight
{
    return 65.0f;
}
@end
