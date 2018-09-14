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
// 裁剪中心点周围最大的正方形区域的图片
- (UIImage *)zjs_cropCenterMaxSquareArea;
// 用颜色创建一张纯色图片
+ (UIImage *)zjs_imageWithColor:(UIColor *)color size:(CGSize)size;
// 用颜色创建一张渐变色图片
+ (UIImage *)zjs_gradientImageWithColors:(NSArray<UIColor *> *)colors direction:(ZJSGradientDirection)direction size:(CGSize)size;

@end
