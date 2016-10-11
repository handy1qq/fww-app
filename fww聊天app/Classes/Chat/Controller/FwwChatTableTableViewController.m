//
//  FwwChatTableTableViewController.m
//  fww聊天app
//
//  Created by fengwenwei on 16/9/24.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import "FwwChatTableTableViewController.h"
#import "EMSDKFull.h"
#import "EMMessage.h"
#import "EMContactManagerDelegate.h"
#import "IEMContactManager.h"
#import "FwwTabBar.h"

@interface FwwChatTableTableViewController ()<EMClientDelegate,EMContactManagerDelegate,UIAlertViewDelegate>
/**<#注释#> */
@property (strong, nonatomic) NSString *userName1;

/**<#注释#> */
@property (copy, nonatomic) NSString *friendName;

/**tabBar */
@property (strong, nonatomic) FwwTabBar *tabBar;





@end

@implementation FwwChatTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ [EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [ [EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    self.tabBar = [ [FwwTabBar alloc] init];
    [self.tabBar setTabBar:self.tabBarController];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1] ];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] ];


    
}

- (void)dealloc {
    [ [EMClient sharedClient] removeDelegate:self];
}

- (void)connectionStateDidChange:(EMConnectionState)aConnectionState {
    /** 只执行一次 */
           if (aConnectionState == EMConnectionConnected) {
//            [self titlestring:@"提示" messagestring:@"已经连接到网络" surestring:@"确定"];
            NSLog(@"已经连接到网络");
        } else if (aConnectionState == EMConnectionDisconnected) {
            NSLog(@"已经断开连接到网络");
            [self titlestring:@"提示" messagestring:@"已经断开连接到网络" surestring:@"确定"];
        }
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)friendRequestDidApproveByUser:(NSString *)aUsername {
    NSLog(@"添加好友成功");
}

- (void)friendshipDidRemoveByUser:(NSString *)aUsername {
    NSLog(@"chat用户%@删除你",aUsername);
    
}

- (void)friendRequestDidDeclineByUser:(NSString *)aUsername {
    NSLog(@"用户:%@拒绝添加你为好友",aUsername);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

- (void)titlestring:(NSString *)titlestring messagestring: (NSString *)messagestring surestring: (NSString *)surestring {
    UIAlertView *alert = [ [UIAlertView alloc] initWithTitle:titlestring message:messagestring delegate:self cancelButtonTitle:nil otherButtonTitles:surestring, nil];
    [alert show];
    
}

#pragma mark - 接收好友的添加请求

- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage {
    self.friendName = aUsername;
    UIAlertView *aler = [ [UIAlertView alloc] initWithTitle:@"提示" message:aMessage delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"同意", nil];
    [aler show];
    
    NSLog(@"%@,%@",aUsername,aMessage);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [ [EMClient sharedClient].contactManager declineInvitationForUsername:self.friendName];
    } else {
        [ [EMClient sharedClient].contactManager acceptInvitationForUsername:self.friendName];
    }

}




@end
