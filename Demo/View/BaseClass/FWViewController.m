//
//  FWViewController.m
//  Demo
//
//  Created by Dave on 15/12/3.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "FWViewController.h"
#import "FWViewModel.h"

@interface FWViewController ()

@property (nonatomic, strong, readwrite) FWViewModel *viewModel;

@end

@implementation FWViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
	FWViewController *viewController = [super allocWithZone:zone];
	
	@weakify(viewController)
	[[viewController
	  rac_signalForSelector:@selector(viewDidLoad)]
	 subscribeNext:^(id x) {
		 @strongify(viewController)
		 [viewController bindViewModel];
	 }];
	
	return viewController;
}

- (FWViewController *)initWithViewModel:(id)viewModel {
	self = [super init];
	if (self) {
		self.viewModel = viewModel;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.extendedLayoutIncludesOpaqueBars = YES;
	
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
	backItem.title = @"返回";
	self.navigationItem.backBarButtonItem = backItem;
}

- (void)bindViewModel {
	// System title view
	RAC(self, title) = RACObserve(self.viewModel, title);
	
//	UIView *titleView = self.navigationItem.titleView;
//	
//	// Double title view
//	MRCDoubleTitleView *doubleTitleView = [[MRCDoubleTitleView alloc] init];
//	
//	RAC(doubleTitleView.titleLabel, text)    = RACObserve(self.viewModel, title);
//	RAC(doubleTitleView.subtitleLabel, text) = RACObserve(self.viewModel, subtitle);
//	
//	@weakify(self)
//	[[self
//	  rac_signalForSelector:@selector(viewWillTransitionToSize:withTransitionCoordinator:)]
//	 subscribeNext:^(id x) {
//		 @strongify(self)
//		 doubleTitleView.titleLabel.text    = self.viewModel.title;
//		 doubleTitleView.subtitleLabel.text = self.viewModel.subtitle;
//	 }];
//	
//	// Loading title view
//	MRCLoadingTitleView *loadingTitleView = [[NSBundle mainBundle] loadNibNamed:@"MRCLoadingTitleView" owner:nil options:nil].firstObject;
//	loadingTitleView.frame = CGRectMake((SCREEN_WIDTH - CGRectGetWidth(loadingTitleView.frame)) / 2.0, 0, CGRectGetWidth(loadingTitleView.frame), CGRectGetHeight(loadingTitleView.frame));
//	
//	RAC(self.navigationItem, titleView) = [RACObserve(self.viewModel, titleViewType).distinctUntilChanged map:^(NSNumber *value) {
//		MRCTitleViewType titleViewType = value.unsignedIntegerValue;
//		switch (titleViewType) {
//			case MRCTitleViewTypeDefault:
//				return titleView;
//			case MRCTitleViewTypeDoubleTitle:
//				return (UIView *)doubleTitleView;
//			case MRCTitleViewTypeLoadingTitle:
//				return (UIView *)loadingTitleView;
//		}
//	}];
	
	[self.viewModel.errors subscribeNext:^(NSError *error) {
//		@strongify(self)
//		
//		MRCLogError(error);
//		
//		if ([error.domain isEqual:OCTClientErrorDomain] && error.code == OCTClientErrorAuthenticationFailed) {
//			UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MRC_ALERT_TITLE
//																					 message:@"Your authorization has expired, please login again"
//																			  preferredStyle:UIAlertControllerStyleAlert];
//			
//			[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//				@strongify(self)
//				[SSKeychain deleteAccessToken];
//				
//				MRCLoginViewModel *loginViewModel = [[MRCLoginViewModel alloc] initWithServices:self.viewModel.services params:nil];
//				[self.viewModel.services resetRootViewModel:loginViewModel];
//			}]];
//			
//			[self presentViewController:alertController animated:YES completion:NULL];
//		} else if (error.code != OCTClientErrorTwoFactorAuthenticationOneTimePasswordRequired && error.code != OCTClientErrorConnectionFailed) {
//			MRCError(error.localizedDescription);
//		}
	}];
}



- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.viewModel.active = YES;
	if (self.interfaceOrientation != UIInterfaceOrientationPortrait
		&&![self isMemberOfClass:NSClassFromString(@"...ViewController")]) {
		[self forceChangeToOrientation:UIInterfaceOrientationPortrait];
	}
}
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.viewModel.active = NO;
}

#pragma mark - Orientations
- (BOOL)shouldAutorotate{
	return NO;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	return UIInterfaceOrientationPortrait;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskPortrait;
}
- (void)forceChangeToOrientation:(UIInterfaceOrientation)interfaceOrientation{
	[[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:interfaceOrientation] forKey:@"orientation"];
}
//设置状态栏的白色
-(UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}
@end
