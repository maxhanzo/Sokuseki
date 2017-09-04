//
//  SearchParameters.h
//  Sokuseki
//
//  Created by Max Ueda on 12/15/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#define FILTER_STATE_FILENAME_SEARCH @"filterStateSearchParameters.dat"

@interface SearchParameters : NSObject

+(SearchParameters*)getSharedInstance;

@property(nonatomic, strong) NSString *immigrantName;
@property(nonatomic, strong) NSString *immigrantSurname;
@property(nonatomic, strong) NSString *immigrantNameKanji;
@property(nonatomic, strong) NSString *immigrantSurnameKanji;
@property(nonatomic, strong) NSString *immigrantPrefecture;
@property(nonatomic, strong) NSString *immigrantShip;
@property(nonatomic, strong) NSString *immigrationYear;
//Legacy adaptation
@property(nonatomic, strong) NSDictionary *searchAshiatoParameters;

-(void) resetInstance;

//Saving & loading state
- (void)saveState;
//back from background: filter is loaded.
- (void)loadState;
//If user signs out.
-(void) deleteFile;
@end
