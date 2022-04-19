//
//  CLMQTT.h
//  CLTool
//
//  Created by apple on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLNetwork : NSObject

+ (void)DELETE:(NSString *)strURL parameter:(NSDictionary *)para success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)GET:(NSString *)strURL parameter:(NSDictionary *)para success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)POST:(NSString *)urlStr parameter:(NSDictionary *)para success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)PUT:(NSString *)strURL parameter:(NSDictionary *)para success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)POST1111:(NSString *)strURL parameter:(NSDictionary *)para success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)postWithUrlString:(NSString *)url parameters:(NSDictionary *)parameters;

+(NSString *)convertToJsonData:(NSDictionary *)dict;

@end
