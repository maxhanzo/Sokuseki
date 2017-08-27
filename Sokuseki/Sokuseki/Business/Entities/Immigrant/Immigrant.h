//
//  Immigrant.h
//  Shin Ashiato
//
//  Created by Max Ueda on 7/27/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Immigrant : NSObject
{
    int immigrantID;
    int groupID;
    int year;
    int companions;
}

@property(nonatomic, strong) NSString* nameRomaji;
@property(nonatomic, strong) NSString* surnameRomaji;
@property(nonatomic, strong) NSObject* nameKanji;
@property(nonatomic, strong) NSObject* surnameKanji;
@property(nonatomic, strong) NSObject* shipName;
@property(nonatomic, strong) NSString* prefectureName;
@property(nonatomic, strong) NSString* destinationCity;
@property(nonatomic, strong) NSObject* farmName;
@property(nonatomic, strong) NSDate* arrivalDate;
@property(nonatomic, strong) NSDate* departureDate;
@property(nonatomic, strong) NSString* stationName;


-(void) setImmigrantID: (int) ID;
-(void) setGroupID: (int) ID;
-(void) setYear: (int) year;
-(int) getImmigrantID;
-(int) getGroupID;
-(int) getYear;
-(void) setCompanions: (int) numberCompanions;
-(int) getCompanions;


+(Immigrant*) immigrantWithNameRomaji: (NSString*) nameRomaji withSurnameRomaji: (NSString*) surnameRomaji
                        withNameKanji: (NSObject*) nameKanji withSurnameKanji: (NSObject*) surnameKanji
                         withShipName: (NSObject*) shipName withPrefectureName: (NSString*) prefectureName
                  withDestinationCity: (NSString*) destinationCity withFarmName: (NSObject*) farmName
                    withDepartureDate: (NSDate*) departureDate withArrivalDate: (NSDate*) arrivalDate
                      withImmigrantID: (int) immigrantID withGroupID: (int) groupID withYear: (int) year withNumberCompanions: (int) numberCompanions withStationName: (NSString*)stationName;




@end
