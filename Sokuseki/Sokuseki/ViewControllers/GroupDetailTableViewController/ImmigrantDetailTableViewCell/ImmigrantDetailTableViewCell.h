//
//  ImmigrantDetailTableViewCell.h
//  Sokuseki
//
//  Created by Max Ueda on 12/18/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Immigrant.h"
@interface ImmigrantDetailTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblNameRomaji;
@property(nonatomic, weak) IBOutlet UILabel *lblNameKanji;
-(void) setDataWithImmigrant: (Immigrant*) immigrant;

+(float) rowHeight;
@end
