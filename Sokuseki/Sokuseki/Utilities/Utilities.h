//
//  Utilities.h
//  Sokuseki
//
//  Created by Max Ueda on 12/17/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"
#import "NSString+Score.h"
#import "NSString+Japanese.h"

@interface Utilities : NSObject


+(NSNumber*) numberFromString: (NSString*) stringValue withLocale: (NSLocale*) locale;
+(NSDate*) dateFromString: (NSString*) stringValue withLocale: (NSLocale*) locale;
+(NSString*) dateTimeNow;
+(NSString*) dateTimeThirtyDaysAgo;
+(NSString*) stringFromDate: (NSDate*) date;
+(NSString*) dbDateStringFromDate:(NSDate*) date;
+(NSDate*) dateFromString: (NSString*) stringValue;
+(BOOL) isParameterPrefecture: (NSString*) parameter;
+(BOOL) isParameterShip: (NSString*) parameter;
+(BOOL) isParameterKanji: (NSString*) parameter;
+(NSString*) stringFromParameterType: (int) parameter;
+(UIImage*) imageFromParameterType: (int) parameter;
+(NSString*) deSQLizer: (NSString*) parameter;
+(UIImage*) flagForPrefectureID: (NSUInteger) prefectureID;
+(UIImage*) flagForPrefectureName: (NSString*) prefectureName;
+(NSString*) aliasFromFullName: (NSString*) fullName withLength: (NSUInteger) length;
+(NSDictionary*) headerTitlesforNamesCollection: (NSArray*) collection;
+(UIImage*) flagForShipName: (NSString*) shipName;
+(NSString*) prefectureSuffix: (NSString*) prefectureName;
+(NSString*) removePrefectureSuffix: (NSString*) prefectureName;
+(NSString*) cardinalNumber: (NSNumber*) number;
+(UIImage*) pictureForShipName: (NSString*) shipName withJourneyDate: (NSDate*)date;
@end
