//
//  NSDateTool.m
//  YHB_Prj
//
//  Created by  striveliu on 15/8/20.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import "NSDateTool.h"

@implementation NSDateTool
+ (NSString *)dateToNSString:(NSDate *)aDate formate:(NSString *)aFormat
{
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = aFormat; // 设置时间和日期的格式
    NSString *time = [selectDateFormatter stringFromDate:aDate];
    MLOG(@"teime=====%@",time);
    return time;
}

+ (NSDate *)getAfterDelayDate:(NSTimeInterval)aTimeinerval
{
    NSDate *currentDate = [NSDate date];
    NSDate *lasterDate = [NSDate dateWithTimeInterval:aTimeinerval sinceDate:currentDate];
    return lasterDate;
}

+ (void)getCurrentData:(int *)aHour min:(int*)aMIn weak:(int*)aWeak day:(int*)aDay
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |      NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    //int month = [comps month];
    *aDay = [comps day];
    *aHour = [comps hour];
    *aMIn = [comps minute];
    *aWeak = [comps weekday];
}

+ (int)getWeek
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |      NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];

    return [comps weekday];
}

+ (int)getMonthDay
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |      NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    
    return [comps day];
}
@end
