//
//  Immigrant.m
//  Shin Ashiato
//
//  Created by Max Ueda on 7/27/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import "Immigrant.h"

@implementation Immigrant
@synthesize nameRomaji, surnameRomaji, nameKanji, surnameKanji, shipName, prefectureName,
    destinationCity, farmName, arrivalDate, departureDate;



-(void) setImmigrantID: (int) ID
{
    immigrantID = ID;
}
-(void) setGroupID: (int) ID
{
    groupID = ID;
}

-(void) setYear: (int) immigrationYear
{
    year = immigrationYear;
}
-(int) getImmigrantID
{
    return immigrantID;
}
-(int) getGroupID
{
    return groupID;
}
-(int) getYear
{
    return year;
}
-(void) setCompanions: (int) numberCompanions
{
    companions = numberCompanions;
}
-(int) getCompanions
{
    return companions;
}


+(Immigrant*) immigrantWithNameRomaji: (NSString*) nameRomaji withSurnameRomaji: (NSString*) surnameRomaji
                        withNameKanji: (NSObject*) nameKanji withSurnameKanji: (NSObject*) surnameKanji
                         withShipName: (NSObject*) shipName withPrefectureName: (NSString*) prefectureName
                  withDestinationCity: (NSString*) destinationCity withFarmName: (NSObject*) farmName
                    withDepartureDate: (NSDate*) departureDate withArrivalDate: (NSDate*) arrivalDate
                      withImmigrantID: (int) immigrantID withGroupID: (int) groupID withYear: (int) year
                 withNumberCompanions: (int) numberCompanions withStationName: (NSString*) stationName
{
    Immigrant *immigrant = [[Immigrant alloc] init];
    [immigrant setNameRomaji: nameRomaji];
    [immigrant setSurnameRomaji:surnameRomaji];
    [immigrant setNameKanji:nameKanji];
    [immigrant setSurnameKanji:surnameKanji];
    [immigrant setShipName:shipName];
    [immigrant setPrefectureName:prefectureName];
    [immigrant setDepartureDate:departureDate];
    [immigrant setArrivalDate:arrivalDate];
    [immigrant setImmigrantID:immigrantID];
    [immigrant setGroupID:groupID];
    [immigrant setYear: year];
    [immigrant setCompanions:numberCompanions];
    [immigrant setDestinationCity:destinationCity];
    [immigrant setFarmName:farmName];
    [immigrant setStationName: stationName];
    return immigrant;
}

@end
