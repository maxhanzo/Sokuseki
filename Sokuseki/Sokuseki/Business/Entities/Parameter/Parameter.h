//
//  Parameter.h
//  Shin Ashiato
//
//  Created by Max Ueda on 8/9/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Parameter : NSObject
{
    int type;
}

@property(nonatomic, strong) NSString* value;

-(int) getType;
-(void) setType: (int) parameterType;
+(Parameter*) parameterWithValue: (NSString*) value withParameterType: (int) type;
@end
