//
//  GroupDetailTableViewFooterCell.h
//  Sokuseki
//
//  Created by Max Ueda on 12/26/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetailTableViewFooterCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblTotalPeople;
-(void) setTotalPeopleText: (NSString*) totalRecords;
-(void) setTotalRecordsText: (NSString*) totalRecords;
-(void) setTotalRecordsText: (NSString*) totalRecords withTotalPassengers: (NSString*) totalPassengers;
+(float)rowHeight;

@end
