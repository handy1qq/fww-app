//
//  FwwLoginViewController.m
//  fww聊天app
//
//  Created by fengwenwei on 16/9/21.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import "FwwLoginViewController.h"
#import "EMSDKFull.h"
#import "EMSDK.h"
#import "EMError.h"
//#import "EMClient.h"
#import "AppDelegate.h"
#import "EMError.h"



@interface FwwLoginViewController ()<UITextFieldDelegate,EMClientDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;

/**EMCline的对象 */
@property (strong, nonatomic) EMClient *cline;

/**Appdelegate */
@property (strong, nonatomic) AppDelegate *app;

@property (strong, nonatomic) IBOutlet UIButton *logIn;

@property (strong, nonatomic) IBOutlet UIButton *registerB;
@end

@implementation FwwLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameField.delegate = self;
    self.passWordField.delegate = self;
    self.passWordField.secureTextEntry = YES;
    
    self.userNameField.layer.cornerRadius = 5.0;
    self.passWordField.layer.cornerRadius = 5.0;
    self.logIn.layer.cornerRadius = 5.0;
    self.registerB.layer.cornerRadius = 5.0;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"] ];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerAction:(id)sender {
    //判断是否输入用户名或密码
    if ( (self.userNameField.text.length && self.passWordField.text.length) <1 ) {
        UIAlertView *alerview = [ [UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名或密码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alerview show];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [ [EMClient sharedClient]registerWithUsername:self.userNameField.text password:self.userNameField.text];
        
        if (!error) {
              [ [EMClient sharedClient].options setIsAutoLogin:YES];
            NSLog(@"注册成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alerview = [ [UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功，请登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alerview show];
            });
        } else {
            switch (error.code) {
                case EMErrorServerNotReachable:
                    NSLog(@"服务找不到");
                    break;
                case EMErrorUserAlreadyExist:
                    NSLog(@"用户名已经存在");
                    NSLog(@"%@",error.errorDescription);

                    break;
                case EMErrorNetworkUnavailable:
                    NSLog(@"wangl不可用");
                    break;
                case EMErrorServerTimeout:
                   NSLog(@"服务超时");
                    break;
                default:
                    break;
            }
 
        }
    });

    
}

- (IBAction)loginAction:(id)sender {
    
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:self.userNameField.text password:self.passWordField.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                NSLog(@"登录成功");
                UIAlertView *alerview = [ [UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alerview show];
                //两种界面跳转
                
//                UIStoryboard *Chatstoryboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
//                UIViewController *chat = [Chatstoryboard instantiateViewControllerWithIdentifier:@"Chat"];
//                [self.navigationController pushViewController:chat animated:YES];
                
                self.view.window.rootViewController = [UIStoryboard storyboardWithName:@"Chat" bundle:nil].instantiateInitialViewController;
                

                
              //  [self.cline bindDeviceToken:<#(NSData *)#>]
        } else {
            switch (error.code) {
                case EMErrorUserAuthenticationFailed:
                    [self titlestring:@"提示" messagestring:@"密码验证错误" surestring:@"确定"];
                    break;
                default:
                    NSLog(@"登录失败");
                    [self titlestring:@"提示" messagestring:@"登录失败" surestring:@"确定"];
                    break;
            }
        }
        });

        });
        
    }
}




- (void)titlestring:(NSString *)titlestring messagestring: (NSString *)messagestring surestring: (NSString *)surestring {
    UIAlertView *alert = [ [UIAlertView alloc] initWithTitle:titlestring message:messagestring delegate:self cancelButtonTitle:nil otherButtonTitles:surestring, nil];
    [alert show];
    
}
@end
