//
//  Group.h
//  Shin Ashiato
//
//  Created by Max Ueda on 7/27/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject
{
    int groupID;
    int groupYear;
}
@property(nonatomic, strong) NSArray* immigrants;
@property(nonatomic, strong) NSObject* shipName;
@property(nonatomic, strong) NSString* prefectureName;
@property(nonatomic, strong) NSString* destinationCity;
@property(nonatomic, strong) NSString* stationName;
@property(nonatomic, strong) NSObject* farmName;
@property(nonatomic, strong) NSDate* arrivalDate;
@property(nonatomic, strong) NSDate* departureDate;

-(void) setGroupID: (int) ID;
-(int) getGroupID;
-(void) setYear: (int) year;
-(int) getYear;
-(int) getNumberOfImmigrants;
+(NSObject*) shipNameWithShipID: (int) shipID;
+(Group*) groupWithShipName: (NSObject*) shipName withPrefectureName: (NSString*) prefectureName
            withStationName: (NSString*) stationName
        withDestinationCity: (NSString*) destinationCity withFarmName: (NSObject*) farmName
          withDepartureDate: (NSDate*) departureDate withArrivalDate: (NSDate*) arrivalDate
                withGroupID: (int) groupID withYear:(int) year;
+(NSString*) prefectureNameWithPrefectureID: (NSNumber*) prefectureID;
@end
