//
//  UINavigationController+FWExtension.m
//  Demo
//
//  Created by FangWei on 15/12/5.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "UINavigationController+FWExtension.h"


@implementation UINavigationController (FWExtension)

- (NSArray<UIViewController *> *)fw_popToRootVCAnimated:(BOOL)animated sendObject:(id)obj {
    NSArray *popedArray = [self popToRootViewControllerAnimated:animated];
    UIViewController *desvc = self.topViewController;
    if ([desvc respondsToSelector:@selector(popedCallback:)]) {
        [desvc popedCallback:obj];
    }
    return popedArray;
}
- (NSArray<UIViewController *> *)fw_popToVC:(UIViewController *)viewController animated:(BOOL)animated sendObject:(id)obj {
    if (!viewController) return nil;
    NSArray *popedArray = [self popToViewController:viewController animated:animated];
    UIViewController *desvc = self.topViewController;
    if ([desvc respondsToSelector:@selector(popedCallback:)]) {
        [desvc popedCallback:obj];
    }
    return popedArray;
}
- (UIViewController *)fw_popVCAnimated:(BOOL)animated sendObject:(id)obj {
    UIViewController *popedVC = [self popViewControllerAnimated:animated];
    UIViewController *desvc = self.topViewController;
    if ([desvc respondsToSelector:@selector(popedCallback:)]) {
        [desvc popedCallback:obj];
    }
    return popedVC;
}
- (NSArray<UIViewController *> *)fw_popToVCAtIndex:(NSInteger)index animated:(BOOL)animated sendObject:(id)obj {
    UIViewController *desvc = self.viewControllers.count > index ? self.viewControllers[index] : nil;
    return [self fw_popToVC:desvc animated:animated sendObject:obj];
}
- (NSArray<UIViewController *> *)fw_popToBottomVCClass:(Class)vcClass animated:(BOOL)animated sendObject:(id)obj {
    __block UIViewController *vc = nil;
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:vcClass]) {
            vc = obj;
        }
    }];
    return [self fw_popToVC:vc animated:animated sendObject:obj];
}
- (NSArray<UIViewController *> *)fw_popToTopVCClass:(Class)vcClass animated:(BOOL)animated sendObject:(id)obj {
    __block UIViewController *vc = nil;
    [self.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:vcClass]) {
            vc = obj;
        }
    }];
    return [self fw_popToVC:vc animated:animated sendObject:obj];
}
#pragma Orientation
- (BOOL)shouldAutorotate{
    return [self.visibleViewController shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.visibleViewController supportedInterfaceOrientations];
}
@end
