//
//  HTTPReqeust.h
//
//  Created by Dave on 15/11/25.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequest : NSObject
+ (RACSignal *)proofDataWithToken:(NSString *)token params:(NSDictionary *)params;
@end
