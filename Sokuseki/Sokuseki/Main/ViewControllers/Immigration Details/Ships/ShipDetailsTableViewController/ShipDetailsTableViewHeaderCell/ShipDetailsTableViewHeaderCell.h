//
//  ShipDetailsTableViewHeaderCell.h
//  Sokuseki
//
//  Created by Ticket Services on 26/01/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShipDetailsTableViewHeaderCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UIImageView *imgShipAvatar;
@property(nonatomic, weak) IBOutlet UILabel *lblShipCompany;
+(float) rowHeight;
@end
