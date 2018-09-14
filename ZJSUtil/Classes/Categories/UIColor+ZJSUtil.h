//
//  UIColor+ZJSUtil.h
//  Pods-ZJSUtil_Example
//
//  Created by 查俊松 on 2018/9/14.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZJSUtil)

// Hex颜色
+ (instancetype)zjs_colorWithHexString:(NSString *)hexString;
+ (instancetype)zjs_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
// RGB颜色
+ (instancetype)zjs_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;
+ (instancetype)zjs_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;
// 随机颜色
+ (instancetype)zjs_randomColor;

@end
