//
//  FwwChatViewController.m
//  fww聊天app
//
//  Created by fengwenwei on 16/9/28.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import "FwwChatViewController.h"
#import "FwwChatCell.h"
#import "EMClient.h"
#import "IEMChatManager.h"
//#import "EMChatManagerDelegate.h"
#import "EMMessage.h"
#import "EMTextMessageBody.h"
#import "AppDelegate.h"
#import "EMError.h"
#import "EMConversation.h"
#import "FwwTimeCell.h"
#import "FwwTimeTool.h"

@interface FwwChatViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,EMChatManagerDelegate>

/**底部工具条 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputtToolBottomConstraint;

/** 计算textView的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputToolBarHegightConstraint;

/**<#注释#> */
@property (strong, nonatomic) NSMutableArray *dataSources;
/**<#注释#> */
@property (strong, nonatomic) NSMutableArray *data;


/**计算cell高度 */
@property (strong, nonatomic) FwwChatCell *chatCellTool;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**<#注释#> */
@property (strong, nonatomic) NSString *tofriend;

/**<#注释#> */
@property (copy, nonatomic) NSString *currentstri;





@end

@implementation FwwChatViewController
- (NSMutableArray *)dataSources {
    if ( !_dataSources ) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1] ];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] ];


    AppDelegate *publicValue = [UIApplication sharedApplication].delegate;
    self.tofriend = publicValue.toFriend;
    
    //导航栏显示好友名字
    self.title = self.tofriend;
    
    [ [EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
     //给计算高度的工具赋值
    self.chatCellTool = [self.tableView dequeueReusableCellWithIdentifier:ReceverCell];

    
//    self.tabBarController.tabBar.hidden = YES;
    
    /**通知，监听键盘 */
    [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    /**通知 ，键盘消失 */
    [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbDisASppear:) name:UIKeyboardWillHideNotification object:nil];
    
    //加载聊天数据
    [self loadLocalChatRecords];
    
    //[self.data addObject:@"asdasdasd"];
}

#pragma mark - 键盘显示会触发
- (void)kbWillShow: (NSNotification *)noti {
    //获取键盘的高度
      //获取键盘结束的位置
    CGRect kbEndFrm = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kbHeight = kbEndFrm.size.height;
    //更改约束
    self.inputtToolBottomConstraint.constant = kbHeight;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)kbDisASppear: (NSNotification *)noti {
    self.inputtToolBottomConstraint.constant = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [ [NSNotificationCenter defaultCenter] removeObserver:self];

}

#pragma mark - 表格数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}


#pragma mark -  表格高度   
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( [self.dataSources[indexPath.row] isKindOfClass:[NSString class] ] ) {
        return 32;
    }
    
    EMMessage *msg = self.dataSources[indexPath.row];
    self.chatCellTool.message = msg;
        
    return [self.chatCellTool cellHeight];
}

#pragma mark - cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ( [self.dataSources[indexPath.row] isKindOfClass:[NSString class] ] ) {
        FwwTimeCell *timeCell = [self.tableView dequeueReusableCellWithIdentifier:@"TimeCell"];
        timeCell.timeLabel.text = self.dataSources[indexPath.row];
        return timeCell;
    }
    
    FwwChatCell *cell = nil;
    EMMessage *message = self.dataSources[indexPath.row];
    
        if ( [message.from isEqualToString:self.tofriend] ) {
        cell = [tableView dequeueReusableCellWithIdentifier:ReceverCell];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:SenderCell];
    }

    cell.message = self.dataSources[indexPath.row];
    return cell;
}


#pragma mark - TextView
- (void)textViewDidChange:(UITextView *)textView {
    //NSLog(@"%@",NSStringFromCGSize(textView.contentSize) );
    CGFloat textViewH = 0;
    CGFloat minHeight = 41;
    CGFloat maxHeight = 68;
    
    CGFloat contentHeight = textView.contentSize.height;
    if (contentHeight < minHeight) {
        textViewH = minHeight;
    } else if (contentHeight > maxHeight) {
        textViewH = maxHeight;
    } else {
        textViewH = contentHeight;
    }
    
    if ( [textView.text hasSuffix:@"\n"] ) {
        [self sendMessage:textView.text];
        textView.text  = nil;
        textViewH = minHeight;
    }
    self.inputToolBarHegightConstraint.constant = textViewH - 40;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)sendMessage: (NSString *)message {
    message = [message substringToIndex:message.length - 1];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:message];
    NSString *from = [ [EMClient sharedClient] currentUsername];
    EMMessage *selfmessage = [ [EMMessage alloc] initWithConversationID:self.tofriend from:from to:self.tofriend body:body ext:nil];
    selfmessage.chatType = EMChatTypeChat;
    [ [EMClient sharedClient].chatManager sendMessage:selfmessage progress:nil completion:^(EMMessage *message, EMError *error) {
        [self addDataSourcesWithMessage:message];
        [self.tableView reloadData];
        [self scrollToBottom];
    }];
}

- (void)scrollToBottom {
    if (self.dataSources.count == 0) {
        return ;
    }
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.dataSources.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}


#pragma mark - 获取聊天数据
- (void)loadLocalChatRecords {
   // [self.dataSources addObject:@"16:06"];
    //NSLog(@"time:%@",self.data);
    EMConversation *conversiation = [ [EMClient sharedClient].chatManager getConversation:self.tofriend type:EMConversationTypeChat createIfNotExist:YES];
    EMMessage *messagew = [conversiation loadMessageWithId:conversiation.latestMessage.messageId error:nil];
    if (messagew) {
        [self addDataSourcesWithMessage:messagew];
    }
}

- (void)messagesDidReceive:(NSArray *)aMessages {
    NSArray *receive = aMessages;
    for (EMMessage *obj in receive) {
            if ( [obj.from isEqualToString:self.tofriend] ) {
                [self addDataSourcesWithMessage:obj];
                [self.tableView reloadData];
        }
    }
}

#pragma mark - 添加数据源
- (void)addDataSourcesWithMessage:(EMMessage *)msg {
//    long long times = ([ [NSDate date] timeIntervalSince1970] -60 * 60 *24 *2 )
//    *1000.0;


    
    NSString *timeStr = [FwwTimeTool timeStr:msg.localTime];
    
    if (! [self.currentstri isEqualToString:timeStr] ) {
        [self.dataSources addObject:timeStr];
        self.currentstri = timeStr;
        [self.tableView reloadData];
    }
    [self.dataSources addObject:msg];
}


@end
