//
//  HUser.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "PFUser.h"

@interface HUser : PFUser

+ (HUser *)user;

@property (nonatomic, strong) NSString *profileUrlString;
@property (nonatomic, strong) NSString *fullName;

@end
