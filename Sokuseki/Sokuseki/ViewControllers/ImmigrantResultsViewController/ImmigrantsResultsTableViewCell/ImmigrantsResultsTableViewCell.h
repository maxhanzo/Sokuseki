//
//  ImmigrantsResultsTableViewCell.h
//  Sokuseki
//
//  Created by Max Ueda on 12/17/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Immigrant.h"

@interface ImmigrantsResultsTableViewCell : UITableViewCell
{
    NSInteger groupID;
}
@property(nonatomic, weak) IBOutlet UILabel* lblImmigrantName;
@property(nonatomic, weak) IBOutlet UILabel* lblPrefectureYear;

-(void) setDataFromImmigrant: (Immigrant*) immigrant;


+(float) rowHeight;
@end
