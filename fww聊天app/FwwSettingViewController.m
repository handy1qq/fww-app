//
//  FwwSettingViewController.m
//  fww聊天app
//
//  Created by fengwenwei on 16/9/28.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import "FwwSettingViewController.h"
#import "EMClient.h"


@interface FwwSettingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logOut;

/**当前登录的帐号 */
@property (strong, nonatomic) NSString *userName;

@end

@implementation FwwSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1] ];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] ];

    
    self.userName = [EMClient sharedClient].currentUsername;
    NSString *title = [ [NSString alloc] initWithFormat:@"log out (%@)",self.userName];
    [self.logOut setTitle:title forState:UIControlStateNormal];
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutAction:(id)sender {
   [ [EMClient sharedClient]logout:YES completion:^(EMError *aError) {
       if (aError) {
           NSLog(@"退出失败");
       } else {
           NSLog(@"退出成功");
       }
   }];
    self.view.window.rootViewController = [UIStoryboard storyboardWithName:@"Login" bundle:nil].instantiateInitialViewController;
}


@end
