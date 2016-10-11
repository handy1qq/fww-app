//
//  FwwTimeTool.m
//  fww聊天app
//
//  Created by fengwenwei on 16/10/5.
//  Copyright © 2016年 fengwenwei. All rights reserved.
//

#import "FwwTimeTool.h"

@implementation FwwTimeTool

+ (NSString *)timeStr:(long long)timeInterval {
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //1.获取当前的时间
    NSDate *currentDate = [NSDate date];
    NSDateComponents *componnents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentYear = componnents.year;
    NSInteger currentmonth = componnents.month;
    NSInteger currentDay = componnents.day;
    
    
    NSLog(@"CurrentYear:%ld",componnents.year);
    NSLog(@"Currentmonth:%ld",componnents.month);
    NSLog(@"Currentday:%ld",componnents.day);
    
    //2.获取发送时间
    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:timeInterval / 1000.0];
    componnents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:msgDate];
    CGFloat msgYear = componnents.year;
    CGFloat msgMonth = componnents.month;
    CGFloat msgDay = componnents.day;
    
    NSLog(@"msgDateYear:%ld",componnents.year);
    NSLog(@"msgDatemonth:%ld",componnents.month);
    NSLog(@"msgDateday:%ld",componnents.day);
    
    /**时间格式化 */
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    if (currentYear == msgYear
        && currentmonth == msgMonth
        && currentDay == msgDay) {//今天
        dateFmt.dateFormat = @"HH:mm";
    } else if (currentYear == msgYear
               && currentmonth == msgMonth
               && currentDay - 1 == msgDay) {//昨天
        dateFmt.dateFormat = @"昨天 HH:mm";
    } else {
        dateFmt.dateFormat = @"yy-MM-dd HH:mm";
    }

    

        return [dateFmt stringFromDate:msgDate];
}

@end
