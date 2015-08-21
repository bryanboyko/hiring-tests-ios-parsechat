//
//  HMessageService.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "HClientPublic.h"

@implementation HMessageService

// NOTE: i did not setup pagination. every time the app opens, all messages from parse will be loaded. in order to paginate I would create a custom uitableview subclass that would also house the table data source (which is currently managed by MessagingVC)


@end
