//
//  LoginVC.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "LoginVC.h"
#import "HClientPublic.h"
#import "Loaders.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginVC () <FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginButton;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fbLoginButton.delegate = self;
    self.fbLoginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
}

- (IBAction)loginButtonPressed:(id)sender
{
    [Loaders showBlockingLoaderWithText:@"Signing in"];
    if (self.nameTextField.text.length > 0) {
        
        [sender setEnabled:NO];
        __weak __typeof(self)weakSelf = self;
        [H_FACTORY.userService signupUserWithName:self.nameTextField.text
                                    andCompletion:
         ^(BOOL success, NSError *error) {
             __strong __typeof(weakSelf)strongSelf = weakSelf;
             if (error)
             {
                 [[[UIAlertView alloc] initWithTitle:@"Invalid user" message:@"The name you have entered could not be registered" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                 
                 [sender setEnabled:YES];
             } else
             {
                 // user successfully signed up with parse
                 [Loaders showSuccessHUDWithtext:@"Logged in to Parse" withTimeout:1.0f];
                 [strongSelf.nameTextField resignFirstResponder];
             }
             [Loaders hideBlockingLoader];
         }];
    }
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    if (error) {
        NSLog(@"error loggin into facebook: %@", error);
    } else {
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate userSignedUp];
    }
}



@end
