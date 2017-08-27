//
//  PrefectureStatistics.m
//  Sokuseki
//
//  Created by Max Ueda on 26/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "PrefectureStatistics.h"

@implementation PrefectureStatistics

@synthesize name, numberOfImmigrants;
+(PrefectureStatistics*) prefectureWithName: (NSString*)prefectureName withNumberOfImmigrants: (NSNumber*)numberOfImmigrants
{
    PrefectureStatistics* prefecture = [[PrefectureStatistics alloc] init];
    [prefecture setName:prefectureName];
    [prefecture setNumberOfImmigrants:numberOfImmigrants];
    return prefecture;
}

+(PrefectureStatistics*) prefectureWithNumberOfImmigrants: (NSNumber*)numberOfImmigrants withName: (NSString*)prefectureName
{
    PrefectureStatistics* prefecture = [[PrefectureStatistics alloc] init];
    [prefecture setName:prefectureName];
    [prefecture setNumberOfImmigrants:numberOfImmigrants];
    return prefecture;
}

 @end
 
 
