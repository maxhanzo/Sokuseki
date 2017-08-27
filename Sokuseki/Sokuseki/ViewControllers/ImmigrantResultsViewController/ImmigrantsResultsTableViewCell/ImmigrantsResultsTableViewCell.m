//
//  ImmigrantsResultsTableViewCell.m
//  Sokuseki
//
//  Created by Max Ueda on 12/17/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ImmigrantsResultsTableViewCell.h"

@implementation ImmigrantsResultsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setDataFromImmigrant: (Immigrant*) immigrant
{
    self.lblImmigrantName.text = [NSString stringWithFormat: @"%@ %@ (%@%@)", immigrant.nameRomaji,
                                   immigrant.surnameRomaji, immigrant.surnameKanji, immigrant.nameKanji];
    
    self.lblPrefectureYear.text = [NSString stringWithFormat: @"%@ •%@• %@", immigrant.prefectureName, [NSString stringWithFormat: @"%i", immigrant.getYear], immigrant.shipName];
}



+(float) rowHeight
{
    return 60.0f;
}

@end
