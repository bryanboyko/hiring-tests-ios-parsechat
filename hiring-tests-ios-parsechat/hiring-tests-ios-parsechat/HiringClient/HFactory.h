//
//  HFactory.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HClientFwds.h"

@interface HFactory : NSObject

+ (HFactory *)sharedFactory;

@property (nonatomic, strong) HUserService *userService;
@property (nonatomic, strong) HMessageService *messageService;

@end
