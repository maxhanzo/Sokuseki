//
//  Surname.m
//  Shin Ashiato
//
//  Created by Max Ueda on 9/14/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import "Surname.h"

@implementation Surname
@synthesize romaji, numberOfImmigrants, surnameID;


+(Surname*) surnameWithRomaji: (NSString*) romajiReading withNumberOfImmigrants: (NSNumber*) numberOfImmigrants withID: (NSUInteger) surnameID
{
    Surname *surname = [[Surname alloc] init];
    [surname setSurnameID:surnameID];
    [surname setRomaji:romajiReading];
    [surname setNumberOfImmigrants:numberOfImmigrants];
    
    return surname;
}


@end
