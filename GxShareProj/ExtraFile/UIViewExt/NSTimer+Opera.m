//
//  NSTimer+Opera.m
//  AVDemo
//
//  Created by iOS-iMac on 2018/3/13.
//  Copyright © 2018年 iOS-iMac. All rights reserved.
//

#import "NSTimer+Opera.h"

@implementation NSTimer (Opera)

- (void)pauseTimer {
    
    //如果已被释放则return！isValid对应invalidate
    if (![self isValid]) return;
    //启动时间为很久以后
    [self setFireDate:[NSDate distantFuture]];
}

- (void)continueTimer {
    
    if (![self isValid]) return;
    //启动时间为现在
    [self setFireDate:[NSDate date]];
}

@end
