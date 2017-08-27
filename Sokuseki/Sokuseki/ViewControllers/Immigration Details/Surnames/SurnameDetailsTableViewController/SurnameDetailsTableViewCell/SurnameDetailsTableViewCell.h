//
//  SurnameDetailsTableViewCell.h
//  Sokuseki
//
//  Created by Ticket Services on 19/01/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurnameDetailsTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblSurnameKanji;
-(void) setSurnameKanji: (NSString*) kanji withNumberOfPeople: (NSNumber*) people;
+(float) rowHeight;
@end
