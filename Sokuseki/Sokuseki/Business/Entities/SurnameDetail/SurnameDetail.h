//
//  SurnameDetail.h
//  Shin Ashiato
//
//  Created by Max Ueda on 9/23/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurnameDetail : NSObject
@property(nonatomic, strong) NSString* kanjiReading;
@property(nonatomic, strong) NSNumber* numberOfImmigrants;

+(SurnameDetail*) detailWithKanjiReading: (NSString*) kanjiReading withNumberOfImmigrants: (NSNumber*)numberOfImmigrantes;
@end
