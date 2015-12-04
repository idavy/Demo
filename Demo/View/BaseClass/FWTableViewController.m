//
//  FWTableViewController.m
//  Demo
//
//  Created by Dave on 15/12/3.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "FWTableViewController.h"
#import "FWTableViewModel.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshBackNormalFooter.h"
#import "TPKeyboardAvoidingTableView.h"

@interface FWTableViewController ()

@property (nonatomic, strong, readwrite) UISearchBar *searchBar;
@property (nonatomic, strong, readwrite) TPKeyboardAvoidingTableView *tableView;

@property (nonatomic, strong, readonly) FWTableViewModel *viewModel;

@end

@implementation FWTableViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(FWTableViewModel *)viewModel {
	self = [super initWithViewModel:viewModel];
	if (self) {
		if ([viewModel shouldRequestRemoteDataOnViewDidLoad]) {
			@weakify(self)
			[[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
				@strongify(self)
				[self.viewModel.requestRemoteDataCommand execute:@1];
			}];
		}
	}
	return self;
}

- (void)setView:(UIView *)view {
	[super setView:view];
	if ([view isKindOfClass:UITableView.class]) self.tableView = (TPKeyboardAvoidingTableView *)view;
}

- (UIEdgeInsets)contentInset {
	return UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:self.viewModel.tableViewStyle];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.emptyDataSetDelegate = self;
	self.tableView.emptyDataSetSource = self;
	self.tableView.contentOffset = CGPointMake(0, self.searchBar.bounds.size.height - self.contentInset.top);
	self.tableView.contentInset  = self.contentInset;
	self.tableView.scrollIndicatorInsets = self.contentInset;
	
	self.tableView.sectionIndexColor = [UIColor darkGrayColor];
	self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
	self.tableView.sectionIndexMinimumDisplayRowCount = 10;
	
	self.tableView.tableHeaderView = self.searchBar;
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
	self.view = self.tableView;
	
	@weakify(self)
	if (self.viewModel.shouldPullToRefresh) {
		self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
			@weakify(self)
			[[[self.viewModel.requestRemoteDataCommand
			   execute:@1]
			  deliverOnMainThread]
			 subscribeNext:^(id x) {
				 @strongify(self)
				 self.viewModel.page = 1;
			 } error:^(NSError *error) {
				 @strongify(self)
				 [self.tableView.mj_header endRefreshing];
			 } completed:^{
				 @strongify(self)
				 [self.tableView.mj_header endRefreshing];
			 }];
		}];
	}
	
	if (self.viewModel.shouldInfiniteScrolling) {
		self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
			@strongify(self)
			[[[self.viewModel.requestRemoteDataCommand
			   execute:@(self.viewModel.page + 1)]
			  deliverOnMainThread]
			 subscribeNext:^(NSArray *results) {
				 @strongify(self)
				 self.viewModel.page += 1;
			 } error:^(NSError *error) {
				 @strongify(self)
				 [self.tableView.mj_footer endRefreshing];
			 } completed:^{
				 @strongify(self)
				 [self.tableView.mj_footer endRefreshing];
			 }];
		}];

		RAC(self.tableView.mj_footer, automaticallyHidden) = [[RACObserve(self.viewModel, dataSource)
														deliverOnMainThread]
													   map:^(NSArray *dataSource) {
														   @strongify(self)
														   NSUInteger count = 0;
														   for (NSArray *array in dataSource) {
															   count += array.count;
														   }
														   return @(count < self.viewModel.perPage);
													   }];
	}
	
	self.tableView.tableFooterView = [[UIView alloc] init];
}
- (UISearchBar *)searchBar
{
	if (!_searchBar && self.viewModel.shouldSearch) {
		_searchBar = [[UISearchBar alloc]init];
		
		_searchBar.layer.borderColor = HexRGB(colorB2).CGColor;
		_searchBar.layer.borderWidth = 0.5;
		_searchBar.tintColor    = HexRGB(colorI5);
		_searchBar.barTintColor = HexRGB(0xF0EFF5);
		_searchBar.placeholder  = @"Search";
		
		_searchBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
		_searchBar.delegate = self;
	}
	return _searchBar;
}
- (void)dealloc {
	_tableView.dataSource = nil;
	_tableView.delegate = nil;
}

- (void)bindViewModel {
	[super bindViewModel];
	
	@weakify(self)
	[RACObserve(self.viewModel, dataSource).distinctUntilChanged.deliverOnMainThread subscribeNext:^(id x) {
		@strongify(self)
		[self.tableView reloadData];
	}];
	
	[self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
		@strongify(self)
		UIView *emptyDataSetView = [self.tableView.subviews.rac_sequence objectPassingTest:^(UIView *view) {
			return [NSStringFromClass(view.class) isEqualToString:@"DZNEmptyDataSetView"];
		}];
		emptyDataSetView.alpha = 1.0 - executing.floatValue;
	}];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
	return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.viewModel.dataSource ? self.viewModel.dataSource.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
	
	id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
	[self configureCell:cell atIndexPath:indexPath withObject:(id)object];
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section >= self.viewModel.sectionIndexTitles.count) return nil;
	return self.viewModel.sectionIndexTitles[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	if (self.searchBar != nil) {
		if (self.viewModel.sectionIndexTitles.count != 0) {
			return [self.viewModel.sectionIndexTitles.rac_sequence startWith:UITableViewIndexSearch].array;
		}
	}
	return self.viewModel.sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	if (self.searchBar != nil) {
		if (index == 0) {
			[tableView scrollRectToVisible:self.searchBar.frame animated:NO];
		}
		return index - 1;
	}
	return index;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.viewModel.didSelectCommand execute:indexPath];
}


#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	self.viewModel.keyword = searchText;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:NO animated:YES];
	[searchBar resignFirstResponder];
	
	searchBar.text = nil;
	self.viewModel.keyword = nil;
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
	return [[NSAttributedString alloc] initWithString:@"无数据"];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
	return self.viewModel.dataSource == nil;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
	return YES;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
	return CGPointMake(0, -(self.tableView.contentInset.top - self.tableView.contentInset.bottom) / 2);
}

@end
