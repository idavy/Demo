//
//  FWNavigationViewController.m
//  Demo
//
//  Created by Dave on 15/12/3.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "FWNavigationViewController.h"

@interface FWNavigationViewController ()

@end

@implementation FWNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate{
	return [self.visibleViewController shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
	return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	return [self.visibleViewController supportedInterfaceOrientations];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
	NSArray *poped = [super popToRootViewControllerAnimated:animated];
	UIViewController *vc = self.viewControllers.firstObject;
	
	return poped;
}
- (void)popCallback
{
	
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
	return nil;
}
//- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated; // Returns the popped controller.
//- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated; // Pops view controllers until the one specified is on top. Returns the popped controllers.
//- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated; // Pops until there's only a single view controller left on the stack. Returns the popped controllers.



@end
