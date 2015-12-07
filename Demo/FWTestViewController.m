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
@property (nonatomic,strong) RACSubject *errorSubject;
@property (nonatomic,strong) RACCommand *command;
@property (nonatomic,strong) RACSubject *subject;


@property (nonatomic,strong) RACCommand *command2;
@property (nonatomic,strong) RACSubject *subject2;


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
	
	self.subject = [RACSubject subject];
	self.command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
		return self.subject;
	}];
	[self.command.errors subscribe:self.errorSubject];
	[self.errorSubject subscribeNext:^(id x) {
		
	}];
	
	[self performSelector:@selector(subjectSelector1) withObject:nil afterDelay:2];
	[self.command execute:@1];
	
	
	self.subject2 = [RACSubject subject];
	self.command2 = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
		return self.subject2;
	}];
	[self.command2.errors subscribe:self.errorSubject];
	[self.command2 execute:@2];
	
	[self performSelector:@selector(subjectSelector2) withObject:nil afterDelay:4];
	
}
- (RACSubject *)errorSubject {
	if (!_errorSubject) _errorSubject = [RACSubject subject];
	return _errorSubject;
}
- (void)subjectSelector1
{
	[self.subject2 sendError:@"error2"];
	[self.subject sendError:@"error1"];
	[self.command execute:@1];
	[self.subject sendError:@"error3"];
}

- (void)subjectSelector2
{
	
	[self.subject sendError:@"error4"];
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
