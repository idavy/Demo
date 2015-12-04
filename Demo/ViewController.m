//
//  ViewController.m
//  Demo
//
//  Created by Dave on 15/12/3.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "ViewController.h"
#import "FWTestViewController.h"
#import "FWTableViewModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}
- (IBAction)btnClick:(id)sender {
	FWTableViewModel *viewModle = [[FWTableViewModel alloc]initWithModel:nil];
	FWTestViewController *tsvc = [[FWTestViewController alloc]initWithViewModel:viewModle];
	
	UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:tsvc];
	[self presentViewController:nvc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
