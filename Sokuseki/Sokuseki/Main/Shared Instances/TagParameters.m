//
//  TagParameters.m
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "TagParameters.h"

@implementation TagParameters

+ (TagParameters*)getSharedInstance
{
    static TagParameters *_sharedInstance = nil;
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
    self.parameter = nil;
}



//Enters background: Filter is saved.
- (void)saveState{
    NSMutableData *data = [NSMutableData data];
    if (data)
    {
        NSKeyedArchiver *coder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [coder encodeObject:self.parameter forKey:@"parameter"];
        [coder finishEncoding];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:FILTER_STATE_FILENAME];
    
    // Save instance state to file system
    [data writeToFile:dataPath atomically:YES];
    
}


//back from background: filter is loaded.
- (void)loadState {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString* rootPath = paths[0];
    
    NSString *filePath = [rootPath stringByAppendingPathComponent:FILTER_STATE_FILENAME];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
    
    if (data) { // Might not have any initial state.
        NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        self.parameter = [decoder decodeObjectForKey:@"parameter"];
        [decoder finishDecoding];
        
    }
    
}

//If user signs out.
-(void) deleteFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* rootPath = paths[0];
    NSString *filePath = [rootPath stringByAppendingPathComponent:FILTER_STATE_FILENAME];
    
    NSError *error;
    [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
    
    if (error)
    {
        NSLog(@"%@", error);
    }
}




@end
