//
//  YearTableViewCell.h
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YearTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblYear;
-(float) rowHeight;
@end
