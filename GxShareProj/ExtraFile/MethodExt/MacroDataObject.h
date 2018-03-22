//
//  MacroDataObject.h
//  GxDemoOC
//
//  Created by zhxGx on 2017/8/30.
//  Copyright © 2017年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>
#define FolderName @"DataCaches"
@interface MacroDataObject : NSObject
/**
 *  解归档
 *
 *  @param fileName 文件名
 *
 *  @return 解完归档后的数据
 */
+ (id)loadDataList:(NSString *)fileName;

/**
 *  归档
 *
 *  @param object   归档的数据
 *  @param fileName 文件名
 */
+ (void)saveDataList:(id)object fileName:(NSString *)fileName;

/**
 *  删除归档
 *
 *  @param fileName 文件名
 */
+ (BOOL)removeFile:(NSString *)fileName;
@end
