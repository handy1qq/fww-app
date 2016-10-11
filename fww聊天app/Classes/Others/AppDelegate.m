//
//  AppDelegate.m
//  fww聊天app
//
//  Created by fengwenwei on 16/9/21.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import "AppDelegate.h"
#import  "EMSDKFull.h"
#import "EMClientDelegate.h"
#import "EMClientDelegate.h"
#import <UIKit/UIKit.h>

@interface AppDelegate ()<EMChatManagerDelegate,EMClientDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    AppDelegate *publicValue = (AppDelegate *)[UIApplication sharedApplication].delegate;
    publicValue.toFriend = @"";
    
    
    
    EMOptions *options = [EMOptions optionsWithAppkey:@"1156160921115059#fwwchat"];
    options.apnsCertName = @"apnsCertName";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [ [EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (isAutoLogin) {
        NSLog(@"yes");
        [ [EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
        self.window.rootViewController = [UIStoryboard storyboardWithName:@"Chat" bundle:nil].instantiateInitialViewController;
    }
//    BOOL isLoggedIn = [EMClient sharedClient].isLoggedIn;
//    if (isLoggedIn) {
//        /**设置tabBar */
//        UITabBarController *tabBarController = (UITabBarController *) self.window.rootViewController;
//        UITabBar *tabBar = tabBarController.tabBar;
//        UIEdgeInsets insets = UIEdgeInsetsMake(3, 0, -3, 0);
//        UITabBarItem *tabBarItem0 = [tabBar.items objectAtIndex:0];
//        UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:1];
//        UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:2];
//        
//        tabBarItem0.selectedImage = [UIImage imageNamed:@"phone183"];
//        tabBarItem0.image = [ [UIImage imageNamed:@"phone183"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        tabBarItem0.title = @"好友信息";
//        tabBarItem0.imageInsets = insets;
//        
//        tabBarItem1.selectedImage = [UIImage imageNamed:@"font-369"];
//        tabBarItem1.image = [ [UIImage imageNamed:@"font-369"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        tabBarItem1.title = @"好友通讯录";
//        
//        tabBarItem2.selectedImage = [UIImage imageNamed:@"settings"];
//        tabBarItem2.image = [ [UIImage imageNamed:@"settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        tabBarItem2.title = @"设置信息";
//    }
    
   

    
    
    
    
    
    
    
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
//                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
//                                                                             categories:nil]];
//
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    //[ [EMClient sharedClient] uploadLogToServer];
       return YES;
}

- (void)dealloc {
    [ [EMClient sharedClient].chatManager removeDelegate:self];


}

- (void)connectionStateDidChange:(EMConnectionState)aConnectionState {
    
        if (aConnectionState == EMConnectionConnected) {
            NSLog(@"已经连接到网络");
        } else if (aConnectionState == EMConnectionDisconnected) {
            NSLog(@"已经断开连接到网络");
        }

}



- (void)autoLoginDidCompleteWithError:(EMError *)aError {
    NSLog(@"%@",aError);
}



// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@",deviceToken);



}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%@",error);


}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
