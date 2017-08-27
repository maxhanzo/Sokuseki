//
//  Ship.h
//  Shin Ashiato
//
//  Created by Max Ueda on 8/14/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Steamer : NSObject
@property(nonatomic, assign) NSUInteger shipID;
@property(nonatomic, strong) NSString *shipName;
@property(nonatomic, strong) NSString *companyName;

+(Steamer*) steamerWithID: (NSUInteger) shipID withName: (NSString*) shipName;
+(Steamer*) steamerWithID: (NSUInteger) shipID withName: (NSString*) shipName withCompanyName: (NSString*) companyName;
@end
