//
//  AppDelegate.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "AppDelegate.h"
#import "MessagingVC.h"
#import "HClientPublic.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    MessagingVC *mVC = [[MessagingVC alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:mVC];
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    
    [self connectWithParse];

    [FBSDKLoginButton class];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)connectWithParse
{
    [HMessage registerSubclass];
    [HUser registerSubclass];
    [Parse setApplicationId:@"XKpaUO7KuMasBJ2o8yeTeTtQh7rI8uujLBbM6Kni"
                  clientKey:@"WPTmIZQkr2BCkfhlYvGiUktbjongxGezifz6JhkO"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
