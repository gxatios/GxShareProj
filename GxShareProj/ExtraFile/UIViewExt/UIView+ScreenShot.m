//
//  UIView+ScreenShot.m
//  GXOnlineDemo
//
//  Created by xin gao on 14-2-19.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//

#import "UIView+ScreenShot.h"

@implementation UIView (ScreenShot)



- (UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size); // 开始图形上下文
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];  // 绘制图形到上下文
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();  // 从上下文context 中获取image
    UIGraphicsEndImageContext();  // 结束图形上下文
    return image;
}

@end
