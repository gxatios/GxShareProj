//
//  NSDictionary+Rigorous.m
//  AChat
//
//  Created by risenb—IOS3 on 14-3-27.
//  Copyright (c) 2014年 huangtie. All rights reserved.
//

#import "NSDictionary+Rigorous.h"

@implementation NSDictionary (Rigorous)

- (void)setNotValue:(id)value NotKey:(NSString *)key
{
    if (value || key)
    {
        [self setValue:value forKey:key];
    }
}


@end
