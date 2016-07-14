//
//  XMCPerformanceUtil.h
//  XMCPerformanceDemo
//
//  Created by xianmingchen on 16/7/12.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMCPerformanceUtil : NSObject
+ (void)excuteWithCount:(NSUInteger)count tagName:(const char *)tagName block:(void(^)())excuteBlock;
@end
