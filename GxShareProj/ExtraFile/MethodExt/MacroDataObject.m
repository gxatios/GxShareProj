//
//  MacroDataObject.m
//  GxDemoOC
//
//  Created by zhxGx on 2017/8/30.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "MacroDataObject.h"

@implementation MacroDataObject
+ (id)loadDataList:(NSString *)fileName
{
    //  NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:CacheName];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:FolderName];
    NSFileManager *manager = [[NSFileManager alloc]init];
    if (![manager fileExistsAtPath:path])
    {
        NSError *error ;
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error)
        {
        }
    }
    
    NSString* fileDirectory = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.arc",fileName]];
    
    //解归档
    return [NSKeyedUnarchiver unarchiveObjectWithFile:fileDirectory];
}

+ (void)saveDataList:(id)object fileName:(NSString *)fileName
{
    //归档对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:FolderName];
    NSFileManager *manager = [[NSFileManager alloc]init];
    if (![manager fileExistsAtPath:path])
    {
        NSError *error ;
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error)
        {
            
        }
    }
    
    NSString* fileDirectory = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.arc",fileName]];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:object toFile:fileDirectory];
    
    if (success)
    {
        
    }else{
        NSLog(@"归档失败");
    }
    
}

+ (BOOL)removeFile:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:FolderName];
    NSFileManager *manager = [[NSFileManager alloc]init];
    if (![manager fileExistsAtPath:path])
    {
        return YES;
    }
    
    NSString* fileDirectory = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.arc",fileName]];
    
    BOOL success = [manager removeItemAtPath:fileDirectory error:nil];
    
    if (success)
    {
        NSLog(@"归档删除成功");
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
