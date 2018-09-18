//
//  CALayer+ZJSUtil.m
//  Pods-ZJSUtil_Example
//
//  Created by 查俊松 on 2018/9/18.
//

#import "CALayer+ZJSUtil.h"

@implementation CALayer (ZJSUtil)

#pragma mark - 设置任意圆角
- (void)setCornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners roundedRect:(CGRect)roundedRect
{
    UIBezierPath *cornerBezierPath = [UIBezierPath bezierPathWithRoundedRect:roundedRect byRoundingCorners:roundingCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *cornerLayer = [CAShapeLayer layer];
    cornerLayer.frame = roundedRect;
    cornerLayer.path = cornerBezierPath.CGPath;
    self.mask = cornerLayer;
}

@end
