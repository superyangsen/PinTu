//
//  Helper.m
//  PinTu
//
//  Created by 协力达 on 15/10/12.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+(CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}

+(CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height;
}

#pragma  mark - 获取当天的日期：年月日
+ (NSDictionary *)getTodayDate
{
    
    //获取今天的日期
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *year = [NSString stringWithFormat:@"%ld", [components year]];
    NSString *month = [NSString stringWithFormat:@"%02ld", [components month]];
    NSString *day = [NSString stringWithFormat:@"%02ld", [components day]];
    
    NSMutableDictionary *todayDic = [[NSMutableDictionary alloc] init];
    [todayDic setObject:year forKey:@"year"];
    [todayDic setObject:month forKey:@"month"];
    [todayDic setObject:day forKey:@"day"];
    
    return todayDic;
}

+ (void)setCornerBorderWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)radius object:(UIView *)object
{
    object.layer.borderWidth = width;
    object.layer.borderColor = color.CGColor;
    object.layer.cornerRadius = radius;
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    UIColor *color = [UIColor colorWithRed:red / 256.0f green:green / 256.0f blue:blue / 256.0f alpha:alpha];
    
    return color;
}

+ (BOOL)checkTelPhone:(NSString *)string
{
    
    
    if ([string length] == 0) {
        
        //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"data_null_prompt", nil) message:NSLocalizedString(@"tel_no_null", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        
        return NO;
        
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:string];
    
    if (!isMatch) {
        
        //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        //
        return NO;
    }
    
    return YES;
}

+ (void)alertTitle:(NSString *)title Message:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alertView show];
}

+ (NSString *)getDateTimeString:(NSString *)timeString format:(NSString *)format
{
    //计算时间
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[timeString floatValue] / 1000];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    components = [calendar components:unitFlags fromDate:date];
    
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    //    NSInteger hour = [components hour];
    //    NSInteger minute = [components minute];
    //    NSInteger second = [components second];
    //
    //    components = [calendar components:unitFlags fromDate:[NSDate date]];
    //
    //    NSInteger yearNow = [components year];
    //    NSInteger monthNow = [components month];
    //    NSInteger dayNow = [components day];
    
    NSString *formatTime =  [NSString stringWithFormat:@"%d%@%d%@%d",year,format, month, format, day];
    
    return formatTime;
}

+ (NSString *)getDateString:(NSDate *)date format:(NSString *)format
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    components = [calendar components:unitFlags fromDate:date];
    
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    //    NSInteger hour = [components hour];
    //    NSInteger minute = [components minute];
    //    NSInteger second = [components second];
    //
    //    components = [calendar components:unitFlags fromDate:[NSDate date]];
    //
    //    NSInteger yearNow = [components year];
    //    NSInteger monthNow = [components month];
    //    NSInteger dayNow = [components day];
    
    NSString *formatTime =  [NSString stringWithFormat:@"%d%@%d%@%d",year,format, month, format, day];
    
    return formatTime;
}

- (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    CGSize imgSize = [self CWSizeReduceSize:image.size limit:length];
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, scale);  // 创建一个 bitmap context
    
    [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
            blendMode:kCGBlendModeNormal alpha:1.0];              // 将图片绘制到当前的 context 上
    
    img = UIGraphicsGetImageFromCurrentImageContext();            // 从当前 context 中获取刚绘制的图片
    UIGraphicsEndImageContext();
    
    return img;
}
//static inlineCGSize CWSizeReduce(CGSize size, CGFloat limit)   // 按比例减少尺寸
- (CGSize)CWSizeReduceSize:(CGSize)size limit:(CGFloat)limit
{
    CGFloat max = MAX(size.width, size.height);
    if (max < limit)
    {
        return size;
    }
    
    CGSize imgSize;
    CGFloat ratio = size.height / size.width;
    
    if (size.width > size.height)
    {
        imgSize = CGSizeMake(limit, limit*ratio);
    }
    else
    {
        imgSize = CGSizeMake(limit/ratio, limit);
    }
    
    return imgSize;
}

+ (id)sharedInstance
{
    static Helper *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[Helper alloc] init];
    });
    
    return share;
}

@end
