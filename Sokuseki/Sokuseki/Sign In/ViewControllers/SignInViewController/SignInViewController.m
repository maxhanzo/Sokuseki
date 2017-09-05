//
//  SignInViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 9/3/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import "SignInViewController.h"
#import "SignInSignUpBusiness.h"
@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

-(IBAction) signInWithPassword: (id) sender
{
    NSString *email = self.txtEmail.text ?: @"";
    NSString *password = self.txtPassword.text ?: @"";
    if(([email length]>0) && ([password length]>0))
    {
        //Login with Firebase
        [self performSegueWithIdentifier: @"SignInSegue" sender: self];
    }
    
    else
    {
        [self alertControllerWithMessage: @"Preencha todos os campos!"];
    }
}
-(IBAction) signInWithFacebook: (id) sender{}
-(IBAction) signInWithTwitter: (id) sender{}
-(IBAction) signInWithGoogle: (id) sender{}

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

@end
