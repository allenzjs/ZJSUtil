//
//  CALayer+ZJSUtil.h
//  Pods-ZJSUtil_Example
//
//  Created by 查俊松 on 2018/9/18.
//

#import <UIKit/UIKit.h>

@interface CALayer (ZJSUtil)

// 设置任意圆角
- (void)setCornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners roundedRect:(CGRect)roundedRect;

@end
