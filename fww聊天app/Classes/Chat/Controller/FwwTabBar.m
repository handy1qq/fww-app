//
//  FwwTabBar.m
//  fww聊天app
//
//  Created by fengwenwei on 16/10/10.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import "FwwTabBar.h"

@implementation FwwTabBar
- (void)setTabBar:(UITabBarController *)tabBarController {
    UITabBarController *tabBarCtr = tabBarController;
    UITabBar *tabBars = tabBarCtr.tabBar;
    UIEdgeInsets insets = UIEdgeInsetsMake(3, 0, -3, 0);
    UITabBarItem *tabBarItem0 = [tabBars.items objectAtIndex:0];
    UITabBarItem *tabBarItem1 = [tabBars.items objectAtIndex:1];
    UITabBarItem *tabBarItem2 = [tabBars.items objectAtIndex:2];
    
    tabBarItem0.selectedImage = [UIImage imageNamed:@"phone183"];
    tabBarItem0.image = [ [UIImage imageNamed:@"phone183"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem0.title = @"好友信息";
    tabBarItem0.imageInsets = insets;
    
    tabBarItem1.selectedImage = [UIImage imageNamed:@"font-369"];
    tabBarItem1.image = [ [UIImage imageNamed:@"font-369"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem1.title = @"好友通讯录";
    
    tabBarItem2.selectedImage = [UIImage imageNamed:@"settings"];
    tabBarItem2.image = [ [UIImage imageNamed:@"settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2.title = @"设置信息";
}

@end
