//
//  DirectoryWatcher.h
//  GxShareProj
//
//  Created by pro2013 on 2018/2/6.
//  Copyright © 2018年 Gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectoryWatcher : NSObject{
    dispatch_queue_t _zDispatchQueue;
    dispatch_source_t _zSource;
}

+ (instancetype)defaultWatcher;
- (void)startMonitoringDocumentAsynchronous;
- (void)stopMonitoringDocument;
@end
