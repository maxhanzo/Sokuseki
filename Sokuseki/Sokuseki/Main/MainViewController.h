//
//  ViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 12/13/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

#define NAMETAG 1
#define SURNAMETAG 2
#define NAMEKANJITAG 3
#define SURNAMEKANJITAG 4
#define PREFECTURETAG 5
#define SHIPTAG 6
#define YEARTAG 7

/*
 to-dō-fu-ken (都道府県?) in Japanese, which is a simple combination of the four terms.
 */
#define PREFECTURE_SUFFIX @"-Ken"

@interface MainViewController : UIViewController<SWRevealViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSString* windingActionID;
@property(nonatomic, strong) NSMutableDictionary* tagTypes;
@property(nonatomic, weak) IBOutlet UITableView *filterTypeSelectionTableView;


@property(nonatomic, weak) IBOutlet UIButton *btnNameInput;
@property(nonatomic, weak) IBOutlet UIButton *btnSurnameInput;
@property(nonatomic, weak) IBOutlet UIButton *btnNameKanjiInput;
@property(nonatomic, weak) IBOutlet UIButton *btnSurnameKanjiInput;
@property(nonatomic, weak) IBOutlet UIButton *btnShipInput;
@property(nonatomic, weak) IBOutlet UIButton *btnPrefectureInput;
@property(nonatomic, weak) IBOutlet UIButton *btnYearInput;

@end

