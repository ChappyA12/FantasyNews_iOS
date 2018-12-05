//
//  AppDelegate.m
//  FantasyNews
//
//  Created by Chappy Asel on 11/28/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "AppDelegate.h"
#import <LGSideMenuController/LGSideMenuController.h>
#import "MainViewController.h"
#import "FNCoreData.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIColor reloadNavigationBarAppearance];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"main"];
    vc.mode = MODE_RECENT;
    MainViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"menu"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window makeKeyAndVisible];
    LGSideMenuController *svc = [[LGSideMenuController alloc] initWithRootViewController:nav
                                                                      leftViewController:lvc
                                                                     rightViewController:nil];
    [self.window.rootViewController presentViewController:svc animated:NO completion:NULL];
    svc.leftViewWidth = 300;
    svc.leftViewInitialOffsetX = -300;
    svc.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;
    svc.leftViewStatusBarStyle = UIStatusBarStyleLightContent;
    svc.leftViewCoverAlpha = 0;
    svc.rootViewStatusBarStyle = UIStatusBarStyleLightContent;
    svc.rootViewCoverAlphaForLeftView = 0.1;
    svc.rootViewCoverColorForLeftView = UIColor.blackColor;
    svc.rootViewLayerShadowColor = UIColor.clearColor;
    svc.leftViewAnimationDuration = 0.5;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [FNCoreData.sharedInstance save];
}

@end
