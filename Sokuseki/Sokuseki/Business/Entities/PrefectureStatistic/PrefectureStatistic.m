//
//  Prefecture.m
//  Shin Ashiato
//
//  Created by Max Ueda on 8/19/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//


#import "PrefectureStatistic.h"

@implementation PrefectureStatistic
@synthesize name, numberOfImmigrants;
+(PrefectureStatistic*) prefectureWithName: (NSString*)prefectureName withNumberOfImmigrants: (NSNumber*)numberOfImmigrants
{
    PrefectureStatistic* prefecture = [[PrefectureStatistic alloc] init];
    [prefecture setName:prefectureName];
    [prefecture setNumberOfImmigrants:numberOfImmigrants];
    return prefecture;
}

+(PrefectureStatistic*) prefectureWithNumberOfImmigrants: (NSNumber*)numberOfImmigrants withName: (NSString*)prefectureName
{
    PrefectureStatistic* prefecture = [[PrefectureStatistic alloc] init];
    [prefecture setName:prefectureName];
    [prefecture setNumberOfImmigrants:numberOfImmigrants];
    return prefecture;
}
@end
