//
//  MethodExt.h
//  AVDemo
//
//  Created by iOS-iMac on 2018/3/9.
//  Copyright © 2018年 iOS-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>

@interface MethodExt : NSObject

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (UIImage*) createImageWithColor: (UIColor*) color;
+ (UIImage *) createImageWithColor:(UIColor *) color andRect:(CGRect)rect andCornerRadius:(float)radius;
+(BOOL)isValitString:(NSString *)testStr;

+ (BOOL)validateUserName:(NSString *)name; //  用户名
+ (BOOL)validatePhoneNum:(NSString *)name; //  11位数字手机号
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString; // 身份证号
+ (BOOL)validateBarCode:(NSString *)code; // 条形码 数字字母


+(NSString *)dateToString:(NSDate*)date;
+(NSString *)dateToMinuteString:(NSDate*)date;

+(NSDate *)strToDate:(NSString*)dateStr;
+ (NSDate *)tomorrowDay:(NSDate *)aDate after:(NSInteger)num;

+ (NSString *)arrayToJSONString:(NSArray *)array;
+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary;
+(void)callPhoneMethod:(NSString*)phoneNum;

+ (NSString *)encrypt3DES:(NSString *)src key:(NSString *)key;
+ (NSString*)getDivceSize;
@end
