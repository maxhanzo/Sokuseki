//
//  SurnameDetailsHeaderTableViewCell.h
//  Sokuseki
//
//  Created by Ticket Services on 19/01/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurnameDetailsHeaderTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblSurnameRomaji;
@property(nonatomic, weak) IBOutlet UILabel *lblRanking;
@property(nonatomic, weak) IBOutlet UILabel *lblPossibleWritings;
@property(nonatomic, weak) IBOutlet UILabel *lblOccurences;

-(void) setHeaderWithRomaji: (NSString*) romaji withRanking: (NSNumber*) ranking withPossibleWritings: (NSNumber*) possibleWritings withOccurences: (NSNumber*) occurences;
+(float) rowHeight;
@end
