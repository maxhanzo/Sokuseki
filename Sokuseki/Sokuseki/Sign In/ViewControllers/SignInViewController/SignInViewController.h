//
//  SignInViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 9/3/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <TwitterKit/TwitterKit.h>
@import GoogleSignIn;

@interface SignInViewController : UIViewController<GIDSignInUIDelegate, GIDSignInDelegate>
@property (nonatomic, weak) IBOutlet UITextField *txtEmail;
@property (nonatomic, weak) IBOutlet UITextField *txtPassword;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView* activityIndicatorView;
@property(nonatomic, weak) IBOutlet UIView* activityIndicatorBackgroundView;
@property(nonatomic, weak) IBOutlet TWTRLogInButton* btnTwitterLoginButton;


-(IBAction) signInWithPassword: (id) sender;
-(IBAction) signInWithFacebook: (id) sender;
-(IBAction) signInWithTwitter: (id) sender;
-(IBAction) signInWithGoogle: (id) sender;
-(void) stopActivityIndicator;
@end
