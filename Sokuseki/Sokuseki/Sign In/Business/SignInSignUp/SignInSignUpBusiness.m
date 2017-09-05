//
//  SignInSignUpBusiness.m
//  Sokuseki
//
//  Created by Ticket Services on 04/09/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import "SignInSignUpBusiness.h"


@implementation SignInSignUpBusiness


+(BOOL) confirmPassword: (NSString*) password withConfirmation: (NSString*) confirmation
{
    return [password isEqualToString: confirmation];
}



+ (BOOL) validateEmail: (NSString *) email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}
@end
