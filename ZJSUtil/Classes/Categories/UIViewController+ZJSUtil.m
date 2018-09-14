//
//  UIViewController+ZJSUtil.m
//  Pods-ZJSUtil_Example
//
//  Created by 查俊松 on 2018/9/14.
//

#import "UIViewController+ZJSUtil.h"

@implementation UIViewController (ZJSUtil)

#pragma mark 递归寻找最合适的控制器
+ (UIViewController *)zjs_findBestViewController:(UIViewController *)vc
{
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController zjs_findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count > 0) {
            return [UIViewController zjs_findBestViewController:svc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *nvc = (UINavigationController *)vc;
        if (nvc.viewControllers.count > 0) {
            return [UIViewController zjs_findBestViewController:nvc.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *tvc = (UITabBarController *)vc;
        if (tvc.viewControllers.count > 0) {
            return [UIViewController zjs_findBestViewController:tvc.selectedViewController];
        } else {
            return vc;
        }
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

#pragma mark 获取当前控制器
+ (UIViewController *)zjs_currentVC
{
    // Find best view controller
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController zjs_findBestViewController:rootVC];
}

#pragma mark 获取当前可用来跳转的控制器
+ (UIViewController *)zjs_jumpSafeVC
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWindow in windows) {
            if (tmpWindow.windowLevel == UIWindowLevelNormal) {
                window = tmpWindow;
                break;
            }
        }
    }
    UIViewController *vc = window.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    return vc;
}

@end
