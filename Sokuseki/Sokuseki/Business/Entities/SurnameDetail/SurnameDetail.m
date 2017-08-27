//
//  SurnameDetail.m
//  Shin Ashiato
//
//  Created by Max Ueda on 9/23/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import "SurnameDetail.h"

@implementation SurnameDetail
+(SurnameDetail*) detailWithKanjiReading: (NSString*) kanjiReading withNumberOfImmigrants: (NSNumber*)numberOfImmigrantes
{
    SurnameDetail *surnameDetail = [[SurnameDetail alloc] init];
    [surnameDetail setKanjiReading: kanjiReading];
    [surnameDetail setNumberOfImmigrants:numberOfImmigrantes];
    return surnameDetail;    
}
@end
