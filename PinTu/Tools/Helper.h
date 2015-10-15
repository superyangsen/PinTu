//
//  Helper.h
//  PinTu
//
//  Created by 协力达 on 15/10/12.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (NSDictionary *)getTodayDate;

//获取字符串文字的长度
+ (CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height;

//获取字符串文字的高度
+ (CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;

//
+ (void)setCornerBorderWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)radius object:(id)object;

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (BOOL)checkTelPhone:(NSString *)string;

+ (void)alertTitle:(NSString *)title Message:(NSString *)message;

//获得时间字符串
+ (NSString *)getDateTimeString:(NSString *) timeString format:(NSString *)format;

+ (NSString *)getDateString:(NSDate *)date format:(NSString *)format;

- (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image;

+ (id)sharedInstance;

@end
