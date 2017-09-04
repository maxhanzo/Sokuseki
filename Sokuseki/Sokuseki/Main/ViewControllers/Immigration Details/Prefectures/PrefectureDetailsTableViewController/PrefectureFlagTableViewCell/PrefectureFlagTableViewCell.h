//
//  PrefectureFlagTableViewCell.h
//  Sokuseki
//
//  Created by Max Ueda on 28/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrefectureFlagTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UIImageView *imgPrefectureFlag;
+(float) rowHeight;
@end
