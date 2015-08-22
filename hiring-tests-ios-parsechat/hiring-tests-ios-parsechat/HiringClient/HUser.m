//
//  HUser.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "HUser.h"

@implementation HUser

@dynamic profileUrlString;
@dynamic fullName;

+ (HUser *)user
{
    return (HUser *)[PFUser user];
}

@end
