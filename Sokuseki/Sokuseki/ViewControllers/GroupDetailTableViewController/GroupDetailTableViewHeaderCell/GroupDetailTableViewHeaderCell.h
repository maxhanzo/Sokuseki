//
//  GroupDetailTableViewHeaderCell.h
//  Sokuseki
//
//  Created by Max Ueda on 12/18/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Immigrant.h"
#import "Utilities.h"
@interface GroupDetailTableViewHeaderCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UIImageView *imgPrefectureFlag;
@property(nonatomic, weak) IBOutlet UIImageView *imgTransport;
@property(nonatomic, weak) IBOutlet UILabel *lblPrefectureName;
@property(nonatomic, weak) IBOutlet UILabel *lblDateArrivalDeparture;
@property(nonatomic, weak) IBOutlet UILabel *lblShipName;
@property(nonatomic, weak) IBOutlet UILabel *lblDestinationCityName;
@property(nonatomic, weak) IBOutlet UILabel *lblRailLineName;
@property(nonatomic, weak) IBOutlet UILabel *lblDestinationFarmName;

-(void) setDataWithImmigrant: (Immigrant*) immigrant;

+(float) rowHeight;

@end
