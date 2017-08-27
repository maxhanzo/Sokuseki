//
//  Surname.h
//  Shin Ashiato
//
//  Created by Max Ueda on 9/14/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Surname : NSObject
@property(nonatomic, assign) NSUInteger surnameID;
@property(nonatomic,strong) NSString* romaji;
@property(nonatomic,strong) NSNumber* numberOfImmigrants;

+(Surname*) surnameWithRomaji: (NSString*) romajiReading withNumberOfImmigrants: (NSNumber*) numberOfImmigrants withID: (NSUInteger) surnameID;

@end
