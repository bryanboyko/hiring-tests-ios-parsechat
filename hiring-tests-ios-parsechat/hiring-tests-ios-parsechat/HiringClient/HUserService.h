//
//  HUserService.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HClientFwds.h"

@interface HUserService : NSObject

// will currently use Parse and PFUser instead of this class. if i were building a version of this app that could be used on top of a backend other than parse, I would build out this class to manage saving, loading, and fetching user info

// for now we can either just use PFUser, or setup this class as a wrapper on PFUser

@end
