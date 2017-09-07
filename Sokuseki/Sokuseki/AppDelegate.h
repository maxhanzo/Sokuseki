//
//  AppDelegate.h
//  Sokuseki
//
//  Created by Max Ueda on 12/13/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleSignIn;

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;
//These properties are to deal with the Database "read only" problem.
//http://stackoverflow.com/questions/12000311/sqlite-ios-attempt-to-write-a-readonly-database

@property (nonatomic,retain) NSFileManager *fileMgr;
@property (nonatomic,retain) NSString *homeDir;

@end

