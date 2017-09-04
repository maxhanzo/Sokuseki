//
//  PrefectureNameTableViewCell.h
//  Sokuseki
//
//  Created by Max Ueda on 28/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrefectureNameTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblPrefectureKanjiName;
@property(nonatomic, weak) IBOutlet UILabel *lblPrefectureRomajiName;
+(float) rowHeight;
@end
