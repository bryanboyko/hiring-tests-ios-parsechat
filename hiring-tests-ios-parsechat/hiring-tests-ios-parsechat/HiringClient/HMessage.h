//
//  HMessage.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "PFObject.h"

@interface HMessage : PFObject <PFSubclassing>

- (instancetype)initWithUsername:(NSString *)username
                        fullName:(NSString *)fullName
                     messageText:(NSString *)text
                profileUrlString:(NSString *)profUrlString;

 + (NSString *)parseClassName;

@property (nonatomic, strong) NSString *senderProfilePicUrl;
@property (nonatomic, strong) NSString *messageText;
@property (nonatomic, strong) NSString *senderId;
@property (nonatomic, strong) NSString *senderFullName;
@property (nonatomic, strong) NSDate *sentAt;

@end
