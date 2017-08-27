//
//  Constants.h
//  Shin Ashiato
//
//  Created by Max Ueda on 7/27/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#ifndef Shin_Ashiato_Constants_h
#define Shin_Ashiato_Constants_h
//
//  Ticket_ProjectDefinitions.h
//  TicketAppPOC
//
//  Created by Max Ueda on 4/16/14.
//  Copyright (c) 2014 Ticket. All rights reserved.
//

//URLS

//iPhone Screen size related
#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone  (UI_USER_INTERFACE_IDIOM() == 0)?TRUE:FALSE
#define iPhone5TicketAccountBalanceTableFrame() CGRectMake(15, 235, 280, 282)
#define iPhone4TicketAccountBalanceTableFrame() CGRectMake(15, 235, 280, 200)

//UI Elements

//Chart tooltip coordinates
#define kMaxChartPointX 218.0f
#define kMinChartPointX 15.0f
//#define kMaxChartPointY

#define UINavigationBarReferenceHeight 64 //TODO: check if there is a UIKit constant or something like that
//Headers (Cells used to define a section label)
#define headerRowHeight 20
#define defaultRowHeight 44

//Card Types
#define TicketRestaurante 1 //TR
#define TicketAlimentacao 2 //TA
#define TicketCar 3 //TC
#define TicketCultura 4 //TK
#define TicketTransporte 5 //TT


//Ticket Phone Numbers
#define centralUsuarioPhone @"40042233"
#define centralEstabelecimentoPhone @"40043355"
#define centralRHPhone @"40039000"

//Alert tags
enum { ConfirmCard, ConfirmAddCard, AddCardFail, ConfirmDeleteCard };


//Some Colors
#define kTicketLightBlueColor UIColorFromHex(0x0096fd)
#define kTicketLightRedColor UIColorFromHex(0xf75b68)
#define kTicketLightWhiteColor UIColorFromHex(0xffffff)
#define kTicketDarkGrayColor UIColorFromHex(0x858e85)

//searchKeys
#define NameKanjiKey 0
#define NameRomajiKey 1
#define SurnameKanjiKey 2
#define SurnameRomajiKey 3
#define ImmigrationYearKey 4
#define PrefectureNameKey 5
#define ShipNameKey 6


//Parameter Types
#define None 0
#define NameRomaji 1
#define SurnameRomaji 2
#define NameKanji 3
#define SurnameKanji 4
#define Ship 5
#define Prefecture 6
#define ImmigrationYear 7
#define Cancel 8

//Every table will need this. 
#define abcArray [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"サ", nil]
#define abcArrayImmigrants [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil]

//Prefecture codes for flags
#define Aichi 1001
#define Akita 1002
#define Aomori 1003
#define Chiba 1004
#define Chosen 1005
#define Ehime 1006
#define Fukui 1007
#define Fukuoka 1008
#define Fukushima 1009
#define Gifu 1010
#define Gunma 1011
#define Hiroshima 1012
#define Hokkaido 1013
#define Hyogo 1014
#define Ibaraki 1015
#define Ishikawa 1016
#define Iwate 1017
#define Kagawa 1018
#define Kagoshima 1019
#define Kanagawa 1020
#define Karafuto 1021
#define Kochi 1022
#define Kumamoto 1023
#define Kyoto 1024
#define Mie 1025
#define Miyagi 1026
#define Miyazaki 1027
#define Nagano 1028
#define Nagasaki 1029
#define Nara 1030
#define Niigata 1031
#define Oita 1032
#define Okayama 1033
#define Okinawa 1034
#define Osaka 1035
#define Saga 1036
#define Saitama 1037
#define Shiga 1038
#define Shimane 1039
#define Shizuoka 1040
#define Tochigi 1041
#define Tokushima 1042
#define Tokyo 1043
#define Tottori 1044
#define Toyama 1045
#define Wakayama 1046
#define Yamagata 1047
#define Yamaguchi 1048
#define Yamanashi 1049


//All Romaji Names
#define PREFECTURE_NAMES_ARRAY [NSArray arrayWithObjects: @"HOKKAIDO",@"IWATE",@"FUKUSHIMA",@"NAGANO",@"NIIGATA",@"AKITA",@"GIFU",@"AOMORI",@"YAMAGATA",@"KAGOSHIMA",@"HIROSHIMA",@"HYOGO",@"SHIZUOKA",@"MIYAZAKI",@"KUMAMOTO",@"MIYAGI",@"OKAYAMA",@"KOCHI",@"SHIMANE",@"TOCHIGI",@"GUNMA",@"OITA",@"YAMAGUCHI",@"IBARAKI",@"MIE",@"EHIME",@"AICHI",@"CHIBA",@"FUKUOKA",@"WAKAYAMA",@"KYOTO",@"YAMANASHI",@"TOYAMA",@"FUKUI",@"ISHIKAWA",@"TOKUSHIMA",@"NAGASAKI",@"SHIGA",@"SAITAMA",@"NARA",@"TOTTORI",@"SAGA",@"KANAGAWA",@"OKINAWA",@"TOKYO",@"OSAKA",@"KAGAWA",@"KARAFUTO",@"KOREA",nil]
//All Ships Names
#define SHIPS_NAMES_ARRAY [NSArray arrayWithObjects: @"AFRICA-MARU", @"CHICAGO-MARU", @"TEIKOKU-MARU", @"VARIG    RG - 083", @"MANILA-MARU", @"WAKASA-MARU", @"JAPAN AIRLINES", @"JAPAN AIRLINES    JAL - 1008", @"BOLIVIA MARU", @"PAN AMERICAN    PN - 008", @"JAPAN AIRLINES    JAL - 006", @"NIPPON-MARU", @"LA PLATA-MARU", @"ARY PARREIRAS", @"JAPAN AIRLINES    JAL - 022", @"VARIG    RG - 815", @"TACOMA-MARU", @"MEXICO-MARU", @"AMERICA-MARU", @"HAKATA-MARU", @"KOREAN AIRLINES    KE  -  002", @"TOSA-MARU", @"SEATTLE-MARU", @"CANADA-MARU", @"サンラスピュー号", @"JAPAN AIRLINES    JAL - 062", @"HAWAII-MARU", @"KANAGAWA-MARU", @"LOIDE PARAGUAY", @"JAPAN AIRLINES    JAL - 064", @"AIR FRANCE     AF - 100", @"AIR FRANCE     ", @"JAPAN AIRLINES    JAL - 074", @"TJISADANE", @"VARIG    RG - 831", @"CHINA AIRLINES   CHINA - 002", @"MONTEVIDEO-MARU", @"TEGELBERG", @"DAIZUI-MARU", @"SAKURA-MARU", @"BRASIL-MARU", @"SANTOS-MARU", @"PANAMA-MARU", @"TJITJALENGKA", @"BINGO-MARU", @"PAN AMERICAN", @"ITSUKUSHIMA-MARU", @"KOHKA-MARU", @"VARIG    RG - 833", @"KAWACHI-MARU", @"BOISSEVAIN", @"NÃO CONSTA", @"KASATO-MARU", @"RIO DE JANEIRO-MARU", @"RYOJUN-MARU", @"BUENOS AIRES-MARU",@"Chili", @"AWA-MARU", @"SANUKI-MARU", @"VARIG  VIAÇÃO AÉREA RIO GRANDENSE", @"PAN AMERICAN    PN - 020", @"ARGENTINA-MARU", @"DAINIUNKAI-MARU", @"ARIZONA-MARU", @"FUSHIMI-MARU", @"PAN AMERICAN    PN - 830", @"RUYS", @"KAMAKURA-MARU", @"ARABIA-MARU", @"OUTROS", @"SEIUN-MARU", nil]

#define A_Z_INDEXED_TITLES @[@"A" ,@"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];

//Each page: 440 records
#define TEN_INDEXED_TITLES @[@"1" ,@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25"];






#endif
