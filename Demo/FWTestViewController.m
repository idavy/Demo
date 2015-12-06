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
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(rightItemBtnClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    @weakify(self)
    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue && self.viewModel.dataSource.count == 0) {
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = self.labelText;
        } else {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
    
}
- (void)rightItemBtnClick
{
    [self.navigationController fw_popToRootVCAnimated:YES sendObject:@"aaaa"];
//    [self.navigationController fw_popToTopVCClass:NSClassFromString(@"viewController") animated:YES sendObject:@"bbbbb"];
//    [self fw_dismissVCAnimated:YES sendObject:@"cccccc" completion:nil];
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
