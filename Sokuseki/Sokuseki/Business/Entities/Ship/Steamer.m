//
//  Ship.m
//  Shin Ashiato
//
//  Created by Max Ueda on 8/14/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import "Steamer.h"

@implementation Steamer
@synthesize shipID, shipName;

+(Steamer*) steamerWithID: (NSUInteger) shipID withName: (NSString*) shipName
{
    Steamer* steamer = [[Steamer alloc] init];
    [steamer setShipID: shipID];
    [steamer setShipName: shipName];
    return steamer;
}

+(Steamer*) steamerWithID:(NSUInteger)shipID withName:(NSString *)shipName withCompanyName:(NSString *)companyName
{
    Steamer* steamer = [Steamer steamerWithID:shipID withName:shipName];
    [steamer setCompanyName: companyName];
    return steamer;
}
@end
