//
//  HPasswordManager.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "HPasswordManager.h"
#import "HClientPublic.h"

@implementation HPasswordManager

+(HPasswordManager *)sharedManager
{
    static HPasswordManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[HPasswordManager alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _password = [[NSUserDefaults standardUserDefaults] objectForKey:PASSWORD_KEY];
    }
    return self;
}

- (void)setPassword:(NSString *)password
{
    _password = password;
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:PASSWORD_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
