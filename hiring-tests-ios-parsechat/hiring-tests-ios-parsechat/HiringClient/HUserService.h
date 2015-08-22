//
//  HUserService.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HClientFwds.h"

@interface HUserService : NSObject

- (void)loginWithCompletion:(HCompletionHandler)handler;
- (void)signupUserWithName:(NSString *)name andCompletion:(HSuccessHandler)handler;

@end
