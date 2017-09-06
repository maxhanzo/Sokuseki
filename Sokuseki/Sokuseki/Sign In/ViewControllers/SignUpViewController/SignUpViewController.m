//
//  SignUpViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 9/3/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignInSignUpBusiness.h"
@import Firebase;

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self.activityIndicatorBackgroundView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SignInViewController *destinationViewController = segue.destinationViewController;
    if([destinationViewController isKindOfClass: [SignInViewController class]])
    {
        destinationViewController.txtEmail.text = self.txtEmail.text;
        destinationViewController.txtPassword.text = self.txtPassword.text;
    }
}

-(IBAction)submitSignUpInformation:(id)sender
{
    [self startActivityIndicator];
    NSString* email = self.txtEmail.text ?: @"";
    NSString* password = self.txtPassword.text ?: @"";
    NSString* confirmPassword = self.txtConfirmPassword.text ?: @"";
    
    if(([email length] == 0)|| ([password length] == 0) || ([confirmPassword length] == 0))
    {
        [self alertControllerWithMessage:@"Preencha todos os campos"];
    }
    
    else
    {
        if([SignInSignUpBusiness validateEmail:email])
        {
            if([SignInSignUpBusiness confirmPassword:password withConfirmation:confirmPassword])
            {
                //TODO Firebase stuff
                [[FIRAuth auth] createUserWithEmail:email
                                           password:password
                                         completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
                                             if(!error)
                                             {
                                                 [self clearFields];
                                                 [self performUnwindSignInSegue];
                                             }
                                             
                                             else
                                             {
                                                 [self stopActivityIndicator];
                                                 [self alertControllerWithMessage: @"Erro ao criar conta."];
                                             }
                                         }];

                
                
            }
            else
            {
                [self stopActivityIndicator];
                [self alertControllerWithMessage: @"A senha não confere. Confirme sua senha."];
            }
        }
        else
        {
            [self stopActivityIndicator];
            [self alertControllerWithMessage: @"Email inválido. Digite um email no formato exemplo@exemplo.com."];
        }
    }
}

-(void) alertControllerWithMessage: (NSString*) message
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) startActivityIndicator
{
    [self.activityIndicatorBackgroundView setHidden:NO];
    [self.activityIndicatorView startAnimating];
    [self.view bringSubviewToFront: self.activityIndicatorBackgroundView];
}

-(void) stopActivityIndicator
{
    [self.activityIndicatorView stopAnimating];
    [self.view sendSubviewToBack: self.activityIndicatorBackgroundView];
    [self.activityIndicatorBackgroundView setHidden:YES];
}

-(void) performUnwindSignInSegue
{
    [self stopActivityIndicator];
    [self performSegueWithIdentifier:@"UnwindSignUp" sender:self];
}

-(void) clearFields
{
    self.txtEmail.text = @"";
    self.txtPassword.text = @"";
    self.txtConfirmPassword.text = @"";
}

@end
