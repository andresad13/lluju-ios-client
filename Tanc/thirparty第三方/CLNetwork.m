//
//  CLMQTT.m
//  CLTool
//
//  Created by apple on 2017/12/14.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CLNetwork.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>

@implementation CLNetwork

+ (void)GET:(NSString *)strURL parameter:(NSDictionary *)para success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[GlobalObject shareObject].toKenSear forHTTPHeaderField:@"token"];
    [manager GET:strURL parameters:@{} headers:nil   progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (success) {
                // responseObject = [NSDictionary changeType:responseObject];
                success(responseObject);
            }
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (failure) {
                failure(error);
            }
        }];
    }];
 
}


+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    
//    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
//
//    NSRange range = {0,jsonString.length};
//
//    //去掉字符串中的空格
//
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//
//    NSRange range2 = {0,mutStr.length};
//
//    //去掉字符串中的换行符
//
//    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return jsonString;
    
    
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(NSString*) bv_jsonStringWithPrettyPrint:(NSDictionary *) dictionaryOrArrayToOutput {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionaryOrArrayToOutput
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return @"";
}

+ (void)POST1111:(NSString *)strURL parameter:(NSDictionary *)para success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {

    __block  AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    
    [manager POST:strURL parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
    
    
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//    manager.requestSerializer.timeoutInterval = 10;
//  // [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
////   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//
////     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain",@"application/x-www-form-urlencoded", nil];
//
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"application/x-www-form-urlencoded", @"text/plain",nil];
//
//
//
//    NSString *paramString = [CLNetwork convertToJsonData:para];
//   NSData *data = [paramString dataUsingEncoding:NSUTF8StringEncoding];
////    NSString *result =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
////    NSLog(@"************ %@ ***********",result);
//
//    [manager POST:strURL parameters:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];


    return;
//    // 处理参数，JSON.parse不识别
//    NSMutableDictionary *dicSend = [NSMutableDictionary dictionary];
//    for (NSString *strKey in para.allKeys) {
//        NSString *strValue;
//        if ([NSJSONSerialization isValidJSONObject:para[strKey]]) {
//            NSData *data = [NSJSONSerialization dataWithJSONObject:para[strKey] options:0 error:nil];
//            strValue = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        }else {
//            strValue = para[strKey];
//        }
//        [dicSend setValue:strValue forKey:strKey];
//    }
//    // 验证
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    //(NSString *)gObject.iphoneDevId
//    // [manager.requestSerializer setValue:@"doAction" forHTTPHeaderField:@"te_method"];
//
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//   [manager.requestSerializer setValue:(NSString *)@"1778874" forHTTPHeaderField:@"uuid"];
//    manager.requestSerializer.timeoutInterval = 15; // 设置超时
//  //  [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"sirolc" password:[self authorizationHeaderFieldPassword]];
//
//    // https安全
//    // 引用时framework名称不能改，须放在Copy Bundle Recources中，不然取不到资源文件
//    //    NSString *frameworkPath = [[NSBundle mainBundle] pathForResource:@"CLTool" ofType:@"framework"];
//    //    NSBundle *bundle = [NSBundle bundleWithPath:frameworkPath];
//    //    NSString *cerPath = [bundle pathForResource:@"humphrey" ofType:@"cer"];
//
////    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"humphrey" ofType:@"cer"];
////
////    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
////    NSSet *cerSet = [[NSSet alloc]initWithObjects:cerData, nil];
////    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone withPinnedCertificates:cerSet];
////    securityPolicy.allowInvalidCertificates = YES;
////    securityPolicy.validatesDomainName = NO;
////    manager.securityPolicy = securityPolicy;
//
//    AFJSONResponseSerializer *serializer = [[AFJSONResponseSerializer alloc] init];
//    serializer.removesKeysWithNullValues = YES; // 去掉Null
//    serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
//    manager.responseSerializer = serializer;
//
//    [manager POST:strURL parameters:dicSend progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
}

//POST请求 使用NSMutableURLRequest可以加入请求头
+ (void)PUT:(NSString *)strURL parameter:(NSDictionary *)para success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSURL *nsurl = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //如果想要设置网络超时的时间的话，可以使用下面的方法：
    //     NSMutableURLRequest *mutableRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:strURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //设置请求类型
    request.HTTPMethod = @"PUT";
    
    //将需要的信息放入请求头 随便定义了几个
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSLog(@"POST-Header:%@",request.allHTTPHeaderFields);
    
    NSString *paramString = [CLNetwork convertToJsonData:para];
    
    //把参数放到请求体内
    request.HTTPBody = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            //请求失败
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (failure) {
                    failure(error);
                }
            }];
            
        } else {  //请求成功
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                 result = [NSDictionary changeType:result];
                if (success) {
                    success(result);
                }
            }];
            
            //            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //                // 需要在主线程执行的代码
            //
            //
            //
            //            });
            
            
        }
    }];
    [dataTask resume];  //开始请求
}


//POST请求 使用NSMutableURLRequest可以加入请求头
+ (void)DELETE:(NSString *)strURL parameter:(NSDictionary *)para success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSURL *nsurl = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //如果想要设置网络超时的时间的话，可以使用下面的方法：
    //     NSMutableURLRequest *mutableRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:strURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //设置请求类型
    request.HTTPMethod = @"DELETE";
    
    //将需要的信息放入请求头 随便定义了几个
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSLog(@"POST-Header:%@",request.allHTTPHeaderFields);
    
    NSString *paramString = [CLNetwork convertToJsonData:para];
    
    //把参数放到请求体内
    request.HTTPBody = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            //请求失败
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (failure) {
                    failure(error);
                }
            }];
            
        } else {  //请求成功
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                 result = [NSDictionary changeType:result];
                if (success) {
                    success(result);
                }
            }];
            
            //            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //                // 需要在主线程执行的代码
            //
            //
            //
            //            });
            
            
        }
    }];
    [dataTask resume];  //开始请求
}

//POST请求 使用NSMutableURLRequest可以加入请求头
+ (void)POST:(NSString *)strURL parameter:(NSDictionary *)para success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSURL *nsurl = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //如果想要设置网络超时的时间的话，可以使用下面的方法：
   //  NSMutableURLRequest *mutableRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:strURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]; 
    //设置请求类型
    request.HTTPMethod = @"POST";
    
    //将需要的信息放入请求头 随便定义了几个
     [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
    
   
    
    NSString *paramString = [CLNetwork convertToJsonData:para];
    [request setValue:[GlobalObject shareObject].toKenSear forHTTPHeaderField:@"token"];
    //把参数放到请求体内
    request.HTTPBody = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            //请求失败
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (failure) {
                    failure(error);
                }
            }];
            
        } else {  //请求成功
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
               result = [NSDictionary changeType:result];
               if ([[result allKeys]containsObject:@"code"]  &&
                  ( [ result[@"code"] intValue] == -1   ) && [GlobalObject shareObject].toKenSear && [[GlobalObject shareObject].toKenSear length]> 0 )
               {
                   [gAppDelegate  removeActivityView];
                   [gAppDelegate popViewController];
//
                   [gAppDelegate showAlter:result[@"msg"] bSucc:NO];
               }
               else
               {
                   success(result);
               }
            }];
        }
    }];
    [dataTask resume];  //开始请求
}


+ (void)GetImage:(NSString *)strURL  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    // 处理参数，JSON.parse不识别
    
    
    // 验证
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15; // 设置超时
    //[manager.requestSerializer setAuthorizationHeaderFieldWithUsername:[gObject getRestUser] password:[self authorizationHeaderFieldPassword]];
    //rest
    
    
    // https安全
    // 引用时framework名称不能改，须放在Copy Bundle Recources中，不然取不到资源文件
    //    NSString *frameworkPath = [[NSBundle mainBundle] pathForResource:@"CLTool" ofType:@"framework"];
    //    NSBundle *bundle = [NSBundle bundleWithPath:frameworkPath];
    //    NSString *cerPath = [bundle pathForResource:@"humphrey" ofType:@"cer"];
    
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"humphrey" ofType:@"cer"];
//
//    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
//    NSSet *cerSet = [[NSSet alloc]initWithObjects:cerData, nil];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone withPinnedCertificates:cerSet];
//    securityPolicy.allowInvalidCertificates = YES;
//    securityPolicy.validatesDomainName = NO;
//    manager.securityPolicy = securityPolicy;
    
    AFJSONResponseSerializer *serializer = [[AFJSONResponseSerializer alloc] init];
    serializer.removesKeysWithNullValues = YES; // 去掉Null
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    manager.responseSerializer = serializer;
    
    
    [manager GET:strURL parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"-0-0-00-0");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}


+ (NSString *)authorizationHeaderFieldPassword {
    // 加盐（去掉时分秒后的date）
    NSDate *date = [NSDate date]; // 获得时间对象
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    NSDate *date0 = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    NSString *str = [dateFormatter stringFromDate:date0];
    
    NSDate *date1 = [dateFormatter dateFromString:str];
    // NSDate *date1970 = [dateFormatter dateFromString:@"1970-01-01"];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date1 timeIntervalSince1970] * 1000];
    
    NSString *str2 = [NSString stringWithFormat:@"!#%%QET%@^*)yip", timeSp];
    NSString *str1 = [NSString stringWithFormat:@"%@%@%@",@"!#%QET", timeSp,@"^*)yip"];
    // NSString *str1 = [NSString stringWithFormat:@"%@%@%@",[gObject getRestPass1], timeSp,[gObject getRestPass2]];
    //rest
    return [[self MD5:str1] lowercaseString];
}

+ (NSString *)authorizationHeaderFieldPassword1{
    // 加盐（去掉时分秒后的date）
    
    NSDate *date0 = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSString *str = [dateFormatter stringFromDate:date0];
    
    NSDate *date1 = [dateFormatter dateFromString:str];
    NSTimeZone* localTimeZone = [NSTimeZone localTimeZone];
    
    //计算世界时间与本地时区的时间偏差值
    NSInteger offset = [localTimeZone secondsFromGMTForDate:date1];
    
    //世界时间＋偏差值 得出中国区时间
    NSDate *localDate = [date1 dateByAddingTimeInterval:offset];
    
    
    // NSDate *date34 = [dateFormatter dateFromString:str];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970] * 1000];
    //  NSString *str1 = [NSString stringWithFormat:@"!#%%QET%@^*)yip", timeSp];
    //    NSString *str1 = [NSString stringWithFormat:@"%@%@%@",[gObject getRestPass1], timeSp,[gObject getRestPass2]];
    NSString *str1 = [NSString stringWithFormat:@"%@%@%@",@"!#%QET", timeSp,@"^*)yip"];
    return [[self MD5:str1] lowercaseString];
}


+ (NSString *)MD5:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}

@end


