//
//  HUserService.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//


#import "HClientPublic.h"
#import "NSString+HApp.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation HUserService

#pragma mark login methods


- (void)loginWithCompletion:(HCompletionHandler)handler
{
    __weak __typeof(self)weakSelf = self;
    [PFUser logInWithUsernameInBackground:[HUser currentUser].username
                                 password:[HPasswordManager sharedManager].password
                                    block:
     ^(PFUser *user, NSError *error) {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
         handler(user, error);
         [strongSelf loadPicUrl];
     }];
}

- (void)signupUserWithName:(NSString *)name andCompletion:(HSuccessHandler)handler
{
    HUser *user = [HUser user];
    // later would set username to a unique id
    user.username = name;
    user.fullName = name;
    user.password = [NSString stringWithFormat:@"%@%@", [user.fullName MD5String], @"password"];
    [HPasswordManager sharedManager].password = user.password;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        handler(succeeded, error);
    }];
}

- (void)loadPicUrl
{
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSString *fbUserId = result[@"id"];
                 NSString *profileUrlString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", fbUserId];
                 [HUser currentUser].profileUrlString = profileUrlString;
             } else {
                 NSLog(@"error fetching facebook user: %@", error);
             }
         }];
    }
}


@end
