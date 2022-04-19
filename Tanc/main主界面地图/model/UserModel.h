//
//  UserModel.h
//  Tanc
//
//  Created by f on 2019/12/6.
//  Copyright © 2019 f. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (nonatomic,strong)NSString *appQrCode;//app下载二维码地址
@property (nonatomic,strong)NSString *avatar;//微信头像
@property (nonatomic,strong)NSString *defaultAccount;//租借充电宝需要缴纳押金
@property (nonatomic,strong)NSString *email;//邮箱

@property (nonatomic,strong)NSString *number;//用户ID，用于显示
@property (nonatomic,strong)NSString *tel;//手机号
@property (nonatomic,strong)NSString *userName;// 微信昵称
@property (nonatomic,strong)NSString *wallet;
@property (nonatomic,strong)NSString *openid;

+ (UserModel *)createUserModel:(NSDictionary *)dic;

+ (void)updateUserModel:(UserModel *)model dic:(NSDictionary *)dic;

+ (void)requestCus;


+ (UIImage *)getMapIcon:(BOOL)bOnli bBig:(BOOL)bBig number:(int)number;

+(void)requestUserInfor;
@end

NS_ASSUME_NONNULL_END
