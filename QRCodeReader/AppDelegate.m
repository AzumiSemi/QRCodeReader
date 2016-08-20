//
//  AppDelegate.m
//  QRCodeReader
//
//  Created by Tsubasa Yonenaga on 2016/06/24.
//  Copyright © 2016年 Tsubasa Yonenaga. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () {
    RDVTabBarController *_tabbarController;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    QRCodeReaderViewController *barcodereader = [QRCodeReaderViewController new];
    UINavigationController *barcodereadernavi = [[UINavigationController alloc] initWithRootViewController:barcodereader];
    QRCodeViewController *qrVC = [QRCodeViewController new];
    UINavigationController *qrVCnavi = [[UINavigationController alloc] initWithRootViewController:qrVC];
    
    _tabbarController = [RDVTabBarController new];
    [_tabbarController setViewControllers:@[barcodereadernavi, qrVCnavi]];
    _window.rootViewController = _tabbarController;
    [self custmizeTabBarController:_tabbarController];
    [_window makeKeyAndVisible];
    return YES;
}

- (void) custmizeTabBarController:(RDVTabBarController *)tabBarController {
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        NSArray *tabBarItemsImages = @[@"QRCodeReader_Image", @"QRCode_Image"];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", [tabBarItemsImages objectAtIndex:index]]];
        UIImage *unselectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal", [tabBarItemsImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
        index++;
    }
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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
