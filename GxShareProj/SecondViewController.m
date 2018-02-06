//
//  SecondViewController.m
//  GxShareProj
//
//  Created by pro2013 on 2018/2/5.
//  Copyright © 2018年 Gx. All rights reserved.
//

#import "SecondViewController.h"
#import "DirectoryWatcher.h"

@interface SecondViewController ()


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [MacroMethod barButtonItemTarget:self action:@selector(upBtnDown)];
    [[DirectoryWatcher defaultWatcher] startMonitoringDocumentAsynchronous];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fileChanageAction:) name:ZFileChangedNotification object:nil];
}
-(void)upBtnDown{
    
}


- (void)dealloc
{
    // 取消监听Document目录的文件改动
    [[DirectoryWatcher defaultWatcher] stopMonitoringDocument];
    [[NSNotificationCenter defaultCenter] removeObserver:ZFileChangedNotification];
}

- (void)fileChanageAction:(NSNotification *)notification
{
    // ZFileChangedNotification 通知是在子线程中发出的, 因此通知关联的方法会在子线程中执行
    NSLog(@"文件发生了改变, %@", [NSThread currentThread]);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSError *error;
    // 获取指定路径对应文件夹下的所有文件
    NSArray <NSString *> *fileArray = [fileManager contentsOfDirectoryAtPath:filePath error:&error];
    NSLog(@"%@", fileArray);
}
@end
