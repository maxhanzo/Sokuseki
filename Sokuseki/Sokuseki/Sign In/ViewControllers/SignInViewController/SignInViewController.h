//
//  SignInViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 9/3/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITextField *txtEmail;
@property (nonatomic, weak) IBOutlet UITextField *txtPassword;

-(IBAction) signInWithPassword: (id) sender;
-(IBAction) signInWithFacebook: (id) sender;
-(IBAction) signInWithTwitter: (id) sender;
-(IBAction) signInWithGoogle: (id) sender;
@end
