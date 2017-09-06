//
//  SignUpViewController.h
//  Sokuseki
//
//  Created by Max Ueda on 9/3/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignInViewController.h"
@interface SignUpViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITextField *txtEmail;
@property (nonatomic, weak) IBOutlet UITextField *txtPassword;
@property (nonatomic, weak) IBOutlet UITextField *txtConfirmPassword;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView* activityIndicatorView;
@property(nonatomic, weak) IBOutlet UIView* activityIndicatorBackgroundView;
@end
