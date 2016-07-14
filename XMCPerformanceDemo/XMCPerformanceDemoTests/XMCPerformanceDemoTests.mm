//
//  XMCPerformanceDemoTests.m
//  XMCPerformanceDemoTests
//
//  Created by xianmingchen on 16/7/12.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XMCPerformanceUtil.h"
#import <objc/message.h>
#import <CoreFoundation/CoreFoundation.h>

@interface XMCPerformanceDemoTests : XCTestCase
@property (nonatomic, strong) NSString *name;
@end

@implementation XMCPerformanceDemoTests
@synthesize name = _name;
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

#pragma mark - testSetValue
#define kName @"name"
const NSUInteger kSetValueCount = 100000000;
- (void)testSetValueWithProperty
{
    // Put the code you want to measure the time of here.
    [XMCPerformanceUtil excuteWithCount:kSetValueCount tagName:__func__ block:^{
        self.name = nil;
        self.name = kName;
    }];
}

- (void)testSetValueWithIvar
{
    [XMCPerformanceUtil excuteWithCount:kSetValueCount tagName:__func__ block:^{
        _name = nil;
        _name = kName;
    }];
}

- (void)testSetValueWithKVC
{
    [XMCPerformanceUtil excuteWithCount:kSetValueCount tagName:__func__ block:^{
        [self setValue:nil forKey:kName];
        [self setValue:kName forKey:kName];
    }];
}

- (void)testSetValueWithMsgSend
{
    [XMCPerformanceUtil excuteWithCount:kSetValueCount tagName:__func__ block:^{
        ((void (*) (id, SEL, id))   )(self, @selector(setName:), nil);
        ((void (*) (id, SEL, id))objc_msgSend)(self, @selector(setName:), kName);
    }];
}


#pragma mark - testStringCombine
#define kCombineStringOne @"CombineStringOne"
#define kCombineStringTwo @"kCombineStringTwo"
#define kCombiedStringLeng [kCombineStringOne length] + [kCombineStringOne length]
const NSUInteger kStringCombineCount = 1000000;
- (void)testStringCombineWithFormat
{
    [XMCPerformanceUtil excuteWithCount:kStringCombineCount tagName:__func__ block:^{
        NSString *string = [NSString stringWithFormat:@"%@%@", kCombineStringOne, kCombineStringTwo];
    }];
}

- (void)testStringCombineWithAppend
{
    NSUInteger length = kCombiedStringLeng;
    [XMCPerformanceUtil excuteWithCount:kStringCombineCount tagName:__func__ block:^{
        NSMutableString *string = [NSMutableString stringWithCapacity:kCombiedStringLeng];
        [string appendString:kCombineStringOne];
        [string appendString:kCombineStringTwo];
    }];
}

- (void)testStringCombineWithCFMethod
{
    NSUInteger length = kCombiedStringLeng;
    [XMCPerformanceUtil excuteWithCount:kStringCombineCount tagName:__func__ block:^{
        CFMutableStringRef cfString = CFStringCreateMutable(NULL, length);
        CFStringAppend(cfString, (__bridge CFStringRef)kCombineStringOne);
        CFStringAppend(cfString, (__bridge CFStringRef)kCombineStringTwo);
    }];
}

- (void)testStringCombineWithSprintf
{
    NSUInteger length = kCombiedStringLeng;
    [XMCPerformanceUtil excuteWithCount:kStringCombineCount tagName:__func__ block:^{
        char *buf = new char[length + 1];
        sprintf(buf, "%s%s", kCombineStringOne.UTF8String, kCombineStringTwo.UTF8String);
    }];

}
@end
