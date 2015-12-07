//
//  UIViewController+FWExtension.h
//  Demo
//
//  Created by Dave on 15/12/7.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FWExtension)
- (void)popedCallback:(id)obj;
- (void)fw_dismissVCAnimated:(BOOL)flag sendObject:(id)obj completion:(void (^)(void))completion;
@end

@interface UINavigationController (FWExtension)

- (NSArray<UIViewController *> *)fw_popToRootVCAnimated:(BOOL)animated sendObject:(id)obj;
- (NSArray<UIViewController *> *)fw_popToVC:(UIViewController *)viewController animated:(BOOL)animated sendObject:(id)obj;
- (UIViewController *)fw_popVCAnimated:(BOOL)animated sendObject:(id)obj;
///弹出到指定index的视图控制器
- (NSArray<UIViewController *> *)fw_popToVCAtIndex:(NSInteger)index animated:(BOOL)animated sendObject:(id)obj;
///弹出到最下层的vcClass视图控制器
- (NSArray<UIViewController *> *)fw_popToBottomVCClass:(Class)vcClass animated:(BOOL)animated sendObject:(id)obj;
///弹出到最上层的vcClass视图控制器
- (NSArray<UIViewController *> *)fw_popToTopVCClass:(Class)vcClass animated:(BOOL)animated sendObject:(id)obj;

@end

@interface UITabBarController (FWExtension)

@end