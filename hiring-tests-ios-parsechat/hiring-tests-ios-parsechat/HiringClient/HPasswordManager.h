//
//  HPasswordManager.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPasswordManager : NSObject

+(HPasswordManager *)sharedManager;

@property (nonatomic, strong) NSString *password;


@end
