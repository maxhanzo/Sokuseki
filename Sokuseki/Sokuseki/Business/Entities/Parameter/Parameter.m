//
//  Parameter.m
//  Shin Ashiato
//
//  Created by Max Ueda on 8/9/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import "Parameter.h"

@implementation Parameter
@synthesize value;
-(int) getType
{
    return type;
}
-(void) setType: (int) parameterType;
{
    type = parameterType;
}

+(Parameter*) parameterWithValue: (NSString*) value withParameterType: (int) type
{
    Parameter *parameter = [[Parameter alloc] init];
    [parameter setValue: value];
    [parameter setType: type];
    return parameter;
}
@end
