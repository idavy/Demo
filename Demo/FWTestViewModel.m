//
//  FWTestViewModel.m
//  Demo
//
//  Created by FangWei on 15/12/6.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "FWTestViewModel.h"

@implementation FWTestViewModel
- (void)initialize
{
    [super initialize];
    
    self.tableViewStyle = UITableViewStylePlain;
    self.shouldSearch = YES;
    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = YES;
    self.shouldRequestRemoteDataOnViewDidLoad = YES;
    
    
    RACSignal *requestRemoteDataSignal = [[self.requestRemoteDataCommand.executionSignals.switchToLatest doNext:^(NSArray *repositories) {
        
    }] map:^id(NSArray *repositories) {
        return nil;
    }];
}
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page
{
    return [HTTPRequest proofDataWithToken:nil params:nil];
}
@end
