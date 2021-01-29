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
    UIGraphicsBeginImageContextWithOptions(newSize, NO, self.scale);
    
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark 生成标准的(@1x,@2x,@3x)图
- (UIImage *)zjs_imageWithTargetWidth:(CGFloat)targetWidth scale:(CGFloat)scale
{
    if (!self.size.width || !self.size.height || !targetWidth || !scale) {
        return self;
    }
    
    CGSize newSize = CGSizeMake(targetWidth, targetWidth*self.size.height/self.size.width);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark 根据当前设备生成标准的(@1x,@2x,@3x)图
- (UIImage *)zjs_imageWithTargetWidth:(CGFloat)targetWidth
{
    return [self zjs_imageWithTargetWidth:targetWidth scale:[UIScreen mainScreen].scale];
}

#pragma mark 裁剪任意矩形区域的图片
- (UIImage *)zjs_cropInRect:(CGRect)rect
{
    CGImageRef newImageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(rect.origin.x*self.scale, rect.origin.y*self.scale, rect.size.width*self.scale, rect.size.height*self.scale));
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(newImageRef);
    return newImage;
}

#pragma mark 裁剪中心点周围最大的正方形区域的图片
- (UIImage *)zjs_cropCenterMaxSquareArea
{
    CGSize originalSize = self.size;
    CGFloat targetSizeWAndH = MIN(originalSize.width, originalSize.height);
    // 中心点周围最大的正方形区域
    CGRect targetRect = CGRectMake((originalSize.width-targetSizeWAndH)/2, (originalSize.height-targetSizeWAndH)/2, targetSizeWAndH, targetSizeWAndH);
    // 开始裁剪
    return [self zjs_cropInRect:targetRect];
}

#pragma mark 给图片添加纯色背景
- (UIImage *)zjs_imageWithBackgroundColor:(UIColor *)color ratio:(CGFloat)ratio size:(CGSize)size
{
    return [self zjs_imageWithBackgroundColor:color ratio:ratio size:size cornerRadius:0 roundingCorners:UIRectCornerAllCorners];
}

#pragma mark 给图片添加带圆角的纯色背景
- (UIImage *)zjs_imageWithBackgroundColor:(UIColor *)color ratio:(CGFloat)ratio size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (cornerRadius) {
        UIBezierPath *cornerBezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:roundingCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        [cornerBezierPath addClip];
    }
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    [self drawInRect:CGRectMake((size.width-self.size.width*ratio)/2.f, (size.height-self.size.height*ratio)/2.f, self.size.width*ratio, self.size.height*ratio)];
    
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRelease(context);
    
    UIGraphicsEndImageContext();
    
    return targetImage;
}

#pragma mark 给图片添加渐变色背景
- (UIImage *)zjs_imageWithGradientBackgroundColors:(NSArray<UIColor *> *)colors ratio:(CGFloat)ratio direction:(ZJSGradientDirection)direction size:(CGSize)size
{
    return [self zjs_imageWithGradientBackgroundColors:colors ratio:ratio direction:direction size:size cornerRadius:0 roundingCorners:UIRectCornerAllCorners];
}

- (UIImage *)zjs_imageWithGradientBackgroundColors:(NSArray<UIColor *> *)colors ratio:(CGFloat)ratio startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size
{
    return [self zjs_imageWithGradientBackgroundColors:colors ratio:ratio startPoint:startPoint endPoint:endPoint size:size cornerRadius:0 roundingCorners:UIRectCornerAllCorners];
}

#pragma mark 给图片添加带圆角的渐变色背景
- (UIImage *)zjs_imageWithGradientBackgroundColors:(NSArray<UIColor *> *)colors ratio:(CGFloat)ratio direction:(ZJSGradientDirection)direction size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners
{
    NSArray<NSValue *> *points = [UIImage zjs_startAndEndPointWithDirection:direction size:size];
    return [self zjs_imageWithGradientBackgroundColors:colors ratio:ratio startPoint:points.firstObject.CGPointValue endPoint:points.lastObject.CGPointValue size:size cornerRadius:cornerRadius roundingCorners:roundingCorners];
}

- (UIImage *)zjs_imageWithGradientBackgroundColors:(NSArray<UIColor *> *)colors ratio:(CGFloat)ratio startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners
{
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)color.CGColor];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    if (cornerRadius) {
        UIBezierPath *cornerBezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:roundingCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        [cornerBezierPath addClip];
    }
    CGColorSpaceRef colorSpace = CGColorGetColorSpace(colors.lastObject.CGColor);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)cgColors, NULL);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    [self drawInRect:CGRectMake((size.width-self.size.width*ratio)/2.f, (size.height-self.size.height*ratio)/2.f, self.size.width*ratio, self.size.height*ratio)];
    
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    UIGraphicsEndImageContext();
    
    return targetImage;
}

#pragma mark 用颜色创建一张纯色图片
+ (UIImage *)zjs_imageWithColor:(UIColor *)color size:(CGSize)size
{
    return [self zjs_imageWithColor:color size:size cornerRadius:0 roundingCorners:UIRectCornerAllCorners];
}

#pragma mark 用颜色创建一张带圆角的纯色图片
+ (UIImage *)zjs_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (cornerRadius) {
        UIBezierPath *cornerBezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:roundingCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        [cornerBezierPath addClip];
    }
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRelease(context);
    
    UIGraphicsEndImageContext();
    
    return targetImage;
}

#pragma mark 用颜色创建一张渐变色图片
+ (UIImage *)zjs_gradientImageWithColors:(NSArray<UIColor *> *)colors direction:(ZJSGradientDirection)direction size:(CGSize)size
{
    return [self zjs_gradientImageWithColors:colors direction:direction size:size cornerRadius:0 roundingCorners:UIRectCornerAllCorners];
}

+ (UIImage *)zjs_gradientImageWithColors:(NSArray<UIColor *> *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size
{
    return [self zjs_gradientImageWithColors:colors startPoint:startPoint endPoint:endPoint size:size cornerRadius:0 roundingCorners:UIRectCornerAllCorners];
}

#pragma mark 用颜色创建一张带圆角的渐变色图片
+ (UIImage *)zjs_gradientImageWithColors:(NSArray<UIColor *> *)colors direction:(ZJSGradientDirection)direction size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners
{
    NSArray<NSValue *> *points = [self zjs_startAndEndPointWithDirection:direction size:size];
    return [self zjs_gradientImageWithColors:colors startPoint:points.firstObject.CGPointValue endPoint:points.lastObject.CGPointValue size:size cornerRadius:cornerRadius roundingCorners:roundingCorners];
}

+ (UIImage *)zjs_gradientImageWithColors:(NSArray<UIColor *> *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners
{
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)color.CGColor];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    if (cornerRadius) {
        UIBezierPath *cornerBezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:roundingCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        [cornerBezierPath addClip];
    }
    CGColorSpaceRef colorSpace = CGColorGetColorSpace(colors.lastObject.CGColor);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)cgColors, NULL);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    UIGraphicsEndImageContext();
    
    return targetImage;
}

#pragma mark - 根据渐变方向获取起始点（private）
+ (NSArray<NSValue *> *)zjs_startAndEndPointWithDirection:(ZJSGradientDirection)direction size:(CGSize)size
{
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    switch (direction) {
        case ZJSGradientDirectionTopToBottom:
        {
            startPoint = CGPointMake(0.f, 0.f);
            endPoint = CGPointMake(0.f, size.height);
        }
            break;
        case ZJSGradientDirectionLeftToRight:
        {
            startPoint = CGPointMake(0.f, 0.f);
            endPoint = CGPointMake(size.width, 0.f);
        }
            break;
        case ZJSGradientDirectionTopLeftToBottomRight:
        {
            startPoint = CGPointMake(0.f, 0.f);
            endPoint = CGPointMake(size.width, size.height);
        }
            break;
        case ZJSGradientDirectionTopRightToBottomLeft:
        {
            startPoint = CGPointMake(size.width, 0.f);
            endPoint = CGPointMake(0.f, size.height);
        }
            break;
        default:
            break;
    }
    return @[[NSValue valueWithCGPoint:startPoint], [NSValue valueWithCGPoint:endPoint]];
}

@end
