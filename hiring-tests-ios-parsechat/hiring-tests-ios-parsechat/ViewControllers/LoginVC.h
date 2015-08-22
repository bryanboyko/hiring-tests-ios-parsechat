//
//  LoginVC.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginVCDelegate;

@interface LoginVC : UIViewController

@property (nonatomic, weak) id<LoginVCDelegate> delegate;

@end

@protocol LoginVCDelegate <NSObject>

- (void)userSignedUp;

@end
