//
//  UIImage+ZJSUtil.h
//  Pods-ZJSUtil_Example
//
//  Created by 查俊松 on 2018/9/14.
//

#import <UIKit/UIKit.h>

// 图片颜色渐变方向
typedef NS_ENUM(NSUInteger, ZJSGradientDirection) {
    ZJSGradientDirectionTopToBottom,
    ZJSGradientDirectionLeftToRight,
    ZJSGradientDirectionTopLeftToBottomRight,
    ZJSGradientDirectionTopRightToBottomLeft
};

@interface UIImage (ZJSUtil)

// 图片压缩
- (UIImage *)zjs_scaleToSize:(CGSize)newSize;
// 生成标准的(@1x,@2x,@3x)图
- (UIImage *)zjs_imageWithTargetWidth:(CGFloat)targetWidth scale:(CGFloat)scale;
// 根据当前设备生成标准的(@1x,@2x,@3x)图
- (UIImage *)zjs_imageWithTargetWidth:(CGFloat)targetWidth;
// 裁剪任意矩形区域的图片
- (UIImage *)zjs_cropInRect:(CGRect)rect;
// 裁剪中心点周围最大的正方形区域的图片
- (UIImage *)zjs_cropCenterMaxSquareArea;
// 给图片添加纯色背景
- (UIImage *)zjs_imageWithBackgroundColor:(UIColor *)color ratio:(CGFloat)ratio size:(CGSize)size;
// 给图片添加带圆角的纯色背景
- (UIImage *)zjs_imageWithBackgroundColor:(UIColor *)color ratio:(CGFloat)ratio size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners;
// 给图片添加渐变色背景
- (UIImage *)zjs_imageWithGradientBackgroundColors:(NSArray<UIColor *> *)colors ratio:(CGFloat)ratio direction:(ZJSGradientDirection)direction size:(CGSize)size;
- (UIImage *)zjs_imageWithGradientBackgroundColors:(NSArray<UIColor *> *)colors ratio:(CGFloat)ratio startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size;
// 给图片添加带圆角的渐变色背景
- (UIImage *)zjs_imageWithGradientBackgroundColors:(NSArray<UIColor *> *)colors ratio:(CGFloat)ratio direction:(ZJSGradientDirection)direction size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners;
- (UIImage *)zjs_imageWithGradientBackgroundColors:(NSArray<UIColor *> *)colors ratio:(CGFloat)ratio startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners;
// 用颜色创建一张纯色图片
+ (UIImage *)zjs_imageWithColor:(UIColor *)color size:(CGSize)size;
// 用颜色创建一张带圆角的纯色图片
+ (UIImage *)zjs_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners;
// 用颜色创建一张渐变色图片
+ (UIImage *)zjs_gradientImageWithColors:(NSArray<UIColor *> *)colors direction:(ZJSGradientDirection)direction size:(CGSize)size;
+ (UIImage *)zjs_gradientImageWithColors:(NSArray<UIColor *> *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size;
// 用颜色创建一张带圆角的渐变色图片
+ (UIImage *)zjs_gradientImageWithColors:(NSArray<UIColor *> *)colors direction:(ZJSGradientDirection)direction size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners;
+ (UIImage *)zjs_gradientImageWithColors:(NSArray<UIColor *> *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners;

@end
