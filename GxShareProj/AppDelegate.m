//
//  AppDelegate.m
//  GxShareProj
//
//  Created by pro2013 on 2018/2/5.
//  Copyright © 2018年 Gx. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    BOOL isFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLaunch"];
    if (isFirstLaunch == YES) {
    }else{
        [self bundleToDocuments:@"简介.rtf" existsCover:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLaunch"];
    }
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
// 复制nsbundle文件到document
- (void)bundleToDocuments:(NSString *)fileName existsCover:(BOOL)cover
{
    BOOL success;
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//找到 Documents 目录
    NSString *targetPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    if(!cover)
    {
        success = [fileManager fileExistsAtPath:targetPath];
        if (success) return;
    }else{
        [fileManager removeItemAtPath:targetPath error:&error];
    }
    //把 xxx.app 包里的文件拷贝到 targetPath
    NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    //如果文件存在了则不能覆盖，所以前面才要先把它删除掉
    success = [fileManager copyItemAtPath:bundlePath toPath:targetPath error:&error];
    if(!success)
        NSLog(@"'%@' 文件从 app 包里拷贝到 Documents 目录，失败:%@", fileName, error);
    else
        NSLog(@"'%@' 文件从 app 包里已经成功拷贝到了 Documents 目录。", fileName);
}

@end
