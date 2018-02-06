//
//  DirectoryWatcher.m
//  GxShareProj
//
//  Created by pro2013 on 2018/2/6.
//  Copyright © 2018年 Gx. All rights reserved.
//

#import "DirectoryWatcher.h"

@implementation DirectoryWatcher

static DirectoryWatcher *_instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)defaultWatcher
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (void)startMonitoringDocumentAsynchronous
{
    // 获取沙盒的Document目录
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    [self startMonitoringDirectory:docuPath];
}

// 监听指定目录的文件改动
- (void)startMonitoringDirectory:(NSString *)directoryPath
{
    // 创建 file descriptor (需要将NSString转换成C语言的字符串)
    // open() 函数会建立 file 与 file descriptor 之间的连接
    int filedes = open([directoryPath cStringUsingEncoding:NSASCIIStringEncoding], O_EVTONLY);
    
    // 创建 dispatch queue, 当文件改变事件发生时会发送到该 queue
    _zDispatchQueue = dispatch_queue_create("ZFileMonitorQueue", 0);
    
    // 创建 GCD source. 将用于监听 file descriptor 来判断是否有文件写入操作
    _zSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, filedes, DISPATCH_VNODE_WRITE, _zDispatchQueue);
    
    // 当文件发生改变时会调用该 block
    dispatch_source_set_event_handler(_zSource, ^{
        // 在文件发生改变时发出通知
        // 在子线程发送通知, 这个通知触发的方法会在子线程当中执行
        [[NSNotificationCenter defaultCenter] postNotificationName:ZFileChangedNotification object:nil userInfo:nil];
    });
    
    // 当文件监听停止时会调用该 block
    dispatch_source_set_cancel_handler(_zSource, ^{
        // 关闭文件监听时, 关闭该 file descriptor
        close(filedes);
    });
    
    // 开始监听文件
    dispatch_resume(_zSource);
}

// 停止监听指定目录的文件改动
- (void)stopMonitoringDocument
{
    dispatch_cancel(_zSource);
}


@end
