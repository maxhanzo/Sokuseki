//
//  DBManager.h
//  Shin Ashiato
//
//  Created by Max Ueda on 7/27/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
// - Needs to be refactored!
//

#define immigrantSelectFormat @"SELECT immigrantid, groupid, Destination, Year, Farm, ArrivalDate, DepartureDate,ShipName, PrefectureName, NameRomaji, SurnameRomaji,  SurnameKanji, NameKanji,  Companions , Station  FROM immigrantGroupShipPrefectureComplete  WHERE ((1=1) %@ %@ %@ %@ %@ %@ %@ %@ %@ %@) %@"

#define whereClauseNameRomajiFormat @" AND (NameRomaji LIKE '%%'||'%@'||'%%')"
#define whereClauseSurnameRomajiFormat @" AND (SurnameRomaji LIKE '%%'||'%@'||'%%')"
#define whereClauseNameKanjiFormat @" AND (NameKanji LIKE '%%'||'%@'||'%%')"
#define whereClauseSurnameKanjiFormat @" AND (SurnameKanji LIKE '%%'||'%@'||'%%')"
#define whereClauseShipNameFormat @" AND (ShipName LIKE '%%'||'%@'||'%%')"
#define whereClausePrefectureNameFormat @" AND (PrefectureName LIKE '%%'||'%@'||'%%')"
#define whereClauseYearFormat @" AND (Year == %i)"
#define whereClauseDepartureDateFormat @" AND (DepartureDate >= '%@')"
#define whereClauseArrivalDateFormat @" AND (ArrivalDate <= '%@')"
#define whereClauseGroupIDFormat @" AND (groupid = %li)"
#define orderByYearClauseFormat @"ORDER BY Year"
#define orderByNameRomajiFormat @"ORDER BY NameRomaji"
#define groupSelectFormat  @"SELECT ID, ShipID, Destination, Station, Farm, ArrivalDate, DepartureDate, Year FROM \"Group\" WHERE ((1=1) %@)"
#define groupSelectFormatWithPrefecture @"SELECT G.ID, G.ShipID, G.Destination, G.Station, G.Farm, G.ArrivalDate, G.DepartureDate, G.Year, P.Name AS  PrefectureName FROM \"Group\" AS G INNER JOIN Prefecture P ON GroupPrefecture.PrefectureID = P.ID INNER JOIN GroupPrefecture ON G.ID = GroupPrefecture.GroupID WHERE ((1=1) %@)"

#define whereClauseGroupGroupIDFormat @" AND (ID = %i)"

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMDatabaseAdditions.h"
#import "Immigrant.h"
#import "Group.h"
#import "Steamer.h"
#import "Voyage.h"
#import "Passenger.h"
#import "PrefectureInfo.h"
#import "Surname.h"
#import "SurnameDetail.h"

//#define DB_NAME @"ShinAshiato.db"
#define DB_NAME @"Sokuseki.db"
@interface DBManager : NSObject
{
    NSString *databasePath;
}

@property(nonatomic, strong) FMDatabase* database;


+(DBManager*)getSharedInstance;
-(BOOL)openDataBaseConnection;
-(void) closeDatabaseConnection;
-(NSArray*) searchImmigrantWithNameRomaji: (NSString*) nameRomaji withSurnameRomaji: (NSString*) surnameRomaji;
-(NSArray*) searchImmigrantWithGroupID: (NSNumber*) groupID;
-(Group*) searchGroupWithGroupID: (NSNumber*) groupID;
-(NSArray*) retrieveAllSteamers;
-(NSArray*) retrieveVoyageFromShipName: (NSString*) shipName;
-(NSArray*) retrievePassengersFromVoyage:(Voyage*) voyage;
-(PrefectureInfo*) retrievePrefectureInfoWithName: (NSString*) prefectureName;
-(NSArray*) retrieveAllSurnames;
-(NSArray*) retrieveSurnameDetailsFromSurname: (Surname*) surname;
-(NSArray*) retrieveSurnamesPredictiveSearchbar;
-(NSArray*) retrieveNamesPredictiveSearchbar;
-(NSArray*) retrieveSurnamesKanjiPredictiveSearchbar;
-(NSArray*) retrieveNamesKanjiPredictiveSearchbar;
//Legacy adaptation
+(NSArray*) searchImmigrantWithGroupID: (NSInteger) immigrantGroupID;
+(NSArray*) searchImmigrantWithData: (NSDictionary*) searchData;
+(NSString*) getDatabasePath;




@end
