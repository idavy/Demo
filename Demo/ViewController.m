//
//  ViewController.m
//  Demo
//
//  Created by Dave on 15/12/3.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "ViewController.h"
#import "FWTestViewController.h"
#import "FWTestViewModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}
- (IBAction)btnClick:(id)sender {
	FWTestViewModel *viewModle = [[FWTestViewModel alloc]initWithModel:nil];
	FWTestViewController *tsvc = [[FWTestViewController alloc]initWithViewModel:viewModle];

	[self fw_dismissVCAnimated:YES sendObject:nil completion:nil];
    [self.navigationController pushViewController:tsvc animated:YES];
//    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:tsvc];
//    [self presentViewController:nvc animated:YES completion:nil];
}
- (void)popedCallback:(id)obj
{
    
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
