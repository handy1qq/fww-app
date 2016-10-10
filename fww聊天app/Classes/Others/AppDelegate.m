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

@interface AppDelegate ()<EMChatManagerDelegate,EMClientDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    EMOptions *options = [EMOptions optionsWithAppkey:@"1156160921115059#fwwchat"];
    options.apnsCertName = @"apnsCertName";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (isAutoLogin) {
        NSLog(@"yes");
        [ [EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
        self.window.rootViewController = [UIStoryboard storyboardWithName:@"Chat" bundle:nil].instantiateInitialViewController;
    }
    
   
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
//                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
//                                                                             categories:nil]];
//
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
    
   
       return YES;
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
