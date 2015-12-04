//
//  FWTableViewModel.m
//  Demo
//
//  Created by Dave on 15/12/3.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "FWTableViewModel.h"

@interface FWTableViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation FWTableViewModel
- (void)initialize {
	[super initialize];
	
	self.shouldRequestRemoteDataOnViewDidLoad = YES;
	self.tableViewStyle = UITableViewStylePlain;
	self.shouldSearch = NO;
	
	self.page = 1;
	self.perPage = 10;
	
	@weakify(self)
	self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *page) {
		@strongify(self)
		return [[self requestRemoteDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
	}];
	
	[[self.requestRemoteDataCommand.errors
	  filter:[self requestRemoteDataErrorsFilter]]
	 subscribe:self.errors];
}

- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter {
	return ^(NSError *error) {
		return YES;
	};
}

- (id)fetchLocalData {
	return nil;
}

- (NSUInteger)offsetForPage:(NSUInteger)page {
	return (page - 1) * self.perPage;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
	return [RACSignal empty];
}


@end
