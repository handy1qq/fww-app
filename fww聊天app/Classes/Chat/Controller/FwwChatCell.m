//
//  FwwChatCell.m
//  fww聊天app
//
//  Created by fengwenwei on 16/9/28.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import "FwwChatCell.h"
#import "EMTextMessageBody.h"

@implementation FwwChatCell

- (void)setMessage:(EMMessage *)message {
    _message = message;
    id body = message.body;
    if ( [body isKindOfClass:[EMTextMessageBody class] ] ) {
        EMTextMessageBody *textBody = body;
        self.messageLabel.text = textBody.text;
    } else  {
        self.messageLabel.text = @"未知消息";
    }
}


- (CGFloat)cellHeight {
  //  [self layoutIfNeeded];
    CGRect frame = [self frame];
     self.messageLabel.numberOfLines = 10;
    CGSize size = CGSizeMake(300, 1000);
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize labelSize = [self.messageLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
                        
    self.messageLabel.frame = CGRectMake(self.messageLabel.frame.origin.x, self.messageLabel.frame.origin.y, labelSize.width, labelSize.height);
    frame.size.height = labelSize.height+85;
    self.frame = frame;

   // NSLog(@"!!!!!!!!!!!!%f",self.messageLabel.bounds.size.height);
    return (frame.size.height);
//    return (19 + rect.size.height + 10);

}

@end
