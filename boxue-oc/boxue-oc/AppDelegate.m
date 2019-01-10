//
//  AppDelegate.m
//  boxue-oc
//
//  Created by hui xiang on 2019/1/9.
//  Copyright © 2019 xianghui. All rights reserved.
//

#import "AppDelegate.h"

#import "BaseNavigationController.h"
#import "BXMainTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    BXMainTableViewController *mainVc = [[BXMainTableViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:mainVc];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [self startLaunchingAnimation];
    
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
}

- (void)startLaunchingAnimation {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIView *launchScreenView = viewController.view;
    
//    UIView *launchScreenView = [[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil].firstObject;
    launchScreenView.frame = window.bounds;
    [window addSubview:launchScreenView];
    
    UIImageView *backgroundImageView = launchScreenView.subviews[0];
    backgroundImageView.clipsToBounds = YES;
    
//    UIImageView *logoImageView = launchScreenView.subviews[0];
//    UILabel *copyrightLabel = launchScreenView.subviews.lastObject;
    
    UIView *maskView = [[UIView alloc] initWithFrame:launchScreenView.bounds];
    maskView.backgroundColor = UIColorWhite;
    [launchScreenView insertSubview:maskView belowSubview:backgroundImageView];
    
    [launchScreenView layoutIfNeeded];
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        logoImageView.alpha = 0.0;
//        maskView.alpha = 0;
//        backgroundImageView.alpha = 0;
//        CGRect logoFrame = logoImageView.frame;
//        logoFrame.origin.y = 100;
//        logoImageView.frame = logoFrame;
        launchScreenView.alpha = 0;
    } completion:^(BOOL finished) {
        [launchScreenView removeFromSuperview];
    }];
}

@end
