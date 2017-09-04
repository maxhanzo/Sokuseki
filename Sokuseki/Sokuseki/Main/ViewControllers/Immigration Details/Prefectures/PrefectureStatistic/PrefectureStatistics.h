//
//  PrefectureStatistics.h
//  Sokuseki
//
//  Created by Max Ueda on 26/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrefectureStatistics : NSObject
@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSNumber* numberOfImmigrants;

+(PrefectureStatistics*) prefectureWithName: (NSString*)prefectureName withNumberOfImmigrants: (NSNumber*)numberOfImmigrants;

+(PrefectureStatistics*) prefectureWithNumberOfImmigrants: (NSNumber*)numberOfImmigrants withName: (NSString*)prefectureName;

@end



