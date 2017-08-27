//
//  PrefectureInfo.h
//  Shin Ashiato
//
//  Created by Max Ueda on 9/21/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PrefectureInfo : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *capital;
@property(nonatomic, strong) NSString *region;
@property(nonatomic, strong) NSString *island;
@property(nonatomic, strong) UIImage *map;
@property(nonatomic, strong) UIImage *flag;
@property(nonatomic, strong) NSNumber *area;
@property(nonatomic, strong) NSString* kanji;

+(PrefectureInfo*) prefectureInfoWithName: (NSString*) name withCapital: (NSString*) capital withRegion: (NSString*) region withIsland: (NSString*) island withArea: (NSNumber*) area withFlag: (NSString*) flagFilename withMap: (NSString*) mapFilename withKanji: (NSString*) kanji;

@end
