//
//  MacroMethod.m
//  资和信
//
//  Created by gaoxin on 16/11/1.
//  Copyright © 2016年 Risenb App Department With iOS. All rights reserved.
//

#import "MacroMethod.h"
#import <CommonCrypto/CommonDigest.h>
#import <MJExtension/MJExtension.h>

@implementation MacroMethod



+(void)hudShowAnimateForWindow{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:hud];
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud showAnimated:YES];
//    [hud hideAnimated:YES afterDelay:8];
    
//    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}
+(void)hudHideAnimateForWindow{
//    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    });
}

+(void)showHudTextinWindow:(NSString *)str{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MacroMethod showHudText:str inView:[UIApplication sharedApplication].keyWindow];
    });
}

+(void)showFailHudinWindow{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MacroMethod showFailHudinView:[UIApplication sharedApplication].keyWindow];
    });
}
+(void)showHudIndeter:(NSString*)str inView:(UIView *)view{
    if (view) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.detailsLabel.text = str;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
        //        MBProgressHUD *showHud = [[MBProgressHUD alloc] initWithView:view];
        //        [view addSubview:showHud];
        //        showHud.detailsLabel.text = str;
        //        showHud.mode = MBProgressHUDModeIndeterminate;
        //        [showHud showAnimated:YES whileExecutingBlock:^{
        //            sleep(1.5);
        //        } completionBlock:^{
        //            [showHud removeFromSuperview];
        //        }];
    }
}


+(void)showHudText:(NSString*)str inView:(UIView *)view{
     [MBProgressHUD hideHUDForView:view animated:YES];
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:hud];
        [view bringSubviewToFront:hud];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = str;
    hud.bezelView.backgroundColor = RGBCOLOR(1, 1, 1, 0.2);
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];

        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:1.5];
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            // Do something...
//            [MBProgressHUD hideHUDForView:view animated:YES];
//        });
//        MBProgressHUD *showHud = [[MBProgressHUD alloc] initWithView:view];
//        [view addSubview:showHud];
//        showHud.detailsLabel.text = str;
//        showHud.mode = MBProgressHUDModeIndeterminate;
//        [showHud showAnimated:YES whileExecutingBlock:^{
//            sleep(1.5);
//        } completionBlock:^{
//            [showHud removeFromSuperview];
//        }];
}

+(void)showHudinView:(UIView *)view{
    if (view) {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
}
+(void)hideHudinView:(UIView *)view{

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
    
//    for (UIView *hud in [UIApplication sharedApplication].keyWindow.subviews) {
//        if ([hud isKindOfClass:[MBProgressHUD class]]) {
//            [hud removeFromSuperview];
//        }
//    }
}
+(void)showFailHudinView:(UIView *)view{
        [MBProgressHUD hideHUDForView:view animated:YES];
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:hud];
    hud.bezelView.backgroundColor = RGBCOLOR(1, 1, 1, 0.2);
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
        hud.mode = MBProgressHUDModeCustomView;
        hud.detailsLabel.text = requestFailTest;
        [hud showAnimated:YES];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
}

//sha256
+ (NSString*)noLoginSha256:(NSString*)canshu
{
    NSString *strKey;
    
//    NSString *str1 = [HTSaveCachesFile loadDataList:@"s1"];
//    NSString *str2 = [HTSaveCachesFile loadDataList:@"s2"];
    NSString *str1 =  [[NSUserDefaults standardUserDefaults] valueForKey:@"s1"];
    NSString *str2 =  [[NSUserDefaults standardUserDefaults] valueForKey:@"s2"];
//     [[NSUserDefaults standardUserDefaults] valueForKey:"url"];
    NSLog(@"str1:%@,str2:%@",str1,str2);
    
//    if (!strKey.length)
//    {
//        strKey =   [self pinxCreator:str1 withPinv:str2];
//    }
    strKey =   [self pinxCreator:str1 withPinv:str2];
    NSLog(@"strKey:%@",strKey);
    NSString *str = [NSString stringWithFormat:@"%@%@", canshu,strKey];
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    int dataLength = (int)data.length;
    CC_SHA256(data.bytes, dataLength, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
+ (NSString *)pinxCreator:(NSString *)pan withPinv:(NSString *)pinv
{
    if (pan.length != pinv.length)
    {
        return nil;
    }
    const char *panchar = [pan UTF8String];
    const char *pinvchar = [pinv UTF8String];
    NSString *temp = [[NSString alloc] init];
    for (int i = 0; i < pan.length; i++)
    {
        char one = panchar[i];
        char two = pinvchar[i];
        int panValue = [self charToint:one];
        int pinvValue = [self charToint:two];
        temp = [temp stringByAppendingString:[NSString stringWithFormat:@"%X",panValue^pinvValue]];
    }
    return temp;
}
+ (int)charToint:(char)tempChar
{
    if (tempChar >= '0' && tempChar <='9')
    {
        return tempChar - '0';
    }
    else if (tempChar >= 'A' && tempChar <= 'F')
    {
        return tempChar -'A' + 10;
    }
    return 0;
}



+ (BOOL)validateUserName:(NSString *)name // 中英文 数字 下划线 ^[\u4e00-\u9fa5_a-zA-Z0-9]+$
{
//    NSString *userNameRegex = @"^[\u4E00-\u9FA5a-zA-Z0-9]{2,16}";
    NSString *userNameRegex = @"^[\u4E00-\u9FA5a-zA-Z0-9]+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
+ (BOOL)validatePhoneNum:(NSString *)name{//  11位手机号
    NSString *userNameRegex = @"^[0-9]{11}";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
+ (BOOL)validateBarCode:(NSString *)code // 英文 数字^[a-zA-Z0-9]+$
{
    //    NSString *userNameRegex = @"^[\u4E00-\u9FA5a-zA-Z0-9]{2,16}";
    NSString *userNameRegex = @"^[a-zA-Z0-9]{16}";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:code];
    return B;
}


+(NSString *)key:(NSDictionary*)dic
{ //   排序：key用字母 顺序，value转成jsonString，进行参数拼接，
    NSMutableArray *dicArr = [dic allKeys].mutableCopy;
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *resultArray = [dicArr sortedArrayUsingDescriptors:descriptors].mutableCopy;
    
    dicArr = resultArray.mutableCopy;
    
    for (int i = 0; i< dicArr.count-1; i++)
    {
        for (int j = 0; j < dicArr.count - i - 1; j++)
        {
            NSString* str11 = dicArr[j];
            NSString* str22 = dicArr[j+1];
            if (str11.length > str22.length)
            {
                [dicArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSMutableString *shaStr = [[NSMutableString alloc] init];
    for (int i = 0; i < dicArr.count; i++)
    {
        //取出value值
        NSString *value = [dic objectForKey:dicArr[i]];
        //处理返回为空的value
        if ([value isKindOfClass:[NSNull class]]) {
           value = @"null";
        }
        NSString *valuestr = [value mj_JSONString];
//        NSString *valueStr = [valuestr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        [shaStr appendString:dicArr[i]];
        [shaStr appendString:@"="];
        [shaStr appendString:valuestr];
        if (i < dicArr.count - 1)
        {
            [shaStr appendString:@"&"];
        }
        
    }
    return shaStr;
}

+(UIColor *)colorFromHexCode:(NSString *)hexString{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIBarButtonItem *)barButtonItemTarget:(id)target action:(SEL)action{
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 45)];
    //    itemView.backgroundColor = [UIColor purpleColor];
    UILabel *showLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 50, 21)];
    showLable.text = @"添加";
    showLable.font = [UIFont systemFontOfSize:14.0f];
    [itemView addSubview:showLable];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 45);
//    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [itemView addSubview:backBtn];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemView];
    itemView.userInteractionEnabled = YES;
    UITapGestureRecognizer *itemTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [itemView addGestureRecognizer:itemTap];
    [itemView setExclusiveTouch:YES];
    [backBtn setExclusiveTouch:YES];
    return temporaryBarButtonItem;
}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    //if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    //if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //NSLog(@"%f:::%f:::%f",((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f));
    
    //    return SF_COLOR(((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f), 1);
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1];
}
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (UIImage *) createImageWithColor:(UIColor *) color andRect:(CGRect)rect andCornerRadius:(float)radius
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

+(NSString *)dateToString:(NSDate*)date{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    //    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//指定转date得日期格式化形式
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    //    dateFormatter.dateFormat=@"yyyy-MM-dd eeee aa HH:mm:ss";
    //      dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss z";
    
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}

+(NSString *)dateToMinuteString:(NSDate*)date{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    //    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//指定转date得日期格式化形式
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm";
    //    dateFormatter.dateFormat=@"yyyy-MM-dd eeee aa HH:mm:ss";
    //      dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss z";
    
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}
+(NSDate *)strToDate:(NSString*)dateStr{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}
//传入今天的时间，返回明天的时间
+ (NSDate *)tomorrowDay:(NSDate *)aDate after:(NSInteger)num{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+num)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    return beginningOfWeek;
}
+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonString;
}


+ (NSString *)arrayToJSONString:(NSArray *)array
{
    NSError *error = nil;
    //    NSMutableArray *muArray = [NSMutableArray array];
    //    for (NSString *userId in array) {
    //        [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
    //    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *result = [jsonResult stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    //    NSLog(@"json array is: %@", jsonResult);
    return result;
}

+(void)callPhoneMethod:(NSString*)phoneNum{
    NSString *mobile = [NSString stringWithFormat:@"tel:%@",phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobile]];
}
@end
