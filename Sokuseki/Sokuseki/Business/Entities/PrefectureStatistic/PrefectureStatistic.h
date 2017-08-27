//
//  Prefecture.h
//  Shin Ashiato
//
//  Created by Max Ueda on 8/19/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface PrefectureStatistic : NSObject
@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSNumber* numberOfImmigrants;

+(PrefectureStatistic*) prefectureWithName: (NSString*)prefectureName withNumberOfImmigrants: (NSNumber*)numberOfImmigrants;

+(PrefectureStatistic*) prefectureWithNumberOfImmigrants: (NSNumber*)numberOfImmigrants withName: (NSString*)prefectureName;
@end
