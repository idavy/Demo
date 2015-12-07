//
//  FWHTTPRequestManager.h
//
//  Created by Dave on 15/11/25.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager+RACSupport.h"

extern  NSString *const FWHTTPRequestSucceedErrorDomain;
typedef NS_ENUM(NSInteger, RESULT_CODE) {
	RESULT_CODE_SPECIAL                    = -1,
	RESULT_CODE_SUCCESS                    = 0,
	RESULT_CODE_INVALID_TOKEN              = 1,
	RESULT_CODE_INVALID_PARAMETER          = 2,
	RESULT_CODE_FAIL                       = 3,
	RESULT_CODE_1001                       = 1001,
	RESULT_CODE_1002                       = 1002,
	RESULT_CODE_1003                       = 1003,
	RESULT_CODE_1004                       = 1004,
	RESULT_CODE_1005                       = 1005,
	RESULT_CODE_1006                       = 1006,
	RESULT_CODE_1007                       = 1007,
	RESULT_CODE_1008                       = 1008,
	RESULT_CODE_1009                       = 1009,
	RESULT_CODE_1010                       = 1010,
	RESULT_CODE_1011                       = 1011,
	RESULT_CODE_1012                       = 1012,
	RESULT_CODE_1013                       = 1013,
	RESULT_CODE_1014                       = 1014,
	
	RESULT_CODE_2001                       = 2001,
	RESULT_CODE_2003                       = 2003,
	RESULT_CODE_2004                       = 2004,
	RESULT_CODE_2005                       = 2005,
	RESULT_CODE_2006                       = 2006,
	RESULT_CODE_2007                       = 2007,
	RESULT_CODE_2008                       = 2008,
	RESULT_CODE_2009                       = 2009,
	RESULT_CODE_2010                       = 2010
};

@interface FWHTTPRequestManager : NSObject
@property (nonatomic,strong) AFHTTPRequestOperationManager *afManager;
@property (nonatomic,strong) RACSignal *errorSignal;
@property (nonatomic,assign) BOOL logData;
+ (instancetype)manager;

- (RACSignal *)POST:(NSString *)path parameters:(NSDictionary *)parameters;

@end
