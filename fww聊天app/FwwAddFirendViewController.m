//
//  FwwAddressListViewController.m
//  fww聊天app
//
//  Created by fengwenwei on 16/9/24.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import "FwwAddFirendViewController.h"
#import "EMClient.h"
#import "EMMessage.h"
#import "EMError.h"
#import "IEMContactManager.h"
#import "EMContactManagerDelegate.h"
//#import "EMClientDelegate.h"
#import "FwwChatTableTableViewController.h"


@interface FwwAddFirendViewController ()<EMContactManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *addFriendTextField;


@end

@implementation FwwAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"~~~%@",self.userName);
      [ [EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
//    [ [EMClient sharedClient].contactManager removeDelegate:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [ [EMClient sharedClient].contactManager removeDelegate:self];
}



- (IBAction)addFriendAction:(id)sender {
//    EMError *error = nil;
//    NSArray *userlist = [ [EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
//    
//    if (!error) {
//        NSLog(@"从服务器获取好友列表成功");
//        NSLog(@"!!!!%@",userlist);
  //  }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      //  EMError *error = [ [EMClient sharedClient].contactManager addContact:self.addFriendTextField.text message:@"我想加你为好友"];
      //  if (!error) {
//            NSLog(@"~~~恭喜发送添加请求成功");
//        }
        [ [EMClient sharedClient].contactManager addContact:self.addFriendTextField.text message:@"dsa" completion:^(NSString *aUsername, EMError *aError) {
            NSLog(@"%@,%@",aUsername,aError);
        }];

    });
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
@end
