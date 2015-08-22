//
//  HClientConstants.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#ifndef hiring_tests_ios_parsechat_HClientConstants_h
#define hiring_tests_ios_parsechat_HClientConstants_h

#define FULL_NAME_KEY   		@"fullNameKey"
#define INSTALLATION_ID_KEY @"installationId"
#define PASSWORD_KEY        @"passwordKey"

typedef void (^HCompletionHandler)(id result, NSError *error);
typedef void (^HSuccessHandler)(BOOL success, NSError *error);

#endif
