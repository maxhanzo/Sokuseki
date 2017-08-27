//
//  Voyage.h
//  Shin Ashiato
//
//  Created by Max Ueda on 8/14/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utilities.h"

@interface Voyage : NSObject
@property(nonatomic, strong) NSString *shipName;
@property(nonatomic, strong) NSDate *arrivalDate;
@property(nonatomic, strong) NSDate *departureDate;
@property(nonatomic, assign) NSUInteger year;
@property(nonatomic, assign) NSUInteger numberOfImmigrants;
@property(nonatomic, strong) NSString *shipCompany;
+(Voyage*) voyageWithShipName: (NSString*) shipName withArrivalDate: (NSString*) arrivalDate withDepartureDate: (NSString*) departureDate withYear: (NSString*)year withNumberOfImmigrants: (NSString*) numberOfImmigrants withShipCompany: (NSString*) shipCompany;
@end
