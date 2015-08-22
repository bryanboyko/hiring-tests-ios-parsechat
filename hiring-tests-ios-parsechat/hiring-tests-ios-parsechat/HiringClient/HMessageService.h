//
//  HMessageService.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HClientFwds.h"

@interface HMessageService : NSObject

- (void)loadAllMessagesWithCompletion:(HCompletionHandler)handler;
- (void)sendMessage:(HMessage *)message withCompletion:(HSuccessHandler)handler;
- (void)deleteMessage:(HMessage *)message withCompletion:(HSuccessHandler)handler;

@end
