//
//  HFactory.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "HClientPublic.h"
#import <Foundation/Foundation.h>

#define GET_OR_CREATE(varname, vartype) \
if (varname == nil)                     \
{                                       \
varname = [[vartype alloc] init];       \
}                                       \
return varname;                         \

@implementation HFactory

+(HFactory *)sharedFactory
{
    static HFactory *factory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        factory = [[HFactory alloc] init];
    });
    return factory;
}

- (HUserService *)userService
{
    GET_OR_CREATE(_userService, HUserService);
}

- (HMessageService *)messageService
{
    GET_OR_CREATE(_messageService, HMessageService);
}

@end
