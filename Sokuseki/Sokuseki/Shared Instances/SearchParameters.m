//
//  SearchParameters.m
//  Sokuseki
//
//  Created by Max Ueda on 12/15/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "SearchParameters.h"

@implementation SearchParameters
+ (SearchParameters*)getSharedInstance
{
    static SearchParameters *_sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedInstance = [[super allocWithZone:NULL]init];
    });
    return _sharedInstance;
}

- (id)init {
    if ((self = [super init])) {
        
    }
    return self;
}

-(void) resetInstance
{
    self.immigrantName = nil;
    self.immigrantSurname = nil;
    self.immigrantNameKanji = nil;
    self.immigrantSurnameKanji  = nil;
    self.immigrantShip = nil;
    self.immigrantPrefecture = nil;
    self.immigrationYear = nil;
    self.searchAshiatoParameters = nil;
}



//Enters background: Filter is saved.
- (void)saveState{
    NSMutableData *data = [NSMutableData data];
    if (data)
    {
        NSKeyedArchiver *coder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [coder encodeObject:self.immigrantName forKey:@"immigrantName"];
        [coder encodeObject:self.immigrantSurname forKey:@"immigrantSurname"];
        [coder encodeObject:self.immigrantNameKanji forKey:@"immigrantNameKanji"];
        [coder encodeObject:self.immigrantSurnameKanji forKey:@"immigrantSurnameKanji"];
        [coder encodeObject:self.immigrantShip forKey:@"immigrantShip"];
        [coder encodeObject:self.immigrantPrefecture forKey:@"immigrantPrefecture"];
        [coder encodeObject:self.immigrationYear forKey:@"immigrationYear"];
        [coder encodeObject: self.searchAshiatoParameters forKey: @"searchAshiatoParameters"];
        [coder finishEncoding];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:FILTER_STATE_FILENAME_SEARCH];
    
    // Save instance state to file system
    [data writeToFile:dataPath atomically:YES];
    
}


//back from background: filter is loaded.
- (void)loadState {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString* rootPath = paths[0];
    
    NSString *filePath = [rootPath stringByAppendingPathComponent:FILTER_STATE_FILENAME_SEARCH];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
    
    if (data) { // Might not have any initial state.
        NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        self.immigrantName = [decoder decodeObjectForKey:@"immigrantName"];
        self.immigrantSurname = [decoder decodeObjectForKey:@"immigrantSurname"];
        self.immigrantNameKanji = [decoder decodeObjectForKey:@"immigrantNameKanji"];
        self.immigrantSurnameKanji = [decoder decodeObjectForKey:@"immigrantSurnameKanji"];
        self.immigrantPrefecture = [decoder decodeObjectForKey:@"immigrantPrefecture"];
        self.immigrantShip = [decoder decodeObjectForKey:@"immigrantShip"];
        self.immigrationYear = [decoder decodeObjectForKey:@"immigrationYear"];
        self.searchAshiatoParameters = [decoder decodeObjectForKey:@"searchAshiatoParameters"];
        [decoder finishDecoding];
    }
    
}

//If user signs out.
-(void) deleteFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* rootPath = paths[0];
    NSString *filePath = [rootPath stringByAppendingPathComponent:FILTER_STATE_FILENAME_SEARCH];
    
    NSError *error;
    [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
    
    if (error)
    {
        NSLog(@"%@", error);
    }
}




@end
