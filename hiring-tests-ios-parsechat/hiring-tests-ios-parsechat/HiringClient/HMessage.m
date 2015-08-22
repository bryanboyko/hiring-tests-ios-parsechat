//
//  HMessage.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "HMessage.h"

@implementation HMessage

@dynamic senderProfilePicUrl;
@dynamic messageText;
@dynamic senderId;
@dynamic senderFullName;
@dynamic sentAt;


- (instancetype)initWithUsername:(NSString *)username
                        fullName:(NSString *)fullName
                     messageText:(NSString *)text
                profileUrlString:(NSString *)profUrlString
{
    if (self = [super init]) {
        self.senderId = username;
        self.senderFullName = fullName;
        self.messageText = text;
        self.senderProfilePicUrl = profUrlString;
        self.sentAt = [NSDate date];
    }
    return self;
}

+ (NSString *)parseClassName
{
    return @"HMessage";
}

@end
