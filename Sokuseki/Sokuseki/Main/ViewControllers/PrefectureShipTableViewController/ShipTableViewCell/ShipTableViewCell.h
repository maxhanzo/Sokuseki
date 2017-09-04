//
//  ShipTableViewCell.h
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShipTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblShipName;
@property(nonatomic, weak) IBOutlet UIImageView *imgShipFlag;

+(float) rowHeight;
-(void) setName: (NSString*) name withFlag: (UIImage*) flag;
-(void) setDataWithName: (NSString*) name;

@end
