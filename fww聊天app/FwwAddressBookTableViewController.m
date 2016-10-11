
//
//  FwwAddressBookTableViewController.m
//  fww聊天app
//
//  Created by fengwenwei on 16/9/25.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import "AppDelegate.h"
#import "FwwAddressBookTableViewController.h"
#import "EMClient.h"
#import "EMContactManagerDelegate.h"
#import "IEMContactManager.h"
#import "FwwAddFirendViewController.h"
#import "EMContactManagerDelegate.h"
#import "FwwChatTableTableViewController.h"

//extern NSString *userName11;

@interface FwwAddressBookTableViewController ()<EMContactManagerDelegate,UIAlertViewDelegate,EMClientDelegate>
/**申请者 */

/**<#注释#> */
@property (strong, nonatomic) FwwAddFirendViewController *userId;

/**好友列表 */
@property (strong, nonatomic) NSArray *serverFriendList;
/**<#注释#> */
@property (strong, nonatomic) NSArray *localFriendList;
/**<#注释#> */
@property (strong, nonatomic) NSArray *array;
/**<#注释#> */
@property (strong, nonatomic) NSSet *set;

@end

@implementation FwwAddressBookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ [EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    [ [ EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [self compareServerBetweenLocal];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1] ];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] ];

}

- (void)compareServerBetweenLocal {
    /**服务器数据 */
    EMError *error = nil;
    self.serverFriendList = [ [EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    
    /**本地数据 */
    self.localFriendList = [  [EMClient sharedClient].contactManager getContacts];
    NSLog(@"localFriendList:%@",self.localFriendList);
    
    NSMutableArray *mArray = [NSMutableArray array];
    NSArray *array = [NSArray array];
    [mArray addObjectsFromArray:self.serverFriendList];
    [mArray addObjectsFromArray:self.localFriendList];
    array = [NSArray arrayWithArray:mArray];
    self.set = [NSSet setWithArray:array];
    NSArray *arrara = [NSArray array];
    self.array = [self.set sortedArrayUsingDescriptors:arrara];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [ [EMClient sharedClient].contactManager removeDelegate:self];

}

- (IBAction)toAdressListAction:(id)sender {
//    self.userId = [ [FwwAddFirendViewController alloc] init];
//        self.userId = [ [self storyboard] instantiateViewControllerWithIdentifier:@"addFriend"];
//    self.userId.userName = self.userName;
//    NSLog(@"%@",self.userId.userName);
}

//B->A  ,a,b
- (void)friendshipDidAddByUser:(NSString *)aUsername {
    EMError *error = nil;
        self.serverFriendList = [ [EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    [self compareServerBetweenLocal];
    [self.tableView reloadData];
}

- (void)friendshipDidRemoveByUser:(NSString *)aUsername {
    EMError *error = nil;
    NSLog(@"asdasdasdasd");
    self.serverFriendList = [ [EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    [self compareServerBetweenLocal];
    [self.tableView reloadData];
}


/**删除好友 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"%@",cell.textLabel.text);
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [ [EMClient sharedClient].contactManager deleteContact:cell.textLabel.text];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"BuddyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = self.array[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"chatListCellHead"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    AppDelegate *publicValue = [UIApplication sharedApplication].delegate;
    publicValue.toFriend = cell.textLabel.text;
    NSLog(@"name!!!!:%@",publicValue.toFriend);

}

@end
