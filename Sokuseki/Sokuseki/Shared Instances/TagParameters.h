//
//  TagParameters.h
//  Sokuseki
//
//  Created by Max Ueda on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FILTER_STATE_FILENAME @"filterStateTagParameters.dat"


@interface TagParameters : NSObject

+ (TagParameters*)getSharedInstance;

@property(nonatomic, strong) NSString *parameter;


-(void) resetInstance;

//Saving & loading state
- (void)saveState;
//back from background: filter is loaded.
- (void)loadState;
//If user signs out.
-(void) deleteFile;
@end
