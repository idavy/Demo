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
@end
