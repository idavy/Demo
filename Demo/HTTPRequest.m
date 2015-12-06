//
//  HTTPReqeust.m
//  ProofMVVM
//
//  Created by Dave on 15/11/25.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "HTTPRequest.h"
#import "HTTPRequestManager.h"
#import "MJExtension.h"


@implementation HTTPRequest

+ (RACSignal *)proofDataWithToken:(NSString *)token params:(NSDictionary *)params
{
	NSDictionary *params2 = @{@"token" : @"USER_TOKEN_15501054218_UDZ_dfaf4ce1-2ca3-4903-81c3-e00bfbfb380b",
							 @"accVId": @(448)
							 };
	HTTPRequestManager *manager = [HTTPRequestManager manager];
	manager.logData = YES;
	return [[[[manager POST:@"http://udaizhang.com/Akk/accountVoucherRest/getAccountVoucherVById.json" parameters:params2] map:^id(id value) {
//		return [NewProofModel mj_objectWithKeyValues:value];
        return nil;
	}] doError:^(NSError *error) {
		
	}] replayLazily];
}

@end
