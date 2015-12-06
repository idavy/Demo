//
//  HTTPRequestManager.m
//  ProofMVVM
//
//  Created by Dave on 15/11/25.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "HTTPRequestManager.h"

NSString *const HTTPRequestSucceedErrorDomain = @"HTTPRequestSucceedErrorDomain";

NSString * errorDescription(NSInteger code) {
	switch (code) {
		case NSURLErrorUnknown:                                return @"未知错误";
		case NSURLErrorCannotConnectToHost:                    ;
		case NSURLErrorCannotFindHost:                         ;
		case NSURLErrorNotConnectedToInternet:                 return @"网络未连接，请检查网络";
		case NSURLErrorTimedOut:                               ;
		case NSURLErrorCannotLoadFromNetwork:                  return @"当前网络不佳，请稍后重试";
		case NSURLErrorCancelled:                              return @"请求失败，请重试";
		case NSURLErrorBadServerResponse:                      ;
		case NSURLErrorResourceUnavailable:                    return @"服务器错误";
		case NSURLErrorServerCertificateHasBadDate:            ;
		case NSURLErrorCannotDecodeRawData:                    ;
		case NSURLErrorCannotDecodeContentData:                return @"服务器返回异常";
		case NSURLErrorNetworkConnectionLost:                  return @"失去连接，请重试";
		case NSURLErrorDownloadDecodingFailedMidStream:        ;
		case NSURLErrorDownloadDecodingFailedToComplete:       return @"下载失败";
		case NSURLErrorBadURL:                                 ;
		case NSURLErrorUnsupportedURL:                         return @"非法URL";
		default:                                               return @"网连接失败";
	}
}
NSString * resultMessage(RESULT_CODE resultCode, NSString *message) {
	switch (resultCode) {
		case RESULT_CODE_SPECIAL:                              return message;
		case RESULT_CODE_SUCCESS:                              return @"成功";
		case RESULT_CODE_INVALID_TOKEN:
			[[NSNotificationCenter defaultCenter] postNotificationName:@"" object:nil];
			return @"用户登录过期,请重新登录.";
		case RESULT_CODE_INVALID_PARAMETER:                    return @"无效的参数";
		case RESULT_CODE_FAIL:                                 return @"未知错误";
		case RESULT_CODE_1001:                                 return @"密码格式不正确，必需是大于6位并且包含大写字母、小写字母和数字";
		case RESULT_CODE_1002:                                 return @"用户已存在";
		case RESULT_CODE_1003:                                 return @"手机号已存在";
		case RESULT_CODE_1004:                                 return @"该部门存在下级部门，不能删除";
		case RESULT_CODE_1005:                                 return @"相同名称的部门已存在";
		case RESULT_CODE_1006:                                 return @"该项目存在子项目，不能删除";
		case RESULT_CODE_1007:                                 return @"多个用户已存在";
		case RESULT_CODE_1008:                                 return @"不能删除正在使用的账号";
		case RESULT_CODE_1009:                                 return @"当前账套不能删除";
		case RESULT_CODE_1010:                                 return @"邮箱格式不正确";
		case RESULT_CODE_1011:                                 return @"账套已存在";
		case RESULT_CODE_1012:                                 return @"手机号格式不正确";
		case RESULT_CODE_1013:                                 return @"手机号或密码错误";
		case RESULT_CODE_1014:                                 return @"验证码不正确";
			
		case RESULT_CODE_2001:                                 return @"查询结束时间不能在建账时间之前";
		case RESULT_CODE_2003:                                 return @"已有凭证生成或已存在余额信息,不能导入余额数据!";
		case RESULT_CODE_2004:                                 return @"新增凭证时间不能比建账时间早,保存失败!";
		case RESULT_CODE_2005:                                 return @"分录金额不能全为0";
		case RESULT_CODE_2006:                                 return @"仅允许删除状态为未提交或已撤销的申请单";
		case RESULT_CODE_2007:                                 return @"电话号码或密码不正确";
		case RESULT_CODE_2008:                                 return @"验证码不正确";
		case RESULT_CODE_2009:                                 return @"密码或新密码不正确";
		case RESULT_CODE_2010:                                 return @"电话号码不正确";
	}
	return @"请求失败";
}

@implementation HTTPRequestManager
+ (instancetype)manager {
	return [[self alloc]init];
}
- (instancetype)init {
	self = [super init];
	if (self) {
		self.logData = NO;
		self.afManager = [AFHTTPRequestOperationManager manager];
		AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
		jsonResponseSerializer.removesKeysWithNullValues = YES;
		self.afManager.responseSerializer = jsonResponseSerializer;
	}
	return self;
}

- (RACSignal *)POST:(NSString *)path parameters:(NSDictionary *)parameters {
	return [[[self.afManager rac_POST:path parameters:parameters] doError:^(NSError *error) {
		NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
		userInfo[NSLocalizedDescriptionKey] = errorDescription(error.code);
		[error setValue:userInfo forKey:@"userInfo"];
	}] flattenMap:^RACStream *(id value) {
		return [self errorSignalWithValue:value];
	}];
}

- (RACSignal *)errorSignalWithValue:(RACTuple *)value {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		id responseObject = value.second;
		if (self.logData) {
			AFHTTPRequestOperation *op = value.first;
			NSLog(@"%@",op.responseString);
		}
		if ([responseObject[@"success"] isEqual:@1]) {
			[subscriber sendNext:responseObject[@"datas"]];
			[subscriber sendCompleted];
		}
		else {
			NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
			userInfo[RAFNetworkingOperationErrorKey] = value.first;
			userInfo[NSLocalizedDescriptionKey] = resultMessage([responseObject[@"resultCode"] integerValue], responseObject[@"message"]);
			NSError *error = [NSError errorWithDomain:HTTPRequestSucceedErrorDomain code:-200 userInfo:userInfo];
			[subscriber sendError:error];
		}
		return nil;
	}];
}
@end
