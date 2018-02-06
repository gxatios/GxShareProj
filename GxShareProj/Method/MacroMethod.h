//
//  MacroMethod.h
//  资和信
//
//  Created by gaoxin on 16/11/1.
//  Copyright © 2016年 Risenb App Department With iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define requestFailTest @"您的网络不太给力"


//static inline UIEdgeInsets sgm_safeAreaInset(UIView *view) {
//    if (IOS_11) {
//        return view.safeAreaInsets;
//    }
//    return UIEdgeInsetsZero;
//}

@interface MacroMethod : NSObject
+(NSString*)urlBase; // url地址
+(void)hudShowAnimateForWindow;
+(void)hudHideAnimateForWindow;
+(void)showHudText:(NSString*)str inView:(UIView *)view;
+(void)showHudinView:(UIView *)view;
+(void)hideHudinView:(UIView *)view;
+(void)showFailHudinView:(UIView *)view;
+(void)showHudIndeter:(NSString*)str inView:(UIView *)view;
+(void)showHudTextinWindow:(NSString *)str;
+(void)showFailHudinWindow;
+ (BOOL)validateUserName:(NSString *)name; //  用户名
+ (BOOL)validatePhoneNum:(NSString *)name; //  11位数字手机号
+ (BOOL)validateBarCode:(NSString *)code; // 条形码 数字字母

+(UIColor *)colorFromHexCode:(NSString *)hexString;

+ (UIBarButtonItem *)barButtonItemTarget:(id)target action:(SEL)action;


+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (UIImage*) createImageWithColor: (UIColor*) color;
+ (UIImage *) createImageWithColor:(UIColor *) color andRect:(CGRect)rect andCornerRadius:(float)radius;
+ (NSString *)encrypt3DES:(NSString *)src key:(NSString *)key;

+(NSString *)dateToString:(NSDate*)date;
+(NSString *)dateToMinuteString:(NSDate*)date;

+(NSDate *)strToDate:(NSString*)dateStr;
+ (NSDate *)tomorrowDay:(NSDate *)aDate after:(NSInteger)num;

+ (NSString *)arrayToJSONString:(NSArray *)array;
+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary;
+(void)callPhoneMethod:(NSString*)phoneNum;
@end
