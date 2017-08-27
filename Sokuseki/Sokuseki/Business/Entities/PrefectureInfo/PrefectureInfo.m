//
//  PrefectureInfo.m
//  Shin Ashiato
//
//  Created by Max Ueda on 9/21/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import "PrefectureInfo.h"

@implementation PrefectureInfo
@synthesize name, capital, area, region, island, flag, map, kanji;

+(PrefectureInfo*) prefectureInfoWithName: (NSString*) name withCapital: (NSString*) capital withRegion: (NSString*) region withIsland: (NSString*) island withArea: (NSNumber*) area withFlag: (NSString*) flagFilename withMap: (NSString*) mapFilename withKanji: (NSString*) kanji
{
    PrefectureInfo *prefectureInfo = [[PrefectureInfo alloc]init];
    [prefectureInfo setName: name];
    [prefectureInfo setCapital:capital];
    [prefectureInfo setArea: area];
    [prefectureInfo setRegion: region];
    [prefectureInfo setIsland:island];
    [prefectureInfo setFlag:[UIImage imageNamed: flagFilename]];
    [prefectureInfo setMap: [UIImage imageNamed: mapFilename]];
    [prefectureInfo setKanji: kanji];
    
    return prefectureInfo;
}
@end
