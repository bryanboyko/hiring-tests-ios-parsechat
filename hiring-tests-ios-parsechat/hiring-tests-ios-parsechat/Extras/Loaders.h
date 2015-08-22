//
//  Loaders.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Loaders : NSObject

+(void)showSuccessHUDWithtext:(NSString *)text withTimeout:(NSTimeInterval)timeout;
+(void)showBlockingLoaderWithText:(NSString *)text;
+(void)hideBlockingLoader;

@end
