//
//  Group.m
//  Shin Ashiato
//
//  Created by Max Ueda on 7/27/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import "Group.h"
#import "Immigrant.h"
@implementation Group
@synthesize immigrants, stationName, shipName, prefectureName,
destinationCity, farmName, arrivalDate, departureDate;


-(void) setGroupID: (int) ID
{
    groupID = ID;
}

-(int) getGroupID
{
    return groupID;
}

-(void) setYear: (int) year
{
    groupYear = year;
}

-(int) getYear
{
    return groupYear;
}

-(int) getNumberOfImmigrants
{
    if(immigrants)
    {
        return (int)[immigrants count];
    }
    return 0;
}
//Won't set Immigrant array
+(Group*) groupWithShipName: (NSObject*) shipName withPrefectureName: (NSString*) prefectureName
            withStationName: (NSString*) stationName
                  withDestinationCity: (NSString*) destinationCity withFarmName: (NSObject*) farmName
                    withDepartureDate: (NSDate*) departureDate withArrivalDate: (NSDate*) arrivalDate
                withGroupID: (int) groupID withYear:(int) year
{
    Group *group = [[Group alloc] init];
    [group setShipName:shipName];
    [group setPrefectureName:prefectureName];
    [group setDepartureDate:departureDate];
    [group setArrivalDate:arrivalDate];
    [group setStationName: stationName];
    [group setGroupID:groupID];
    [group setYear: year];
    return group;
}

//#$%#$! I hate that!
+(NSObject*) shipNameWithShipID: (int) shipID
{
    switch(shipID)
    {
        case 1:	return @"AFRICA-MARU"; break;
        case 2: return @"CHICAGO-MARU"; break;
        case 3: return @"TEIKOKU-MARU"; break;
        case 4: return @"VARIG    RG - 083"; break;
        case 5: return @"MANILA-MARU"; break;
        case 6: return @"WAKASA-MARU"; break;
        case 7: return @"JAPAN AIRLINES"; break;
        case 8: return @"JAPAN AIRLINES    JAL - 1008"; break;
        case 9: return @"BOLIVIA MARU"; break;
        case 10: return @"PAN AMERICAN    PN - 008"; break;
        case 11: return @"JAPAN AIRLINES    JAL - 006"; break;
        case 12: return @"NIPPON-MARU"; break;
        case 13: return @"LA PLATA-MARU"; break;
        case 14: return @"ARY PARREIRAS"; break;
        case 15: return @"JAPAN AIRLINES    JAL - 022"; break;
        case 16: return @"VARIG    RG - 815"; break;
        case 17: return @"TACOMA-MARU"; break;
        case 18: return @"MEXICO-MARU"; break;
        case 19: return @"AMERICA-MARU"; break;
        case 20: return @"HAKATA-MARU"; break;
        case 21: return @"KOREAN AIRLINES    KE  -  002"; break;
        case 22: return @"TOSA-MARU"; break;
        case 23: return @"SEATTLE-MARU"; break;
        case 24: return @"CANADA-MARU"; break;
        case 25: return @"サンラスピュー号"; break;
        case 26: return @"JAPAN AIRLINES    JAL - 062"; break;
        case 27: return @"HAWAII-MARU"; break;
        case 28: return @"KANAGAWA-MARU"; break;
        case 29: return @"LOIDE PARAGUAY"; break;
        case 30: return @"JAPAN AIRLINES    JAL - 064"; break;
        case 31: return @"AIR FRANCE     AF - 100"; break;
        case 32: return @"AIR FRANCE     "; break;
        case 33: return @"JAPAN AIRLINES    JAL - 074"; break;
        case 34: return @"TJISADANE"; break;
        case 35: return @"VARIG    RG - 831"; break;
        case 36: return @"CHINA AIRLINES   CHINA - 002"; break;
        case 37: return @"MONTEVIDEO-MARU"; break;
        case 38: return @"TEGELBERG"; break;
        case 39: return @"DAIZUI-MARU"; break;
        case 40: return @"SAKURA-MARU"; break;
        case 41: return @"BRASIL-MARU"; break;
        case 42: return @"SANTOS-MARU"; break;
        case 43: return @"PANAMA-MARU"; break;
        case 44: return @"TJITJALENGKA"; break;
        case 45: return @"BINGO-MARU"; break;
        case 46: return @"PAN AMERICAN"; break;
        case 47: return @"ITSUKUSHIMA-MARU"; break;
        case 48: return @"KOHKA-MARU"; break;
        case 49: return @"VARIG    RG - 833"; break;
        case 50: return @"KAWACHI-MARU"; break;
        case 51: return @"BOISSEVAIN"; break;
        case 52: return @"NÃO CONSTA"; break;
        case 53: return @"KASATO-MARU"; break;
        case 54: return @"RIO DE JANEIRO-MARU"; break;
        case 55: return @"RYOJUN-MARU"; break;
        case 56: return @"BUENOS AIRES-MARU"; break;
        case 57: return @"チリー"; break;
        case 58: return @"AWA-MARU"; break;
        case 59: return @"SANUKI-MARU"; break;
        case 60: return @"VARIG  VIAÇÃO AÉREA RIO GRANDENSE"; break;
        case 61: return @"PAN AMERICAN    PN - 020"; break;
        case 62: return @"ARGENTINA-MARU"; break;
        case 63: return @"DAINIUNKAI-MARU"; break;
        case 64: return @"ARIZONA-MARU"; break;
        case 65: return @"FUSHIMI-MARU"; break;
        case 66: return @"PAN AMERICAN    PN - 830"; break;
        case 67: return @"RUYS"; break;
        case 68: return @"KAMAKURA-MARU"; break;
        case 69: return @"ARABIA-MARU"; break;
        case 70: return @"OUTROS"; break;
        case 71: return @"SEIUN-MARU"; break;
        default: return @""; break;
    }
}

+(NSString*) prefectureNameWithPrefectureID:(NSNumber *)prefectureID
{
    int prefecture = [prefectureID intValue];
    switch (prefecture)
    {
        case 1 :return @"Hokkaido"; break;
        case 2 :return @"Iwate"; break;
        case 3 :return @"Fukushima"; break;
        case 4 :return @"Nagano"; break;
        case 5 :return @"Niigata"; break;
        case 6 :return @"Akita"; break;
        case 7 :return @"Gifu"; break;
        case 8 :return @"Aomori"; break;
        case 9 :return @"Yamagata"; break;
        case 10 :return @"Kagoshima"; break;
        case 11 :return @"Hiroshima"; break;
        case 12 :return @"Hyogo"; break;
        case 13 :return @"Shizuoka"; break;
        case 14 :return @"Miyazaki"; break;
        case 15 :return @"Kumamoto"; break;
        case 16 :return @"Miyagi"; break;
        case 17 :return @"Okayama"; break;
        case 18 :return @"Kochi"; break;
        case 19 :return @"Shimane"; break;
        case 20 :return @"Tochigi"; break;
        case 21 :return @"Gunma"; break;
        case 22 :return @"Oita"; break;
        case 23 :return @"Yamaguchi"; break;
        case 24 :return @"Ibaraki"; break;
        case 25 :return @"Mie"; break;
        case 26 :return @"Ehime"; break;
        case 27 :return @"Aichi"; break;
        case 28 :return @"Chiba"; break;
        case 29 :return @"Fukuoka"; break;
        case 30 :return @"Wakayama"; break;
        case 31 :return @"Kyoto"; break;
        case 32 :return @"Yamanashi"; break;
        case 33 :return @"Toyama"; break;
        case 34 :return @"Fukui"; break;
        case 35 :return @"Ishikawa"; break;
        case 36 :return @"Tokushima"; break;
        case 37 :return @"Nagasaki"; break;
        case 38 :return @"Shiga"; break;
        case 39 :return @"Saitama"; break;
        case 40 :return @"Nara"; break;
        case 41 :return @"Tottori"; break;
        case 42 :return @"Saga"; break;
        case 43 :return @"Kanagawa"; break;
        case 44 :return @"Okinawa"; break;
        case 45 :return @"Tokyo"; break;
        case 46 :return @"Osaka"; break;
        case 47 :return @"Kagawa"; break;
        case 48 :return @"Karafuto"; break;
        case 49 :return @"Korea"; break;
        default: return @""; break;
    }
}

@end
