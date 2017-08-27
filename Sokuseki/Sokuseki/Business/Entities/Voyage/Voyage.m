//
//  Voyage.m
//  Shin Ashiato
//
//  Created by Max Ueda on 8/14/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import "Voyage.h"

@implementation Voyage
@synthesize shipName, arrivalDate, departureDate, year, numberOfImmigrants, shipCompany;
+(Voyage*) voyageWithShipName: (NSString*) shipName withArrivalDate: (NSString*) arrivalDate withDepartureDate: (NSString*) departureDate withYear: (NSString*)year withNumberOfImmigrants: (NSString*) numberOfImmigrants withShipCompany: (NSString*) shipCompany{
    Voyage* voyage = [[Voyage alloc] init];
    [voyage setShipName:shipName];
    [voyage setArrivalDate: [Utilities dateFromString: arrivalDate]];
    [voyage setDepartureDate: [Utilities dateFromString: departureDate]];
    [voyage setYear: [year intValue]];
    [voyage setNumberOfImmigrants:[numberOfImmigrants intValue]];
    [voyage setShipCompany:shipCompany];
    return voyage;
}
@end
