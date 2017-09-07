//
//  SignInViewController.m
//  Sokuseki
//
//  Created by Max Ueda on 9/3/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//
#import "SignInViewController.h"
#import "SignInSignUpBusiness.h"

@import Firebase;

@interface SignInViewController ()
@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    
    [self.btnTwitterLoginButton setLogInCompletion:^(TWTRSession *session, NSError *error) {
        // play with Twitter session
        if(error != nil) {
           
            
        } else {
            FIRAuthCredential *credential =
            [FIRTwitterAuthProvider credentialWithToken:session.authToken
                                                 secret:session.authTokenSecret];
            [[FIRAuth auth] signInWithCredential:credential
                                      completion:^(FIRUser *user, NSError *error) {
                                          if (error) {
                                              NSLog(@"Error - Twitter");
                                              return;
                                          }
                                          [self performSignInSegue];
                                      }];
        }
    }];

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
    [self startActivityIndicator];
    NSString *email = self.txtEmail.text ?: @"";
    NSString *password = self.txtPassword.text ?: @"";
    if(([email length]>0) && ([password length]>0))
    {
        if([SignInSignUpBusiness validateEmail:email])
        {
            [[FIRAuth auth] signInWithEmail:email
                                   password:password
                                 completion:^(FIRUser *user, NSError *error) {
                                     if(!error)
                                     {
                                         [self clearFields];
                                         [self performSignInSegue];
                                     }
                                     
                                     else
                                     {
                                         [self stopActivityIndicator];
                                         [self alertControllerWithMessage: @"Erro ao autenticar. Corrija os dados e tente novamente ."];
                                     }
                                 }];
           
        }
        
        else
        {
            [self stopActivityIndicator];
            [self alertControllerWithMessage: @"Digite um email válido. Ex: nome@email.com ."];
        }
    }
    
    else
    {   [self stopActivityIndicator];
        [self alertControllerWithMessage: @"Preencha todos os campos!"];
    }
}
-(IBAction) signInWithFacebook: (id) sender
{
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email"] fromViewController: self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
            NSLog(@"error %@",error);
        } else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"Cancelled");
        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                                 credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
                [[FIRAuth auth] signInWithCredential:credential
                                          completion:^(FIRUser *user, NSError *error) {
                                              if (error) {
                                                  // ...
                                                  return;
                                              }
                                              else
                                              {
                                                   [self performSignInSegue];
                                              }
                                          }];
            }
        }
    }];
}
-(IBAction) signInWithTwitter: (id) sender
{

}
-(IBAction) signInWithGoogle: (id) sender
{
   
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

-(void) performSignInSegue
{
    [self stopActivityIndicator];
    [self performSegueWithIdentifier: @"SignInSegue" sender: self];
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

-(void) clearFields
{
    self.txtEmail.text = @"";
    self.txtPassword.text = @"";
}

#pragma mark Google Sign In stuff
// Present a view that prompts the user to sign in with Google
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    //[myActivityIndicator stopAnimating];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // ...
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential =
        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                         accessToken:authentication.accessToken];
        [self startActivityIndicator];
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                      if (error) {
                                          // ...
                                          return;
                                      }
                                      [self performSignInSegue];
                                  }];
        
    } else {
        NSLog(@"%@", error);
    }
}


@end
