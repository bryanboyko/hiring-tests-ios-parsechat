//
//  Loaders.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "Loaders.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "PCAngularActivityIndicatorView.h"

@implementation Loaders

+(void)showSuccessHUDWithtext:(NSString *)text withTimeout:(NSTimeInterval)timeout
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.progress = 1.0;
        UIImageView *customView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [customView setContentMode:UIViewContentModeScaleAspectFill];
        [customView setImage:[UIImage imageNamed:@"iconPostSuccess"]];
        hud.customView = customView;
        
        hud.labelText = text;
        [hud show:YES];
        if (timeout > 0)
        {
            [NSTimer scheduledTimerWithTimeInterval:timeout
                                             target:self
                                           selector:@selector(hideSuccessHUD)
                                           userInfo:nil
                                            repeats:NO];
        }
    });
}

+(void)hideSuccessHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
        MBProgressHUD *hud = [MBProgressHUD HUDForView:[[[UIApplication sharedApplication] delegate] window]];
        hud = nil;
    });
}

+(void)showBlockingLoaderWithText:(NSString *)text
{
    [self showBlockingLoaderWithText:text withBackground:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8]];
}

+(void)showBlockingLoaderWithText:(NSString *)text withBackground:(UIColor *)bgColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideBlockingLoader];
        PCAngularActivityIndicatorView *activityIndicator = [[PCAngularActivityIndicatorView alloc] initWithActivityIndicatorStyle:PCAngularActivityIndicatorViewStyleLarge];
        [activityIndicator startAnimating];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
        hud.backgroundColor = bgColor;
        hud.mode = MBProgressHUDModeCustomView;
        hud.progress = 1.0;
        hud.customView = activityIndicator;
        
        // set text
        hud.labelText = text;
        [hud show:YES];
    });
}

+(void)hideBlockingLoader {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
        MBProgressHUD *hud = [MBProgressHUD HUDForView:[[[UIApplication sharedApplication] delegate] window]];
        hud = nil;
    });
}

@end
