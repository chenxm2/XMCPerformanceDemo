//
//  XMCPerformanceUtil.m
//  XMCPerformanceDemo
//
//  Created by xianmingchen on 16/7/12.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import "XMCPerformanceUtil.h"

@implementation XMCPerformanceUtil
+ (void)excuteWithCount:(NSUInteger)count tagName:(const char *)tagName block:(void(^)())excuteBlock
{
    if (!excuteBlock || tagName == NULL)
    {
        return;
    }
    
    NSLog(@"%s beginTest", tagName);
    NSDate *beginDate = [NSDate date];
    for (NSInteger i = 0; i < count; i++)
    {
        excuteBlock();
    }
    
    NSDate *endDate = [NSDate date];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:beginDate];
    NSLog(@"%s endTest", tagName);
    NSLog(@"%s take %f seconds", tagName, timeInterval);
}
@end
