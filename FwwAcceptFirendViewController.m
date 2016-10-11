//
//  FwwAcceptFirendViewController.m
//  fww聊天app
//
//  Created by fengwenwei on 16/9/25.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import "FwwAcceptFirendViewController.h"
#import "EMClient.h"
#import "IEMContactManager.h"


@interface FwwAcceptFirendViewController ()<EMContactManagerDelegate>

@end

@implementation FwwAcceptFirendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"!!!!%@",self.userName);
    [ [EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1] ];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] ];

    // Do any additional setup after loading the view.
}

-(void)dealloc {
    [ [EMClient sharedClient].contactManager removeDelegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)aggreeAddFriendAction:(id)sender {
    EMError *error = [ [EMClient sharedClient].contactManager acceptInvitationForUsername:self.userName];
    if (!error) {
        NSLog(@"同意添加好友成功");
    }
}

- (IBAction)rejectAddFirendAction:(id)sender {
    EMError *error = [ [EMClient sharedClient].contactManager declineInvitationForUsername:self.userName];
    if (!error) {
        NSLog(@"拒绝添加好友成功");
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
