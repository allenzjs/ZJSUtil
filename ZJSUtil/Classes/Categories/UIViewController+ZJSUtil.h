//
//  UIViewController+ZJSUtil.h
//  Pods-ZJSUtil_Example
//
//  Created by 查俊松 on 2018/9/14.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZJSUtil)

// 获取当前控制器
+ (UIViewController *)zjs_currentVC;
// 获取当前可用来跳转的控制器
+ (UIViewController *)zjs_jumpSafeVC;

@end
