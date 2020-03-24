//
//  UIButton+ZJSUtil.m
//  Pods-ZJSUtil_Example
//
//  Created by 查俊松 on 2018/9/14.
//

#import "UIButton+ZJSUtil.h"
#import <objc/runtime.h>

@implementation UIButton (ZJSUtil)

static char TopNameKey;
static char LeftNameKey;
static char BottomNameKey;
static char RightNameKey;

#pragma mark - 扩大按钮可点击区域
- (void)zjs_enlargeTouchAreaWithOffset:(UIEdgeInsets)offset
{
    objc_setAssociatedObject(self, &TopNameKey, [NSNumber numberWithFloat:offset.top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &LeftNameKey, [NSNumber numberWithFloat:offset.left], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &BottomNameKey, [NSNumber numberWithFloat:offset.bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &RightNameKey, [NSNumber numberWithFloat:offset.right], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)zjs_enlargedRect
{
    NSNumber *topEdge = objc_getAssociatedObject(self, &TopNameKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &LeftNameKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &BottomNameKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &RightNameKey);
    if (topEdge && leftEdge && bottomEdge && rightEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = [self zjs_enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point);
}

@end
