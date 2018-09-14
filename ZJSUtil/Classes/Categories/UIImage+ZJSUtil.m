//
//  UIImage+ZJSUtil.m
//  Pods-ZJSUtil_Example
//
//  Created by 查俊松 on 2018/9/14.
//

#import "UIImage+ZJSUtil.h"

@implementation UIImage (ZJSUtil)

#pragma mark 图片压缩
- (UIImage *)zjs_scaleToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

#pragma mark 生成标准的(@1x,@2x,@3x)图
- (UIImage *)zjs_imageWithTargetWidth:(CGFloat)targetWidth scale:(CGFloat)scale
{
    if (!self.size.width || !self.size.height || !targetWidth || !scale) {
        return self;
    }
    UIImage *scaleImage = [self zjs_scaleToSize:CGSizeMake(targetWidth*scale, targetWidth*scale*self.size.height/self.size.width)];
    UIImage *targetImage = [UIImage imageWithCGImage:scaleImage.CGImage scale:scale orientation:UIImageOrientationUp];
    return targetImage;
}

#pragma mark 根据当前设备生成标准的(@1x,@2x,@3x)图
- (UIImage *)zjs_imageWithTargetWidth:(CGFloat)targetWidth
{
    return [self zjs_imageWithTargetWidth:targetWidth scale:[UIScreen mainScreen].scale];
}

#pragma mark 裁剪中心点周围最大的正方形区域的图片
- (UIImage *)zjs_cropCenterMaxSquareArea
{
    // 安全判断
    if (!self.CGImage) {
        return nil;
    }
    CGSize originalSize = self.size;
    CGFloat targetSizeWAndH = MIN(originalSize.width, originalSize.height);
    // 中心点周围最大的正方形区域
    CGRect targetRect = CGRectMake((originalSize.width-targetSizeWAndH)/2, (originalSize.height-targetSizeWAndH)/2, targetSizeWAndH, targetSizeWAndH);
    // 开始裁剪
    CIImage *originalImage = [CIImage imageWithCGImage:self.CGImage];
    UIImage *targetImage = [UIImage imageWithCIImage:[originalImage imageByCroppingToRect:targetRect]];
    return targetImage;
}

#pragma mark 用颜色创建一张纯色图片
+ (UIImage *)zjs_imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}

#pragma mark 用颜色创建一张渐变色图片
+ (UIImage *)zjs_gradientImageWithColors:(NSArray<UIColor *> *)colors direction:(ZJSGradientDirection)direction size:(CGSize)size
{
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)color.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)cgColors, NULL);
    CGPoint start = CGPointZero;
    CGPoint end = CGPointZero;
    switch (direction) {
        case ZJSGradientDirectionTopToBottom:
            start = CGPointMake(0.f, 0.f);
            end = CGPointMake(0.f, size.height);
            break;
        case ZJSGradientDirectionLeftToRight:
            start = CGPointMake(0.f, 0.f);
            end = CGPointMake(size.width, 0.f);
            break;
        case ZJSGradientDirectionTopLeftToBottomRight:
            start = CGPointMake(0.f, 0.f);
            end = CGPointMake(size.width, size.height);
            break;
        case ZJSGradientDirectionTopRightToBottomLeft:
            start = CGPointMake(size.width, 0.f);
            end = CGPointMake(0.f, size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
