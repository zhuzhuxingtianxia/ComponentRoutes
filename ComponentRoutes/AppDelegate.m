//
//  AppDelegate.m
//  ComponentRoutes
//
//  Created by Jion on 2017/3/3.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "AppDelegate.h"
#import "TabbarController.h"
#import <JLRoutes.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}
//设置通用链接的时候使用
-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{
    if (userActivity.activityType == NSUserActivityTypeBrowsingWeb) {
        NSURL *webpageURL = userActivity.webpageURL;
        NSString *webHost = webpageURL.host;
        if ([webHost isEqualToString:@"domain.com"]) {
            if (webpageURL.pathComponents.count>= 4) {
                //do something
            }
        }
    }
    return YES;
    
}
//iOS9一下系统使用
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation{
    
    BOOL route = [JLRoutes routeURL:url];
    return route;
}

//iOS10以上系统
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options{
    
    BOOL route = [JLRoutes routeURL:url];
    return route;
    
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


@end
