//
//  AppDelegate.m
//  MyiOSTest
//
//  Created by houzirui on 2021/10/19.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    UIViewController *controller1=[[UIViewController alloc] init];
    controller1.view.backgroundColor = [UIColor redColor];
    UIViewController *controller2=[[UIViewController alloc] init];
    controller2.view.backgroundColor=[UIColor blueColor];
    UIViewController *controller3=[[UIViewController alloc] init];
    controller3.view.backgroundColor=[UIColor blackColor];
    UIViewController *controller4=[[UIViewController alloc] init];
    controller4.view.backgroundColor=[UIColor greenColor];
    
    [tabBarController setViewControllers:@[controller1,controller2,controller3,controller4]];
    self.window.rootViewController =tabBarController;
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
