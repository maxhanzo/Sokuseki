//
//  DBManager.m
//  Shin Ashiato
//
//  Created by Max Ueda on 7/27/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import "DBManager.h"
#import "Utilities.h"

static DBManager *sharedInstance = nil;


@implementation DBManager
@synthesize database;
+(DBManager *)getSharedInstance {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance openDataBaseConnection];
    });
    return sharedInstance;
}

-(BOOL) openDataBaseConnection
{
    
    //Getting the database path.
    //NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *docsPath = [paths objectAtIndex:0];
     
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"ShinAshiato" ofType:@"sqlite"];
    
    database = [FMDatabase databaseWithPath:dbPath];
    [self.database setShouldCacheStatements:YES];
    database.logsErrors = YES;
    if(database)
    {
        if(!database.goodConnection)
        {
            [database open];
            return YES;
        }
        
    }
    return NO;
}

-(void) closeDatabaseConnection
{
    if(database)
    {
        [database close];
    }
}

-(NSArray*) searchImmigrantWithNameRomaji: (NSString*) nameRomaji withSurnameRomaji: (NSString*) surnameRomaji
{
    __block BOOL success;
    NSMutableArray* immigrantsArray = [NSMutableArray array];
    
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"ShinAshiato" ofType:@"sqlite"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    NSString *sqlWhereClauseNameRomaji = [NSString stringWithFormat: whereClauseNameRomajiFormat, nameRomaji];
    NSString *sqlWhereClauseSurnameRomaji = [NSString stringWithFormat: whereClauseSurnameRomajiFormat, surnameRomaji];
    NSString *sqlSelectQuery = [NSString stringWithFormat: immigrantSelectFormat, sqlWhereClauseNameRomaji, sqlWhereClauseSurnameRomaji, @"", @"", @"", @"",@"", @"", @"", @"", @""];
    
    
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultsWithImmigrantData = [db executeQuery:sqlSelectQuery];
        if (!resultsWithImmigrantData)
        {
            NSLog(@"%s: %@", __FUNCTION__, [db lastErrorMessage]);
            success = NO;     // set the value inside the block
            return;           // note, this doesn't exit the method; this exits this `inDatabase` block
        }
   
   
    while([resultsWithImmigrantData next]) {
        
        // Accessing the values from the column.
        NSString *immigrantID = [resultsWithImmigrantData stringForColumn: @"immigrantid"];
        NSString *groupID = [resultsWithImmigrantData stringForColumn:@"groupid"];
        NSString *destination = [resultsWithImmigrantData stringForColumn:@"Destination"];
        NSString *year = [resultsWithImmigrantData stringForColumn:@"Year"];
        NSObject *farm = [resultsWithImmigrantData stringForColumn:@"Farm"];
        NSString *arrivalDate = [resultsWithImmigrantData stringForColumn:@"ArrivalDate"];
        NSString *departureDate = [resultsWithImmigrantData stringForColumn:@"DepartureDate"];
        NSObject *shipName = [resultsWithImmigrantData stringForColumn:@"ShipName"];
        NSString *prefectureName = [resultsWithImmigrantData stringForColumn:@"PrefectureName"];
        NSString *nameRomaji = [resultsWithImmigrantData stringForColumn:@"NameRomaji"];
        NSString *surnameRomaji = [resultsWithImmigrantData stringForColumn:@"SurnameRomaji"];
        NSObject *surnameKanji = [resultsWithImmigrantData stringForColumn:@"SurnameKanji"];
        NSObject *nameKanji = [resultsWithImmigrantData stringForColumn:@"NameKanji"];
        NSString *numberCompanions = [resultsWithImmigrantData stringForColumn:@"Companions"];
        NSString *station = [resultsWithImmigrantData stringForColumn:@"Station"];
        
        Immigrant *immigrant = [Immigrant immigrantWithNameRomaji:nameRomaji withSurnameRomaji:surnameRomaji withNameKanji:nameKanji withSurnameKanji:surnameKanji withShipName:shipName withPrefectureName:prefectureName withDestinationCity:destination withFarmName:farm  withDepartureDate:[Utilities dateFromString: departureDate]   withArrivalDate: [Utilities dateFromString:arrivalDate ]  withImmigrantID:[immigrantID intValue] withGroupID:[groupID intValue] withYear: [year intValue] withNumberCompanions: [numberCompanions intValue] withStationName: station];
        
        [immigrantsArray addObject: immigrant];
        
    }
        [resultsWithImmigrantData close];
        success = YES;        // another example of setting that `success` variable
    }];
    return immigrantsArray;
}

-(NSArray*) searchImmigrantWithGroupID: (NSNumber*) groupID
{
    __block BOOL success;
    NSMutableArray* immigrantsArray = [NSMutableArray array];
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"ShinAshiato" ofType:@"sqlite"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];

    NSString *sqlWhereClauseGroupID = [NSString stringWithFormat: whereClauseGroupIDFormat, [groupID integerValue]];
    NSString *sqlSelectQuery = [NSString stringWithFormat: immigrantSelectFormat, sqlWhereClauseGroupID, @"", @"", @"", @"", @"",@"", @"", @"", @"", @""];
    
    
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultsWithImmigrantData = [db executeQuery:sqlSelectQuery];
        if (!resultsWithImmigrantData)
        {
            NSLog(@"%s: %@", __FUNCTION__, [db lastErrorMessage]);
            success = NO;     // set the value inside the block
            return;           // note, this doesn't exit the method; this exits this `inDatabase` block
        }
        

    // Query result
       while([resultsWithImmigrantData next]) {
        
        // Accessing the values from the column.
        NSString *immigrantID = [resultsWithImmigrantData stringForColumn: @"immigrantid"];
        NSString *groupID = [resultsWithImmigrantData stringForColumn:@"groupid"];
        NSString *destination = [resultsWithImmigrantData stringForColumn:@"Destination"];
        NSString *year = [resultsWithImmigrantData stringForColumn:@"Year"];
        NSObject *farm = [resultsWithImmigrantData stringForColumn:@"Farm"];
        NSString *arrivalDate = [resultsWithImmigrantData stringForColumn:@"ArrivalDate"];
        NSString *departureDate = [resultsWithImmigrantData stringForColumn:@"DepartureDate"];
        NSObject *shipName = [resultsWithImmigrantData stringForColumn:@"ShipName"];
        NSString *prefectureName = [resultsWithImmigrantData stringForColumn:@"PrefectureName"];
        NSString *nameRomaji = [resultsWithImmigrantData stringForColumn:@"NameRomaji"];
        NSString *surnameRomaji = [resultsWithImmigrantData stringForColumn:@"SurnameRomaji"];
        NSObject *surnameKanji = [resultsWithImmigrantData stringForColumn:@"SurnameKanji"];
        NSObject *nameKanji = [resultsWithImmigrantData stringForColumn:@"NameKanji"];
        NSString *numberCompanions = [resultsWithImmigrantData stringForColumn:@"Companions"];
        NSString *station = [resultsWithImmigrantData stringForColumn:@"Station"];
        
           Immigrant *immigrant = [Immigrant immigrantWithNameRomaji:nameRomaji withSurnameRomaji:surnameRomaji withNameKanji:nameKanji withSurnameKanji:surnameKanji withShipName:shipName withPrefectureName:prefectureName withDestinationCity:destination withFarmName:farm  withDepartureDate:[Utilities dateFromString: departureDate]   withArrivalDate: [Utilities dateFromString:arrivalDate ]  withImmigrantID:[immigrantID intValue] withGroupID:[groupID intValue] withYear: [year intValue] withNumberCompanions: [numberCompanions intValue] withStationName: station];
        
        [immigrantsArray addObject: immigrant];
        
       } [resultsWithImmigrantData close];
        success = YES;        // another example of setting that `success` variable
    }];

    return immigrantsArray;
}
-(Group*) searchGroupWithGroupID: (NSNumber*) groupID
{
    /*
     SELECT ID, ShipID, Destination, Station, Farm, ArrivalDate,
     DepartureDate, Year
     FROM "Group"
     */
    __block BOOL success;
    __block Group *group = nil;
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"ShinAshiato" ofType:@"sqlite"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *sqlWhereClause = [NSString stringWithFormat: whereClauseGroupGroupIDFormat, [groupID intValue]];
        NSString *sqlGroupQuery = [NSString stringWithFormat: groupSelectFormatWithPrefecture, sqlWhereClause];
        if(![database open] )
        {
            NSLog(@"%s: %@", __FUNCTION__, [db lastErrorMessage]);
            success = NO;     // set the value inside the block
            return;
        }

        FMResultSet *resultsWithGroupData = [database executeQuery:sqlGroupQuery];
        if (!resultsWithGroupData)
        {
            NSLog(@"%s: %@", __FUNCTION__, [db lastErrorMessage]);
            success = NO;     // set the value inside the block
            return;           // note, this doesn't exit the method; this exits this `inDatabase` block
        }
   
        while ([resultsWithGroupData next])
        {
            NSString* ID = [resultsWithGroupData stringForColumn: @"ID"];
            NSString* shipID = [resultsWithGroupData stringForColumn: @"ShipID"];
            NSString* destination = [resultsWithGroupData stringForColumn: @"Destination"];
            NSString* station = [resultsWithGroupData stringForColumn: @"Station"];
            NSObject* farm = [resultsWithGroupData stringForColumn: @"Farm"];
            NSString* arrivalDate = [resultsWithGroupData stringForColumn: @"ArrivalDate"];
            NSString* departureDate = [resultsWithGroupData stringForColumn: @"DepartureDate"];
            NSString* year = [resultsWithGroupData stringForColumn: @"Year"];
            NSString *prefectureName = [resultsWithGroupData stringForColumn: @"PrefectureName"];
            NSObject *shipName = [Group shipNameWithShipID:[shipID intValue]];
        
            group = [Group groupWithShipName:shipName withPrefectureName:prefectureName withStationName:station withDestinationCity:destination withFarmName:farm withDepartureDate:[Utilities dateFromString:departureDate] withArrivalDate:[Utilities dateFromString: arrivalDate] withGroupID:[ID intValue] withYear: [year intValue]];
        }[resultsWithGroupData close];
        success = YES;        // another example of setting that `success` variable
    }];
    
    return group;
}

-(NSArray*) retrieveAllSteamers
{
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    
    NSString* shipQuery = @"SELECT ID, Name, Company FROM Ship ORDER BY Name";
    if(![db open] )
    {
        NSLog(@"%s: %@", __FUNCTION__, [db lastErrorMessage]);
        return nil;
    }
    FMResultSet *resultsWithShipData = [db executeQuery:shipQuery];
    if (!resultsWithShipData)
    {
        NSLog(@"%s: %@", __FUNCTION__, [db lastErrorMessage]);
        return nil;           // note, this doesn't exit the method; this exits this `inDatabase` block
    }
    NSMutableArray *steamersArray = [NSMutableArray array];
    while ([resultsWithShipData next])
    {
        NSString* shipID = [resultsWithShipData stringForColumn: @"ID"];
        NSString* shipName = [resultsWithShipData stringForColumn: @"Name"];
        NSString* companyName = [resultsWithShipData stringForColumn: @"Company"];
        
        Steamer *steamer = [Steamer steamerWithID: [shipID intValue] withName: shipName withCompanyName:companyName];
        [steamersArray addObject: steamer];
        
    }
    
    [db close];
    return steamersArray;
}
//TODO: Think of a more "generic" way of retrieving this data. Name comparison is not a
//good way
-(NSArray*) retrieveVoyageFromShipName: (NSString*) shipName
{
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    
    NSString* voyageQuery = [NSString stringWithFormat: @"%@ WHERE Ship LIKE '%@%%' Group By Arrival, Ship", @"SELECT Ship, Arrival, Departure, Year, Company, SUM(Immigrants) AS numberOfImmigrants FROM ShipVoyagePrefectureImmigrant ", shipName];
    
    NSMutableArray *voyageArray = [NSMutableArray array];
    FMResultSet *resultsWithVoyageData = [db executeQuery:voyageQuery];
    // Query result
    while ([resultsWithVoyageData next])
    {
        NSString* shipName = [resultsWithVoyageData stringForColumn: @"Ship"];
        NSString* arrivalDate = [resultsWithVoyageData stringForColumn: @"Arrival"];
        NSString* departureDate = [resultsWithVoyageData stringForColumn: @"Departure"];
        NSString* year = [resultsWithVoyageData stringForColumn: @"Year"];
        NSString* numberOfImmigrants = [resultsWithVoyageData stringForColumn: @"numberOfImmigrants"];
        NSString* shipCompany = [resultsWithVoyageData stringForColumn: @"Company"];
        
        
        Voyage *voyage = [Voyage voyageWithShipName: shipName withArrivalDate: arrivalDate withDepartureDate: departureDate withYear: year withNumberOfImmigrants: numberOfImmigrants withShipCompany: shipCompany];
        [voyageArray addObject: voyage];
    }
    [db close];
    return voyageArray;
    
}

//Voyage details
-(NSArray*) retrievePassengersFromVoyage:(Voyage*) voyage
{
    //SELECT Ship, Prefecture, Arrival, Departure, Year, Immigrants FROM ShipVoyagePrefectureImmigrant WHERE Ship LIKE '%WAKASA%' AND Departure = '1918-04-25'
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    NSMutableArray *passengersArray = [NSMutableArray array];
    NSString* voyageQuery = [NSString stringWithFormat: @"%@ WHERE Ship LIKE '%%%@%%' AND Departure = '%@'", @"SELECT  Prefecture, Immigrants FROM ShipVoyagePrefectureImmigrant  ", voyage.shipName, [Utilities  dbDateStringFromDate:voyage.departureDate]];
    FMResultSet *resultsWithVoyageData = [db executeQuery:voyageQuery];
    
    while ([resultsWithVoyageData next])
    {
        NSString* prefectureName = [resultsWithVoyageData stringForColumn: @"Prefecture"];
        NSString* numberOfImmigrants = [resultsWithVoyageData stringForColumn: @"Immigrants"];
        Passenger *passenger = [Passenger passengerWithPrefectureName:prefectureName withNumberOfImmigrants:[numberOfImmigrants intValue]];
        [passengersArray addObject: passenger];
    }
    [resultsWithVoyageData close];
    return passengersArray;
}

//Legacy adaptation
-(PrefectureInfo*) retrievePrefectureInfoWithName: (NSString*) prefectureName
{
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    
    NSString* sqlSelectQuery = [NSString stringWithFormat: @"SELECT Name, Capital, Area, Map, Flag, Region, Kanji, Island from Prefecture WHERE Name = '%@'", prefectureName];
    
    FMResultSet *resultsWithPrefectureData = [db executeQuery:sqlSelectQuery];
    
    NSNumberFormatter *areaFormatter = [[NSNumberFormatter alloc] init];
    [areaFormatter setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [areaFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [areaFormatter setMinimumFractionDigits:2];
    [areaFormatter setMaximumFractionDigits:2];
    [areaFormatter setGeneratesDecimalNumbers:YES];
    [areaFormatter setAlwaysShowsDecimalSeparator:YES];
    

    PrefectureInfo *prefectureInfo = nil;
    // Query result
    while ([resultsWithPrefectureData next])
    {
        NSString* prefectureName = [resultsWithPrefectureData stringForColumn: @"Name"];
        NSString* prefectureCapital = [resultsWithPrefectureData stringForColumn: @"Capital"];
        
        NSString *strPrefectureArea =[resultsWithPrefectureData stringForColumn: @"Area"];

        NSNumber* prefectureArea = [areaFormatter numberFromString:strPrefectureArea];
        NSString* prefectureMap = [resultsWithPrefectureData stringForColumn: @"Map"];
        NSString* prefectureFlag = [resultsWithPrefectureData stringForColumn: @"Flag"];
        NSString* prefectureRegion = [resultsWithPrefectureData stringForColumn: @"Region"];
        NSString* prefectureKanji = [resultsWithPrefectureData stringForColumn: @"Kanji"];
        NSString* prefectureIsland = [resultsWithPrefectureData stringForColumn: @"Island"];
        
        prefectureInfo = [PrefectureInfo prefectureInfoWithName: prefectureName withCapital:prefectureCapital withRegion:prefectureRegion withIsland:prefectureIsland withArea:prefectureArea withFlag:prefectureFlag withMap:prefectureMap withKanji:prefectureKanji];
    }

    [resultsWithPrefectureData close];
    return prefectureInfo;
    
}

//Legacy adaptation
-(NSArray*) retrieveAllSurnames
{
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    
    NSMutableArray* surnamesArray = [NSMutableArray array];
    
    NSString* surnameQuery = @"SELECT ID, Romaji, NumberOfImmigrants FROM Surnames ORDER BY NumberOfImmigrants DESC";
    FMResultSet *resultsWithSurnameData = [db executeQuery:surnameQuery];

    
    if (!resultsWithSurnameData)
    {
        NSLog(@"%s: %@", __FUNCTION__, [db lastErrorMessage]);
    }
        
    while ([resultsWithSurnameData next])
    {
        NSString* surnameID = [resultsWithSurnameData stringForColumn: @"ID"];
        NSString* romaji = [resultsWithSurnameData stringForColumn: @"Romaji"];
        NSString* numberOfImmigrants = [resultsWithSurnameData stringForColumn:@"NumberOfImmigrants"];
            
        Surname  *surname = [Surname surnameWithRomaji:romaji withNumberOfImmigrants:[NSNumber numberWithInteger: [numberOfImmigrants integerValue]] withID:[surnameID integerValue]];
            [surnamesArray addObject: surname];
            
    }
    [resultsWithSurnameData close];

    return surnamesArray;
}

#pragma mark - Predictive Searchbar Methods
-(NSArray*) retrieveSurnamesPredictiveSearchbar
{
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    
    NSMutableArray* surnamesArray = [NSMutableArray array];
    
    NSString* surnameQuery = @" SELECT * FROM Surnames order by Romaji asc";
    FMResultSet *resultsWithSurnameData = [db executeQuery:surnameQuery];
    
    
    if (!resultsWithSurnameData)
    {
        NSLog(@"%s: %@", __FUNCTION__, [db lastErrorMessage]);
    }
    
    while ([resultsWithSurnameData next])
    {
        //NSString* surnameID = [resultsWithSurnameData stringForColumn: @"ID"];
        NSString* romaji = [resultsWithSurnameData stringForColumn: @"Romaji"];
        //NSString* numberOfImmigrants = [resultsWithSurnameData stringForColumn:@"NumberOfImmigrants"];
        
       // Surname  *surname = [Surname surnameWithRomaji:romaji withNumberOfImmigrants:[NSNumber numberWithInteger: [numberOfImmigrants integerValue]] withID:[surnameID integerValue]];
        //[surnamesArray addObject: surname];
        [surnamesArray addObject: romaji];
        
    }
    [resultsWithSurnameData close];
    
    return surnamesArray;
}


-(NSArray*) retrieveNamesPredictiveSearchbar
{
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    
    NSMutableArray* namesArray = [NSMutableArray array];
    
    NSString* namesQuery = @"SELECT * FROM Name order by Romaji asc";
    FMResultSet *resultsWithNameData = [db executeQuery:namesQuery];
    
    
    if (!resultsWithNameData)
    {
        NSLog(@"%s: %@", __FUNCTION__, [db lastErrorMessage]);
    }
    
    while ([resultsWithNameData next])
    {
        //NSString* surnameID = [resultsWithSurnameData stringForColumn: @"ID"];
        NSString* romaji = [resultsWithNameData stringForColumn: @"Romaji"];
        //NSString* numberOfImmigrants = [resultsWithSurnameData stringForColumn:@"NumberOfImmigrants"];
        
        //Surname  *surname = [Surname surnameWithRomaji:romaji withNumberOfImmigrants:[NSNumber numberWithInteger: [numberOfImmigrants integerValue]] withID:[surnameID integerValue]];
        //[surnamesArray addObject: surname];
        [namesArray addObject: romaji];
        
    }
    [resultsWithNameData close];
    
    return namesArray;
}

-(NSArray*) retrieveSurnamesKanjiPredictiveSearchbar
{
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    
    NSMutableArray* surnamesArray = [NSMutableArray array];
    
    NSString* surnameQuery = @"SELECT * FROM SurnameKanji";
    FMResultSet *resultsWithSurnameData = [db executeQuery:surnameQuery];
    
    
    if (!resultsWithSurnameData)
    {
        NSLog(@"%s: %@", __FUNCTION__, [db lastErrorMessage]);
    }
    
    while ([resultsWithSurnameData next])
    {
        //NSString* surnameID = [resultsWithSurnameData stringForColumn: @"ID"];
        NSString* kanji = [resultsWithSurnameData stringForColumn: @"SurnameKanji"];
        //NSString* numberOfImmigrants = [resultsWithSurnameData stringForColumn:@"NumberOfImmigrants"];
        
        //Surname  *surname = [Surname surnameWithRomaji:romaji withNumberOfImmigrants:[NSNumber numberWithInteger: [numberOfImmigrants integerValue]] withID:[surnameID integerValue]];
        //[surnamesArray addObject: surname];
        [surnamesArray addObject: kanji];
        
    }
    [resultsWithSurnameData close];
    
    return surnamesArray;
}

-(NSArray*) retrieveNamesKanjiPredictiveSearchbar
{
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    
    NSMutableArray* namesArray = [NSMutableArray array];
    
    NSString* nameQuery = @"SELECT * FROM NameKanji";
    FMResultSet *resultsWithNameData = [db executeQuery:nameQuery];
    
    
    if (!resultsWithNameData)
    {
        NSLog(@"%s: %@", __FUNCTION__, [db lastErrorMessage]);
    }
    
    while ([resultsWithNameData next])
    {
        //NSString* surnameID = [resultsWithNameData stringForColumn: @"ID"];
        NSString* nameKanji = [resultsWithNameData stringForColumn: @"NameKanji"];
        //NSString* numberOfImmigrants = [resultsWithNameData stringForColumn:@"NumberOfImmigrants"];
        
        //Surname  *surname = [Surname surnameWithRomaji:romaji withNumberOfImmigrants:[NSNumber numberWithInteger: [numberOfImmigrants integerValue]] withID:[surnameID integerValue]];
        [namesArray addObject: nameKanji];
        
    }
    [resultsWithNameData close];
    
    return namesArray;
}

#pragma mark - Surnames view controllers
-(NSArray*) retrieveSurnameDetailsFromSurname: (Surname*) surname
{
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    
    NSMutableArray* surnamesArray = [NSMutableArray array];
   
        NSString* surnameDetailsQuery = [NSString stringWithFormat: @"SELECT surnameID, KanjiReading, Occurences FROM SurnameDetails WHERE surnameID = %lu ORDER BY Occurences DESC", (unsigned long)surname.surnameID];

        FMResultSet *resultsWithSurnameDetailsData = [db executeQuery:surnameDetailsQuery];
    
        while ([resultsWithSurnameDetailsData next])
        {
            //NSString* surnameID = [resultsWithSurnameDetailsData stringForColumn: @"ID"];
            NSString* kanjiReading = [resultsWithSurnameDetailsData stringForColumn: @"KanjiReading"];
            NSString* occurences = [resultsWithSurnameDetailsData stringForColumn:@"Occurences"];
            
            SurnameDetail  *surnameDetail = [SurnameDetail detailWithKanjiReading:kanjiReading withNumberOfImmigrants:[NSNumber numberWithInteger: [occurences integerValue]]];
            [surnamesArray addObject: surnameDetail];
            
        }[resultsWithSurnameDetailsData close];
    
    
    return surnamesArray;
}


//Legacy adaptation.
+(NSArray*) searchImmigrantWithData: (NSDictionary*) searchData
{
    NSMutableArray* immigrantsArray = [NSMutableArray array];
    
    NSMutableArray *queryParametersArray = [NSMutableArray arrayWithCapacity:10];
    
    NSArray *searchDataKeys = [searchData allKeys];
    
    for (NSNumber* searchKey in searchDataKeys)
    {
        int keyConstant = [searchKey intValue];
        switch(keyConstant)
        {
            case NameRomajiKey:
            {
                NSString* queryParameter = [NSString stringWithFormat: whereClauseNameRomajiFormat, [searchData objectForKey: searchKey]];
                [queryParametersArray addObject: queryParameter];
                
            }break;
                
            case SurnameRomajiKey:
            {
                NSString* queryParameter = [NSString stringWithFormat: whereClauseSurnameRomajiFormat, [searchData objectForKey: searchKey]];
                [queryParametersArray addObject: queryParameter];
                
            }break;
                
            case NameKanjiKey:
            {
                NSString* queryParameter = [NSString stringWithFormat: whereClauseNameKanjiFormat, [searchData objectForKey: searchKey]];
                [queryParametersArray addObject: queryParameter];
                
            }break;
                
            case SurnameKanjiKey:
            {
                NSString* queryParameter = [NSString stringWithFormat: whereClauseSurnameKanjiFormat, [searchData objectForKey: searchKey]];
                [queryParametersArray addObject: queryParameter];
                
            }break;
                
                
            case ImmigrationYearKey:
            {
                NSString* queryParameter = [NSString stringWithFormat: whereClauseYearFormat, [[searchData objectForKey: searchKey] intValue]];
                [queryParametersArray addObject: queryParameter];
                
            }break;
                
            case PrefectureNameKey:
            {
                NSString* queryParameter = [NSString stringWithFormat: whereClausePrefectureNameFormat, [searchData objectForKey: searchKey]];
                [queryParametersArray addObject: queryParameter];
                
            }break;
                
            case ShipNameKey:
            {
                NSString* queryParameter = [NSString stringWithFormat: whereClauseShipNameFormat, [searchData objectForKey: searchKey]];
                [queryParametersArray addObject: queryParameter];
                
            }break;
                
            default:{
                NSString* queryParameter = @"";
                [queryParametersArray addObject: queryParameter];
            }
                break;
                
        }
    }
    
    //complete blank spaces
    
    int numberOfKeys = (int)[searchDataKeys count];
    int remainingSpacesParametersArray = 10 - numberOfKeys;
    
    for (int i = 0; i<remainingSpacesParametersArray; i++)
    {
        [queryParametersArray addObject:@""];
    }
    
    //Full query
    NSString *sqlSelectQuery = [NSString stringWithFormat: immigrantSelectFormat, [queryParametersArray objectAtIndex: 0], [queryParametersArray objectAtIndex: 1], [queryParametersArray objectAtIndex: 2],[queryParametersArray objectAtIndex: 3], [queryParametersArray objectAtIndex: 4], [queryParametersArray objectAtIndex: 5],[queryParametersArray objectAtIndex: 6], [queryParametersArray objectAtIndex: 7], [queryParametersArray objectAtIndex: 8], [queryParametersArray objectAtIndex: 9], orderByNameRomajiFormat];
    NSLog(@"%@", sqlSelectQuery);

    
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    FMResultSet *resultsWithImmigrantData = [db executeQuery:sqlSelectQuery];
    
        while([resultsWithImmigrantData next]) {
            
            // Accessing the values from the column.
            NSString *immigrantID = [resultsWithImmigrantData stringForColumn: @"immigrantid"];
            NSString *groupID = [resultsWithImmigrantData stringForColumn:@"groupid"];
            NSString *destination = [resultsWithImmigrantData stringForColumn:@"Destination"];
            NSString *year = [resultsWithImmigrantData stringForColumn:@"Year"];
            NSObject *farm = [resultsWithImmigrantData stringForColumn:@"Farm"];
            NSString *arrivalDate = [resultsWithImmigrantData stringForColumn:@"ArrivalDate"];
            NSString *departureDate = [resultsWithImmigrantData stringForColumn:@"DepartureDate"];
            NSObject *shipName = [resultsWithImmigrantData stringForColumn:@"ShipName"];
            NSString *prefectureName = [resultsWithImmigrantData stringForColumn:@"PrefectureName"];
            NSString *nameRomaji = [resultsWithImmigrantData stringForColumn:@"NameRomaji"];
            NSString *surnameRomaji = [resultsWithImmigrantData stringForColumn:@"SurnameRomaji"];
            NSObject *surnameKanji = [resultsWithImmigrantData stringForColumn:@"SurnameKanji"];
            NSObject *nameKanji = [resultsWithImmigrantData stringForColumn:@"NameKanji"];
            NSString *numberCompanions = [resultsWithImmigrantData stringForColumn:@"Companions"];
            NSString *station = [resultsWithImmigrantData stringForColumn:@"Station"];
            
            Immigrant *immigrant = [Immigrant immigrantWithNameRomaji:nameRomaji withSurnameRomaji:surnameRomaji withNameKanji:nameKanji withSurnameKanji:surnameKanji withShipName:shipName withPrefectureName:prefectureName withDestinationCity:destination withFarmName:farm  withDepartureDate:[Utilities dateFromString: departureDate]   withArrivalDate: [Utilities dateFromString:arrivalDate ]  withImmigrantID:[immigrantID intValue] withGroupID:[groupID intValue] withYear: [year intValue] withNumberCompanions: [numberCompanions intValue] withStationName: station];
            
            [immigrantsArray addObject: immigrant];
            
        }
        [resultsWithImmigrantData close];
        return immigrantsArray;
}


//Legacy adaptation
+(NSArray*) searchImmigrantWithGroupID: (NSInteger) immigrantGroupID
{
    NSMutableArray* immigrantsArray = [NSMutableArray array];
    NSString *sqlWhereClauseGroupID = [NSString stringWithFormat: whereClauseGroupIDFormat, (long)immigrantGroupID];
    NSString *sqlSelectQuery = [NSString stringWithFormat: immigrantSelectFormat, sqlWhereClauseGroupID, @"", @"", @"", @"", @"",@"", @"", @"", @"", @""];
    
    NSString *dbPath = [DBManager getDatabasePath];
    FMDatabase *db = [FMDatabase databaseWithPath: dbPath];
    [db open];
    
    FMResultSet *resultsWithImmigrantData = [db executeQuery:sqlSelectQuery];
    // Query result
    while([resultsWithImmigrantData next]) {
        
        // Accessing the values from the column.
        NSString *immigrantID = [resultsWithImmigrantData stringForColumn: @"immigrantid"];
        NSString *groupID = [resultsWithImmigrantData stringForColumn:@"groupid"];
        NSString *destination = [resultsWithImmigrantData stringForColumn:@"Destination"];
        NSString *year = [resultsWithImmigrantData stringForColumn:@"Year"];
        NSObject *farm = [resultsWithImmigrantData stringForColumn:@"Farm"];
        NSString *arrivalDate = [resultsWithImmigrantData stringForColumn:@"ArrivalDate"];
        NSString *departureDate = [resultsWithImmigrantData stringForColumn:@"DepartureDate"];
        NSObject *shipName = [resultsWithImmigrantData stringForColumn:@"ShipName"];
        NSString *prefectureName = [resultsWithImmigrantData stringForColumn:@"PrefectureName"];
        NSString *nameRomaji = [resultsWithImmigrantData stringForColumn:@"NameRomaji"];
        NSString *surnameRomaji = [resultsWithImmigrantData stringForColumn:@"SurnameRomaji"];
        NSObject *surnameKanji = [resultsWithImmigrantData stringForColumn:@"SurnameKanji"];
        NSObject *nameKanji = [resultsWithImmigrantData stringForColumn:@"NameKanji"];
        NSString *numberCompanions = [resultsWithImmigrantData stringForColumn:@"Companions"];
        NSString *station = [resultsWithImmigrantData stringForColumn:@"Station"];
        
        Immigrant *immigrant = [Immigrant immigrantWithNameRomaji:nameRomaji withSurnameRomaji:surnameRomaji withNameKanji:nameKanji withSurnameKanji:surnameKanji withShipName:shipName withPrefectureName:prefectureName withDestinationCity:destination withFarmName:farm  withDepartureDate:[Utilities dateFromString: departureDate]   withArrivalDate: [Utilities dateFromString:arrivalDate ]  withImmigrantID:[immigrantID intValue] withGroupID:[groupID intValue] withYear: [year intValue] withNumberCompanions: [numberCompanions intValue] withStationName: station];
        
        [immigrantsArray addObject: immigrant];
        
    }
    
    [resultsWithImmigrantData close];
    return immigrantsArray;
}


+(NSString*) getDatabasePath
{
    return [[NSBundle mainBundle] pathForResource:DB_NAME ofType:nil];
}


@end

