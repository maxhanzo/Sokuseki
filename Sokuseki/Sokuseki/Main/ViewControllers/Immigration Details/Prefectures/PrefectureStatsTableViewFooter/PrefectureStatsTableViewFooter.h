//
//  PrefectureStatsTableViewFooter.h
//  Sokuseki
//
//  Created by Max Ueda on 26/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrefectureStatsTableViewFooter : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblTotalRecords;
-(void) setTotalRecordsText: (NSString*) numberOfRecords withSuffix: (NSString*) suffix;
+(float) rowHeight;
@end
