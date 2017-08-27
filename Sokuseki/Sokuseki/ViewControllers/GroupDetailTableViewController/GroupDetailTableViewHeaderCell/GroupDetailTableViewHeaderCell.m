//
//  GroupDetailTableViewHeaderCell.m
//  Sokuseki
//
//  Created by Max Ueda on 12/18/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "GroupDetailTableViewHeaderCell.h"

@implementation GroupDetailTableViewHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setDataWithImmigrant:(Immigrant *)immigrant
{
    UIImage* prefectureFlag = [Utilities flagForPrefectureName:immigrant.prefectureName];
    [self.imgPrefectureFlag setImage: prefectureFlag];
//    NSString* prefectureSuffix = [Utilities prefectureSuffix:immigrant.prefectureName];
//    [self.lblPrefectureName setText: [[NSString stringWithFormat:@"%@%@", immigrant.prefectureName, prefectureSuffix] uppercaseString]];
    
    [self.lblPrefectureName setText:  [immigrant.prefectureName uppercaseString]];
    
    UIImage* transportIcon = [Utilities flagForShipName:(NSString*)immigrant.shipName];
    [self.imgTransport setImage: transportIcon];
    [self.lblShipName setText: (NSString*)immigrant.shipName];
    
    NSString *txtArrivalDate = [Utilities stringFromDate:immigrant.arrivalDate];
    NSString *txtDepartureDate = [Utilities stringFromDate:immigrant.departureDate];
    
    NSString *txtArrivalDeparture = [NSString stringWithFormat: @"%@ • %@", txtDepartureDate , txtArrivalDate];
    [self.lblDateArrivalDeparture setText: txtArrivalDeparture];
    
    [self.lblDestinationCityName setText: immigrant.destinationCity];
    [self.lblDestinationFarmName setText: (NSString*)immigrant.farmName];
    [self.lblRailLineName setText: immigrant.stationName];
}

+(float) rowHeight
{
    return 200.0f;
}
@end
