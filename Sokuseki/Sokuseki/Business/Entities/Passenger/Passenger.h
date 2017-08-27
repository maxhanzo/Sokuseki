//
//  Passenger.h
//  Shin Ashiato
//
//  Created by Max Ueda on 8/19/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Passenger : NSObject
@property(nonatomic, strong) NSString *prefectureName;
@property(nonatomic, assign) NSInteger numberOfImmigrants;
@property(nonatomic, strong) NSNumber *totalNumberOfImmigrants;

+(Passenger*) passengerWithPrefectureName: (NSString*) prefectureName withNumberOfImmigrants: (NSInteger) numberOfImmigrants;
@end
