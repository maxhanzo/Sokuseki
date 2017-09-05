//
//  SignUpViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 9/3/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignInSignUpBusiness.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
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
    NSString* email = self.txtEmail.text ?: @"";
    NSString* password = self.txtPassword.text ?: @"";
    NSString* confirmPassword = self.txtConfirmPassword.text ?: @"";
    
    if(([email length] == 0)&& ([password length] == 0) && ([confirmPassword length] == 0))
    {
        [self alertControllerWithMessage:@"Preencha todos os campos"];
    }
    
    else
    {
        if([SignInSignUpBusiness validateEmail:email])
        {
            if([SignInSignUpBusiness confirmPassword:password withConfirmation:confirmPassword])
            {
                //Firebase stuff
                [self performSegueWithIdentifier:@"SignUpSegue" sender:self];
            }
            else
            {
                
                [self alertControllerWithMessage: @"A senha não confere. Confirme sua senha."];
            }
        }
        else
        {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
