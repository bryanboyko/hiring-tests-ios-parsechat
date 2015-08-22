//
//  HMessageService.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HClientPublic.h"
#import <Parse/Parse.h>

@implementation HMessageService

// NOTE: i did not setup pagination. every time the app opens, all messages from parse will be loaded. in order to paginate I would create a custom uitableview subclass that would also house the table data source (which is currently managed by MessagingVC)

- (void)loadAllMessagesWithCompletion:(HCompletionHandler)handler
{
    PFQuery *query = [PFQuery queryWithClassName:@"HMessage"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        handler(objects, error);
    }];
}

- (void)sendMessage:(HMessage *)message withCompletion:(HSuccessHandler)handler
{
    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        handler(succeeded, error);
    }];
}


- (void)deleteMessage:(HMessage *)message withCompletion:(HSuccessHandler)handler
{
    [message deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        handler(succeeded, error);
    }];
}


@end
