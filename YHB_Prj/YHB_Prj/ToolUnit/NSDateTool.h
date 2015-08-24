//
//  NSDateTool.h
//  YHB_Prj
//
//  Created by  striveliu on 15/8/20.
//  Copyright (c) 2015年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateTool : NSObject
/**
 *  NSDate to NSString
 *
 *  @param aDate
 *  @param aFormat
 *
 *  @return yyyy-MM-dd HH:mm 
 */
+ (NSString *)dateToNSString:(NSDate *)aDate formate:(NSString *)aFormat;

/**
 *  根据当前时间获取下一个时间
 *
 *  @param aTimeinerval <#aTimeinerval description#>
 *
 *  @return <#return value description#>
 */
+ (NSDate *)getAfterDelayDate:(NSTimeInterval)aTimeinerval;

+ (void)getCurrentData:(int *)aHour min:(int*)aMIn weak:(int*)aWeak day:(int*)aDay;

+ (int)getWeek;

+ (int)getMonthDay;
@end
