//
//  SignInSignUpBusiness.h
//  Sokuseki
//
//  Created by Ticket Services on 04/09/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignInSignUpBusiness : NSObject
+(BOOL) confirmPassword: (NSString*) password withConfirmation: (NSString*) confirmation;
+(BOOL) validateEmail: (NSString *) email;

@end
