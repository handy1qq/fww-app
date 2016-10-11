//
//  FwwChatCell.h
//  fww聊天app
//
//  Created by fengwenwei on 16/9/28.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMMessage.h"
static NSString *ReceverCell = @"ReceverCell";
static NSString *SenderCell = @"SenderCell";

@interface FwwChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

/**<#注释#> */
@property (strong, nonatomic) EMMessage *message;



- (CGFloat)cellHeight;
@end
