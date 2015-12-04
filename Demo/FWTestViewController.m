//
//  FWTestViewController.m
//  Demo
//
//  Created by Dave on 15/12/3.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "FWTestViewController.h"

@interface FWTestViewController ()

@property (nonatomic,strong,readwrite) FWTableViewModel *viewModel;

@end

@implementation FWTestViewController
@dynamic viewModel;
- (instancetype)initWithViewModel:(FWViewModel *)viewModel
{
	self = [super initWithViewModel:viewModel];
	if (self == nil) return nil;
	self.viewModel.tableViewStyle = UITableViewStylePlain;
	self.viewModel.shouldSearch = YES;
	self.viewModel.shouldPullToRefresh = YES;
	self.viewModel.shouldInfiniteScrolling = YES;
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.viewModel.tableViewStyle = UITableViewStyleGrouped;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end