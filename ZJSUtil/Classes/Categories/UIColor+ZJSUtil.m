//
//  UIColor+ZJSUtil.m
//  Pods-ZJSUtil_Example
//
//  Created by 查俊松 on 2018/9/14.
//

#import "UIColor+ZJSUtil.h"

@implementation UIColor (ZJSUtil)

#pragma mark - Hex颜色
+ (instancetype)zjs_colorWithHexString:(NSString *)hexString
{
    return [self zjs_colorWithHexString:hexString alpha:1.f];
}

+ (instancetype)zjs_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    unsigned int rgbValue = 0;
    NSString *hexStringValue = [hexString stringByReplacingOccurrencesOfString:kZJS_Symbol_JH withString:kZJS_NoneString];
    NSScanner *scanner = [NSScanner scannerWithString:hexStringValue];
    [scanner scanHexInt:&rgbValue];
    return [self zjs_colorWithR:((rgbValue & 0xFF0000) >> 16) g:((rgbValue & 0xFF00) >> 8) b:(rgbValue & 0xFF) a:alpha];
}

#pragma mark - RGB颜色
+ (instancetype)zjs_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b
{
    return [self zjs_colorWithR:r g:g b:b a:1.f];
}

+ (instancetype)zjs_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a
{
    return [self colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a];
}

#pragma mark - 随机颜色
+ (instancetype)zjs_randomColor
{
    return [self colorWithRed:arc4random_uniform(256)/255.f green:arc4random_uniform(256)/255.f blue:arc4random_uniform(256)/255.f alpha:1.f];
}

@end
