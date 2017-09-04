//
//  NameSurnameInputViewController.h
//  Sokuseki
//
//  Created by Max Ueda  on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameSurnameInputViewController : UITableViewController<UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property(nonatomic, strong) NSArray *textEntries;
@property(nonatomic, strong) NSMutableArray *textSuggestions;

@property(nonatomic, weak) IBOutlet UITextField *txtInputNameSurname;
@property(nonatomic, strong) NSString *segueID;
-(IBAction)inputNameSurname:(id)sender;

@end
