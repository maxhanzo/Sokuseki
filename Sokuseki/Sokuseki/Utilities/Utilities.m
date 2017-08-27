//
//  Utilities.m
//  Sokuseki
//
//  Created by Max Ueda on 12/17/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "Utilities.h"


@implementation Utilities



//Number parser: TODO - Think of a safer way
+(NSNumber*) numberFromString: (NSString*) stringValue withLocale: (NSLocale*) locale
{
    NSScanner* myScanner = [NSScanner scannerWithString:stringValue];
    [myScanner setLocale: locale];
    float floatResult;
    if([myScanner scanFloat: &floatResult])
    {
        return [NSNumber numberWithFloat: floatResult];
    }
    
    else return nil;
}

+(NSDate*) dateFromString: (NSString*) stringValue withLocale: (NSLocale*) locale
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // NSString *dateTemplate = [NSDateFormatter dateFormatFromTemplate:@"dd/MM/yyyy" options:0 locale:locale];
    [dateFormatter setDateFormat: @"dd/MM/yyyy"];
    NSDate *date = [dateFormatter dateFromString:stringValue];
    if(date)
    {
        return date;
    }
    else return nil;
}


+(NSDate*) dateFromString: (NSString*) stringValue
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // NSString *dateTemplate = [NSDateFormatter dateFormatFromTemplate:@"dd/MM/yyyy" options:0 locale:locale];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:stringValue];
    if(date)
    {
        return date;
    }
    else return nil;
}

+(NSString*) dateTimeNow
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay |  NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    return [NSString stringWithFormat: @"%ld/%ld/%ld", (long)day, (long)month, (long)year];
}

+(NSString*) dateTimeThirtyDaysAgo
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay |  NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[[NSDate date]dateByAddingTimeInterval:-30*24*60*60 ]];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    return [NSString stringWithFormat: @"%ld/%ld/%ld", (long)day, (long)month, (long)year];
}

+(NSString*) stringFromDate:(NSDate*) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    return [formatter stringFromDate:date];
}

+(NSString*) dbDateStringFromDate:(NSDate*) date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}


+(BOOL) isParameterPrefecture: (NSString*) parameter
{
    NSArray *prefectureNames = PREFECTURE_NAMES_ARRAY;
    for (NSString *prefectureName in prefectureNames)
    {
        
        CGFloat result = [prefectureName scoreAgainst:parameter fuzziness:[NSNumber numberWithFloat:0.8]];
        if (result>0.8f)
        {
            NSLog(@"Fuzzyness Level: %f", result);
            
            return YES;
        }
    }
    return NO;
}

+(BOOL) isParameterShip: (NSString*) parameter
{
    if(![Utilities isParameterKanji: parameter])
    {
        NSArray *shipNames = SHIPS_NAMES_ARRAY;
        for (NSString *shipName in shipNames)
        {
            if(([parameter isEqualToString: @"LA"])||([parameter isEqualToString:@"La"]))
            {
                NSLog(@"LA PLATA");
            }
            
            if(([parameter isEqualToString: @"AIR"])||([parameter isEqualToString:@"AIR"]))
            {
                NSLog(@"Air France");
                
            }
            
            if(([parameter isEqualToString: @"America"])||([parameter isEqualToString:@"America"]))
            {
                NSLog(@"AMERICA");
                if([shipName isEqualToString: @"AMERICA-MARU"])
                {
                    NSLog(@"Miseteyaru");
                }
                
            }
            
            
            CGFloat result = [shipName scoreAgainst:parameter fuzziness:nil options:(NSStringScoreOptionFavorSmallerWords | NSStringScoreOptionReducedLongStringPenalty)];
            //NSLog(@"Fuzzyness Level: %f", result);
            if (result>0.421000f)
            {
                return YES;
            }
        }
    }
    return NO;
}

+(BOOL) isParameterKanji: (NSString*) parameter
{
    return [NSString stringContainsJapaneseText: parameter];
}

+(UIImage*) imageFromParameterType: (int) parameter
{
    switch(parameter)
    {
        case NameKanji:
        {
            return [UIImage imageNamed: @"nameKanji.png"];
        }break;
        case NameRomaji:
        {
            return [UIImage imageNamed: @"nameRomaji.png"];
        }break;
        case Prefecture:
        {
            return [UIImage imageNamed: @"home01.png"];
        }break;
        case Ship:
        {
            return [UIImage imageNamed: @"steamer.png"];
        }break;
        case SurnameKanji:
        {
            return [UIImage imageNamed: @"surnameKanji.png"];
        }break;
        case SurnameRomaji:
        {
            return [UIImage imageNamed: @"surnameRomaji.png"];
        }break;
        case ImmigrationYear:
        {
            return [UIImage imageNamed: @"office_calendar.png"];
        }break;
        default:
            break;
    }
    return [UIImage imageNamed: @"ShinAshiatoIcon-2.png"];
}

+(NSString*) stringFromParameterType: (int) parameter
{
    switch(parameter)
    {
        case NameKanji:
        {
            return @"Nome Kanji";
        }break;
        case NameRomaji:
        {
            return @"Nome Romaji";
        }break;
        case Prefecture:
        {
            return @"Província";
        }break;
        case Ship:
        {
            return @"Navio";
        }break;
        case SurnameKanji:
        {
            return @"Sobrenome Kanji";
        }break;
        case SurnameRomaji:
        {
            return @"Sobrenome Romaji";
        }break;
        case ImmigrationYear:
        {
            return @"Ano de imigração";
        }break;
        default:
            break;
    }
    return @"";
    
}


+(NSString*) deSQLizer:(NSString*) parameter
{
    parameter = [parameter
                 stringByReplacingOccurrencesOfString:@"%" withString:@""];
    parameter = [parameter
                 stringByReplacingOccurrencesOfString:@"select" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [parameter length])];
    parameter = [parameter
                 stringByReplacingOccurrencesOfString:@"create" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [parameter length])];
    parameter = [parameter
                 stringByReplacingOccurrencesOfString:@"update" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [parameter length])];
    parameter = [parameter
                 stringByReplacingOccurrencesOfString:@"delete" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [parameter length])];
    parameter = [parameter
                 stringByReplacingOccurrencesOfString:@"*" withString:@""];
    
    parameter = [parameter
                 stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    parameter = [parameter
                 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    parameter = [parameter
                 stringByReplacingOccurrencesOfString:@"\'" withString:@""];
    
    parameter = [parameter
                 stringByReplacingOccurrencesOfString:@";" withString:@""];
    
    parameter = [parameter
                 stringByReplacingOccurrencesOfString:@"from" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [parameter length])];
    
    
    
    return parameter;
}

+(UIImage*) flagForPrefectureID: (NSUInteger) prefectureID
{
    switch (prefectureID)
    {
        case Aichi :
            return [UIImage imageNamed: @"Flag_of_Aichi.png"];
            break;
        case Akita :
            return [UIImage imageNamed: @"Flag_of_Akita.png"];
            break;
        case Aomori :
            return [UIImage imageNamed: @"Flag_of_Aomori.png"];
            break;
        case Chiba :
            return [UIImage imageNamed: @"Flag_of_Chiba.png"];
            break;
        case Chosen :
            return [UIImage imageNamed: @"Flag_of_Chosen.png"];
            break;
        case Ehime :
            return [UIImage imageNamed: @"Flag_of_Ehime.png"];
            break;
        case Fukui :
            return [UIImage imageNamed: @"Flag_of_Fukui.png"];
            break;
        case Fukuoka :
            return [UIImage imageNamed: @"Flag_of_Fukuoka.png"];
            break;
        case Fukushima :
            return [UIImage imageNamed: @"Flag_of_Fukushima.png"];
            break;
        case Gifu :
            return [UIImage imageNamed: @"Flag_of_Gifu.png"];
            break;
        case Gunma :
            return [UIImage imageNamed: @"Flag_of_Gunma.png"];
            break;
        case Hiroshima :
            return [UIImage imageNamed: @"Flag_of_Hiroshima.png"];
            break;
        case Hokkaido :
            return [UIImage imageNamed: @"Flag_of_Hokkaido.png"];
            break;
        case Hyogo :
            return [UIImage imageNamed: @"Flag_of_Hyogo.png"];
            break;
        case Ibaraki :
            return [UIImage imageNamed: @"Flag_of_Ibaraki.png"];
            break;
        case Ishikawa :
            return [UIImage imageNamed: @"Flag_of_Ishikawa.png"];
            break;
        case Iwate :
            return [UIImage imageNamed: @"Flag_of_Iwate.png"];
            break;
        case Kagawa :
            return [UIImage imageNamed: @"Flag_of_Kagawa.png"];
            break;
        case Kagoshima :
            return [UIImage imageNamed: @"Flag_of_Kagoshima.png"];
            break;
        case Kanagawa :
            return [UIImage imageNamed: @"Flag_of_Kanagawa.png"];
            break;
        case Karafuto :
            return [UIImage imageNamed: @"Flag_of_Karafuto.png"];
            break;
        case Kochi :
            return [UIImage imageNamed: @"Flag_of_Kochi.png"];
            break;
        case Kumamoto :
            return [UIImage imageNamed: @"Flag_of_Kumamoto.png"];
            break;
        case Kyoto :
            return [UIImage imageNamed: @"Flag_of_Kyoto.png"];
            break;
        case Mie :
            return [UIImage imageNamed: @"Flag_of_Mie.png"];
            break;
        case Miyagi :
            return [UIImage imageNamed: @"Flag_of_Miyagi.png"];
            break;
        case Miyazaki :
            return [UIImage imageNamed: @"Flag_of_Miyazaki.png"];
            break;
        case Nagano :
            return [UIImage imageNamed: @"Flag_of_Nagano.png"];
            break;
        case Nagasaki :
            return [UIImage imageNamed: @"Flag_of_Nagasaki.png"];
            break;
        case Nara :
            return [UIImage imageNamed: @"Flag_of_Nara.png"];
            break;
        case Niigata :
            return [UIImage imageNamed: @"Flag_of_Niigata.png"];
            break;
        case Oita :
            return [UIImage imageNamed: @"Flag_of_Oita.png"];
            break;
        case Okayama :
            return [UIImage imageNamed: @"Flag_of_Okayama.png"];
            break;
        case Okinawa :
            return [UIImage imageNamed: @"Flag_of_Okinawa.png"];
            break;
        case Osaka :
            return [UIImage imageNamed: @"Flag_of_Osaka.png"];
            break;
        case Saga :
            return [UIImage imageNamed: @"Flag_of_Saga.png"];
            break;
        case Saitama :
            return [UIImage imageNamed: @"Flag_of_Saitama.png"];
            break;
        case Shiga :
            return [UIImage imageNamed: @"Flag_of_Shiga.png"];
            break;
        case Shimane :
            return [UIImage imageNamed: @"Flag_of_Shimane.png"];
            break;
        case Shizuoka :
            return [UIImage imageNamed: @"Flag_of_Shizuoka.png"];
            break;
        case Tochigi :
            return [UIImage imageNamed: @"Flag_of_Tochigi.png"];
            break;
        case Tokushima :
            return [UIImage imageNamed: @"Flag_of_Tokushima.png"];
            break;
        case Tokyo :
            return [UIImage imageNamed: @"Flag_of_Tokyo.png"];
            break;
        case Tottori :
            return [UIImage imageNamed: @"Flag_of_Tottori.png"];
            break;
        case Toyama :
            return [UIImage imageNamed: @"Flag_of_Toyama.png"];
            break;
        case Wakayama :
            return [UIImage imageNamed: @"Flag_of_Wakayama.png"];
            break;
        case Yamagata :
            return [UIImage imageNamed: @"Flag_of_Yamagata.png"];
            break;
        case Yamaguchi :
            return [UIImage imageNamed: @"Flag_of_Yamaguchi.png"];
            break;
        case Yamanashi :
            return [UIImage imageNamed: @"Flag_of_Yamanashi.png"];
            break;
        default: break;
    }
    return [UIImage imageNamed: @"Flag_of_Japan.png"];
}

+(UIImage*) flagForPrefectureName: (NSString*) prefectureName
{
    if([prefectureName localizedCaseInsensitiveContainsString:@"Aichi"])
    {
        return [UIImage imageNamed: @"Flag_of_Aichi.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Akita"])
    {
        return [UIImage imageNamed: @"Flag_of_Akita.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Aomori"])
    {
        return [UIImage imageNamed: @"Flag_of_Aomori.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Chiba"])
    {
        return [UIImage imageNamed: @"Flag_of_Chiba.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Chosen"])
    {
        return [UIImage imageNamed: @"Flag_of_Chosen.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Korea"])
    {
        return [UIImage imageNamed: @"Flag_of_Chosen.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Ehime"])
    {
        return [UIImage imageNamed: @"Flag_of_Ehime.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Fukui"])
    {
        return [UIImage imageNamed: @"Flag_of_Fukui.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Fukuoka"])
    {
        return [UIImage imageNamed: @"Flag_of_Fukuoka.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Fukushima"])
    {
        return [UIImage imageNamed: @"Flag_of_Fukushima.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Gifu"])
    {
        return [UIImage imageNamed: @"Flag_of_Gifu.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Gunma"])
    {
        return [UIImage imageNamed: @"Flag_of_Gunma.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Hiroshima"])
    {
        return [UIImage imageNamed: @"Flag_of_Hiroshima.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Hokkaido"])
    {
        return [UIImage imageNamed: @"Flag_of_Hokkaido.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Hyogo"])
    {
        return [UIImage imageNamed: @"Flag_of_Hyogo.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Ibaraki"])
    {
        return [UIImage imageNamed: @"Flag_of_Ibaraki.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Ishikawa"])
    {
        return [UIImage imageNamed: @"Flag_of_Ishikawa.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Iwate"])
    {
        return [UIImage imageNamed: @"Flag_of_Iwate.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Kagawa"])
    {
        return [UIImage imageNamed: @"Flag_of_Kagawa.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Kagoshima"])
    {
        return [UIImage imageNamed: @"Flag_of_Kagoshima.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Kanagawa"])
    {
        return [UIImage imageNamed: @"Flag_of_Kanagawa.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Karafuto"])
    {
        return [UIImage imageNamed: @"Flag_of_Karafuto.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Kochi"])
    {
        return [UIImage imageNamed: @"Flag_of_Kochi.png"];
    }
    
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Kumamoto"])
    {
        return [UIImage imageNamed: @"Flag_of_Kumamoto.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Kyoto"])
    {
        return [UIImage imageNamed: @"Flag_of_Kyoto.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Mie"])
    {
        return [UIImage imageNamed: @"Flag_of_Mie.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Miyagi"])
    {
        return [UIImage imageNamed: @"Flag_of_Miyagi.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Miyazaki"])
    {
        return [UIImage imageNamed: @"Flag_of_Miyazaki.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Nagano"])
    {
        return [UIImage imageNamed: @"Flag_of_Nagano.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Nagasaki"])
    {
        return [UIImage imageNamed: @"Flag_of_Nagasaki.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Nara"])
    {
        return [UIImage imageNamed: @"Flag_of_Nara.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Niigata"])
    {
        return [UIImage imageNamed: @"Flag_of_Niigata.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Oita"])
    {
        return [UIImage imageNamed: @"Flag_of_Oita.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Okayama"])
    {
        return [UIImage imageNamed: @"Flag_of_Okayama.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Okinawa"])
    {
        return [UIImage imageNamed: @"Flag_of_Okinawa.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Osaka"])
    {
        return [UIImage imageNamed: @"Flag_of_Osaka.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Saga"])
    {
        return [UIImage imageNamed: @"Flag_of_Saga.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Saitama"])
    {
        return [UIImage imageNamed: @"Flag_of_Saitama.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Shiga"])
    {
        return [UIImage imageNamed: @"Flag_of_Shiga.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Shimane"])
    {
        return [UIImage imageNamed: @"Flag_of_Shimane.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Shizuoka"])
    {
        return [UIImage imageNamed: @"Flag_of_Shizuoka.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Tochigi"])
    {
        return [UIImage imageNamed: @"Flag_of_Tochigi.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Tokushima"])
    {
        return [UIImage imageNamed: @"Flag_of_Tokushima.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Tokyo"])
    {
        return [UIImage imageNamed: @"Flag_of_Tokyo.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Tottori"])
    {
        return [UIImage imageNamed: @"Flag_of_Tottori.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Toyama"])
    {
        return [UIImage imageNamed: @"Flag_of_Toyama.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Wakayama"])
    {
        return [UIImage imageNamed: @"Flag_of_Wakayama.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Yamagata"])
    {
        return [UIImage imageNamed: @"Flag_of_Yamagata.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Yamaguchi"])
    {
        return [UIImage imageNamed: @"Flag_of_Yamaguchi.png"];
    }
    else if([prefectureName localizedCaseInsensitiveContainsString:@"Yamanashi"])
    {
        return [UIImage imageNamed: @"Flag_of_Yamanashi.png"];
    }

    return [UIImage imageNamed: @"Flag_of_Japan.png"];
}

//Some ships are not really ships, they're actually air flight names
+(UIImage*) flagForShipName: (NSString*) shipName
{
    NSArray *airFlightCompanies = @[@"AIR FRANCE", @"CHINA AIRLINES", @"JAPAN AIRLINES", @"KOREAN AIRLINES", @"PAN AMERICAN", @"VARIG"];
    
    for(NSString *companyName in airFlightCompanies)
    {
        if([shipName containsString: companyName])
        {
            return [UIImage imageNamed: @"airplane-icon"];
        }
    }
           
    return [UIImage imageNamed: @"ship-icon"];
}



//TODOFUKEN - https://en.wikipedia.org/wiki/Prefectures_of_Japan
+(NSString*) prefectureSuffix: (NSString*) prefectureName
{
    if([prefectureName containsString:@"TOKYO"])
    {
        return @"-TO";
    }
    
    else if([prefectureName localizedCaseInsensitiveContainsString:@"OSAKA"]||[prefectureName containsString:@"KYOTO"])
    {
        return @"-FU";
    }
    
    else if([prefectureName localizedCaseInsensitiveContainsString:@"KARAFUTO"])
    {
        return @"-CHO";
    }
    
    //Chōsen
    else if([prefectureName localizedCaseInsensitiveContainsString:@"KOREA"])
    {
        return @"(CHŌSEN)";
    }
    
    else if([prefectureName localizedCaseInsensitiveContainsString: @"HOKKAIDO"])
    {
        return @"(DŌ)";
    }
    
    return @"-KEN";
}

//Remove TODOFUKEN suffix: Our database doesn't contain these informations.
+(NSString*) removePrefectureSuffix: (NSString*) prefectureName
{
    if([prefectureName containsString:@"TOKYO"])
    {
        return @"TOKYO";
    }
    
    else if([prefectureName localizedCaseInsensitiveContainsString:@"OSAKA"])
    {
        return @"OSAKA";
    }
    
    if([prefectureName containsString:@"KYOTO"])
    {
        return @"KYOTO";
    }
    
    else if([prefectureName localizedCaseInsensitiveContainsString:@"KARAFUTO"])
    {
        return @"KARAFUTO";
    }
    
    //Chōsen
    else if([prefectureName localizedCaseInsensitiveContainsString:@"KOREA"])
    {
        return @"KOREA";
    }
    
    else if([prefectureName localizedCaseInsensitiveContainsString: @"HOKKAIDO"])
    {
        return @"HOKKAIDO";
    }
    
    return [prefectureName stringByReplacingOccurrencesOfString:@"-KEN" withString: @""];
}

+(NSString*) aliasFromFullName: (NSString*) fullName withLength: (NSUInteger) length
{
    if([fullName length]> length)
    {
        return  [NSString stringWithFormat: @"%@.", [fullName substringWithRange: NSMakeRange(0, (length -1))] ];
    }
    
    return fullName;
}

+(NSDictionary*) headerTitlesforNamesCollection: (NSArray*) collection
{
    NSArray *alphabet = A_Z_INDEXED_TITLES;
    NSMutableDictionary* headerTitles = [NSMutableDictionary dictionary];
    
    for(NSString* letter in alphabet){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",letter];
        NSArray *result = [collection filteredArrayUsingPredicate:predicate];
        if(result)
        {
            [headerTitles setObject: result forKey: letter];
        }
    }
    
    return headerTitles;
}


+(NSString*) cardinalNumber: (NSNumber*) number
{
    NSInteger integerNumber = [number integerValue];
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if([language containsString:@"en"])
    {
        switch (integerNumber)
        {
            case 0:
                return @"";
                break;
            case 1:
                return [NSString stringWithFormat: @"%@st", [number stringValue]];
                break;
            case 2:
                return [NSString stringWithFormat: @"%@nd", [number stringValue]];
                break;
            case 3:
                return [NSString stringWithFormat: @"%@rd", [number stringValue]];
                break;
            default:
                return [NSString stringWithFormat: @"%@th", [number stringValue]];
                break;
            
        }
    }
    
    else if([language containsString:@"en"])
    {
        return [NSString stringWithFormat: @"%@番", [number stringValue]];
    }
    
    else if([language containsString:@"pt"])
    {
        return [NSString stringWithFormat: @"%@°", [number stringValue]];
    }
    
    else return [number stringValue];
}

+(UIImage*) pictureForShipName: (NSString*) shipName withJourneyDate: (NSDate*)date
{
    if ([shipName isEqualToString: @"AFRICA-MARU"])
    {
        //21 October 1942 - Africa Maru I was sunk.
        //http://www.combinedfleet.com/Africa_t.htm
        NSDate *sunkDate = [Utilities dateFromString:@"21/10/1942" withLocale: nil];
        if([date compare: sunkDate] == NSOrderedDescending)
        {
            return [UIImage imageNamed: @"Steamer_Africa_Maru_II"];
        }
        
        return [UIImage imageNamed: @"Steamer_Africa_Maru_I"];
    }
    
    else if ([shipName isEqualToString:@"CHICAGO-MARU"])
    {
        return [UIImage imageNamed:@"Steamer_Chicago_Maru"];
    }

    else if ([shipName isEqualToString:@"TEIKOKU-MARU"])
    {
        return [UIImage imageNamed:@"Steamer_Teikoku_Maru"];
    }

    else if ([shipName isEqualToString:@"VARIG    RG - 083"])
    {
        return [UIImage imageNamed:@"Airplane_Varig"];
    }

    else if ([shipName isEqualToString:@"MANILA-MARU"])
    {
        return [UIImage imageNamed:@"Steamer_Manila_Maru"];
    }

    else if ([shipName isEqualToString:@"WAKASA-MARU"])
    {
         return [UIImage imageNamed: @"Steamer_Wakasa_Maru"];
    }

    else if ([shipName isEqualToString:@"JAPAN AIRLINES"])
    {
        return [UIImage imageNamed: @"Airplane_Japan_Airlines"];
    }

    else if ([shipName isEqualToString:@"JAPAN AIRLINES    JAL - 1008"])
    {
        return [UIImage imageNamed: @"Airplane_Japan_Airlines"];
    }

    else if ([shipName isEqualToString:@"BOLIVIA MARU"])
    {
        return [UIImage imageNamed:@"Steamer_Bolivia_Maru"];
    }

    else if ([shipName isEqualToString:@"PAN AMERICAN    PN - 008"])
    {
        return [UIImage imageNamed: @"Airplane_PanAmerican"];
    }

    else if ([shipName isEqualToString:@"JAPAN AIRLINES    JAL - 006"])
    {
        return [UIImage imageNamed: @"Airplane_Japan_Airlines"];
    }

    else if ([shipName isEqualToString:@"NIPPON-MARU"])
    {
        return [UIImage imageNamed:@"Steamer_Nippon_Maru"];
    }

    else if ([shipName isEqualToString:@"LA PLATA-MARU"])
    {
        //12 January 1945 - Sunk
        //http://www.wrecksite.eu/wreck.aspx?178008
        NSDate *sunkDate = [Utilities dateFromString:@"12/01/1945" withLocale: nil];
        if([date compare: sunkDate] == NSOrderedDescending)
        {
            return [UIImage imageNamed: @"Steamer_La_Plata_Maru_II"];
        }
        
        return [UIImage imageNamed: @"Steamer_La_Plata_Maru_I"];
    }

    else if ([shipName isEqualToString:@"ARY PARREIRAS"])
    {
        return [UIImage imageNamed: @"Steamer_Ary_Parreiras"];
    }

    else if ([shipName isEqualToString:@"JAPAN AIRLINES    JAL - 022"])
    {
        return [UIImage imageNamed: @"Airplane_Japan_Airlines"];
    }

    else if ([shipName isEqualToString:@"VARIG    RG - 815"])
    {
        return [UIImage imageNamed:@"Airplane_Varig"];
    }

    else if ([shipName isEqualToString:@"TACOMA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Tacoma_Maru"];
    }

    else if ([shipName isEqualToString:@"MEXICO-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Mexico_Maru"];
    }

    else if ([shipName isEqualToString:@"AMERICA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_America_Maru"];
    }

    else if ([shipName isEqualToString:@"HAKATA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Hakata_Maru"];
    }

    else if ([shipName isEqualToString:@"KOREAN AIRLINES    KE  -  002"])
    {
        return [UIImage imageNamed:@"Airplane_Korean_Airlines"];
    }

    else if ([shipName isEqualToString:@"TOSA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Tosa_Maru"];
    }

    else if ([shipName isEqualToString:@"SEATTLE-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Seattle_Maru"];
    }

    else if ([shipName isEqualToString:@"CANADA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Canada_Maru"];
    }

    else if ([shipName isEqualToString:@"サンラスピュー号"])
    {
        [UIImage imageNamed: @"Steamer_Other"];
    }

    else if ([shipName isEqualToString:@"JAPAN AIRLINES    JAL - 062"])
    {
        return [UIImage imageNamed: @"Airplane_Japan_Airlines"];
    }

    else if ([shipName isEqualToString:@"HAWAII-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Hawaii_Maru_I"];
    }

    else if ([shipName isEqualToString:@"KANAGAWA-MARU"])
    {
       return [UIImage imageNamed: @"Steamer_Kanagawa_Maru"];;
    }

    else if ([shipName isEqualToString:@"LOIDE PARAGUAY"])
    {
        return [UIImage imageNamed: @"Steamer_LoideParaguay"];
    }

    else if ([shipName isEqualToString:@"JAPAN AIRLINES    JAL - 064"])
    {
        return [UIImage imageNamed: @"Airplane_Japan_Airlines"];
    }

    else if ([shipName isEqualToString:@"AIR FRANCE     AF - 100"])
    {
        return [UIImage imageNamed: @"Airplane_Air_France"];
    }

    else if ([shipName isEqualToString:@"AIR FRANCE     "])
    {
        return [UIImage imageNamed: @"Airplane_Air_France"];
    }

    else if ([shipName isEqualToString:@"JAPAN AIRLINES    JAL - 074"])
    {
        return [UIImage imageNamed: @"Airplane_Japan_Airlines"];
    }

    else if ([shipName isEqualToString:@"TJISADANE"])
    {
        return [UIImage imageNamed: @"Steamer_Tsjisadane"];
    }

    else if ([shipName isEqualToString:@"VARIG    RG - 831"])
    {
        return [UIImage imageNamed:@"Airplane_Varig"];
    }

    else if ([shipName isEqualToString:@"CHINA AIRLINES   CHINA - 002"])
    {
        return [UIImage imageNamed:@"Airplane_China_Airlines"];
    }

    else if ([shipName isEqualToString:@"MONTEVIDEO-MARU"])
    {
        //1 July 1942 - Sunk
        //http://www.wrecksite.eu/wreck.aspx?137052
        NSDate *sunkDate = [Utilities dateFromString:@"01/07/1942" withLocale: nil];
        if([date compare: sunkDate] == NSOrderedDescending)
        {
            return [UIImage imageNamed: @"Steamer_Montevideo_Maru_II"];
        }
        
        return [UIImage imageNamed: @"Steamer_Montevideo_Maru_I"];
    }

    else if ([shipName isEqualToString:@"TEGELBERG"])
    {
        return [UIImage imageNamed: @"Steamer_Tegelberg"];
    }

    else if ([shipName isEqualToString:@"DAIZUI-MARU"])
    {
        return [UIImage imageNamed: @"SteameSteamer_Daizui_Marur_Tegelberg"];
    }

    else if ([shipName isEqualToString:@"SAKURA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Sakura_Maru"];
    }

    else if ([shipName isEqualToString:@"BRASIL-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Brasil_Maru"];
    }

    else if ([shipName isEqualToString:@"SANTOS-MARU"])
    {
        {
            //25 November 1944 - Sunk
            //http://www.wrecksite.eu/wreck.aspx?137052
            NSDate *sunkDate = [Utilities dateFromString:@"25/11/1944" withLocale: nil];
            if([date compare: sunkDate] == NSOrderedDescending)
            {
                return [UIImage imageNamed: @"Steamer_Santos_Maru_II"];
            }
            
            return [UIImage imageNamed: @"Steamer_Santos_Maru_I"];
        }

    }

    else if ([shipName isEqualToString:@"PANAMA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Tjitjalengka"];
    }

    else if ([shipName isEqualToString:@"TJITJALENGKA"])
    {
        return [UIImage imageNamed: @"Steamer_Tjitjalengka"];
    }

    else if ([shipName isEqualToString:@"BINGO-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Bingo_Maru"];
    }

    else if ([shipName isEqualToString:@"PAN AMERICAN"])
    {
        return [UIImage imageNamed: @"Airplane_PanAmerican"];
    }

    else if ([shipName isEqualToString:@"ITSUKUSHIMA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Itsukushima_Maru"];
    }

    else if ([shipName isEqualToString:@"KOHKA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Kohka_Maru"];
    }

    else if ([shipName isEqualToString:@"VARIG    RG - 833"])
    {
        return [UIImage imageNamed:@"Airplane_Varig"];
    }

    else if ([shipName isEqualToString:@"KAWACHI-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Kawachi_Maru"];
    }

    else if ([shipName isEqualToString:@"BOISSEVAIN"])
    {
        return [UIImage imageNamed: @"Steamer_Boissevain"];
    }

    else if ([shipName isEqualToString:@"KASATO-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Kasato_Maru"];
    }

    else if ([shipName isEqualToString:@"RIO DE JANEIRO-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Rio_de_Janeiro_Maru"];
    }

    else if ([shipName isEqualToString:@"RYOJUN-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Ryojun_Maru"];
    }

    else if ([shipName isEqualToString:@"BUENOS AIRES-MARU"])
    {
        //27 November 1943 - Sunk
        //http://www.wrecksite.eu/wreck.aspx?138697
        NSDate *sunkDate = [Utilities dateFromString:@"27/11/1943" withLocale: nil];
        if([date compare: sunkDate] == NSOrderedDescending)
        {
            return [UIImage imageNamed: @"Steamer_Buenos_Aires_Maru_II"];
        }
        
        return [UIImage imageNamed: @"Steamer_Buenos_Aires_Maru_I"];
    }

    else if ([shipName isEqualToString:@"CHILI"])
    {
        return [UIImage imageNamed: @"Steamer_Chili"];
    }

    else if ([shipName isEqualToString:@"AWA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Awa_Maru"];
    }

    else if ([shipName isEqualToString:@"SANUKI-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Sanuki_Maru"];
    }

    else if ([shipName isEqualToString:@"VARIG  VIAÇÃO AÉREA RIO GRANDENSE"])
    {
        return [UIImage imageNamed: @"Airplane_Varig"];
    }

    else if ([shipName isEqualToString:@"PAN AMERICAN    PN - 020"])
    {
        return [UIImage imageNamed: @"Airplane_PanAmerican"];
    }

    else if ([shipName isEqualToString:@"ARGENTINA-MARU"])
    {
        //1 September 1946 - Got scrapped
        //https://en.wikipedia.org/wiki/Japanese_aircraft_carrier_Kaiy%C5%8D
        NSDate *sunkDate = [Utilities dateFromString:@"1/9/1946" withLocale: nil];
        if([date compare: sunkDate] == NSOrderedDescending)
        {
            return [UIImage imageNamed: @"Steamer_Argentina_Maru_II"];
        }
        
        return [UIImage imageNamed: @"Steamer_Argentina_Maru_I"];
    }

    else if ([shipName isEqualToString:@"DAINIUNKAI-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Daini_Unkai_Maru"];
    }

    else if ([shipName isEqualToString:@"ARIZONA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Arizona_Maru"];
    }

    else if ([shipName isEqualToString:@"FUSHIMI-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Fushimi_Maru"];
    }

    else if ([shipName isEqualToString:@"PAN AMERICAN    PN - 830"])
    {
         return [UIImage imageNamed: @"Airplane_PanAmerican"];
    }

    else if ([shipName isEqualToString:@"RUYS"])
    {
        return [UIImage imageNamed: @"Steamer_Ruys"];
    }

    else if ([shipName isEqualToString:@"KAMAKURA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Kamakura_Maru"];
    }

    else if ([shipName isEqualToString:@"ARABIA-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Arabia_Maru"];
    }

    else if ([shipName isEqualToString:@"OUTROS"])
    {
        [UIImage imageNamed: @"Steamer_Other"];
    }

    else if ([shipName isEqualToString:@"SEIUN-MARU"])
    {
        return [UIImage imageNamed: @"Steamer_Seiun_Maru"];
    }
    
    return nil;
}
@end
