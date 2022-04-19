//
//  UserModel.m
//  Tanc
//
//  Created by f on 2019/12/6.
//  Copyright © 2019 f. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


+ (UserModel *)createUserModel:(NSDictionary *)dic
{
    UserModel *model = [[UserModel alloc]init];
    model.avatar = [GlobalObject judgeStringNil:dic[@"avatarUrl"]];
    model.defaultAccount = [GlobalObject judgeStringNil:dic[@"defaultAccount"]];
    model.email = [GlobalObject judgeStringNil:dic[@"email"]];
    model.appQrCode = [GlobalObject judgeStringNil:dic[@"appQrCode"]];
    model.number = [GlobalObject judgeStringNil:dic[@"number"]];
    model.tel = [GlobalObject judgeStringNil:dic[@"tel"]];
    model.userName = [GlobalObject judgeStringNil:dic[@"wxname"]];
    model.wallet = [GlobalObject judgeStringNil:dic[@"accountMy"]];
    model.openid = [GlobalObject judgeStringNil:dic[@"openid"]];
    
    NSString *strWallet = [NSString stringWithFormat:@"%0.1f",[[GlobalObject judgeStringNil:dic[@"accountMy"]] floatValue]];
     model.wallet = strWallet;
    
    NSString *accountYajin = [NSString stringWithFormat:@"%0.1f",[[GlobalObject judgeStringNil:dic[@"accountYajin"]] floatValue]];
    model.defaultAccount = accountYajin;
     
    
    return model;
}

+ (void)updateUserModel:(UserModel *)model dic:(NSDictionary *)dic
{
  
    model.avatar = [GlobalObject judgeStringNil:dic[@"avatarUrl"]];
    model.defaultAccount = [GlobalObject judgeStringNil:dic[@"defaultAccount"]];
    model.email = [GlobalObject judgeStringNil:dic[@"email"]];
    model.appQrCode = [GlobalObject judgeStringNil:dic[@"appQrCode"]];
    model.number = [GlobalObject judgeStringNil:dic[@"number"]];
    model.tel = [GlobalObject judgeStringNil:dic[@"tel"]];
    model.userName = [GlobalObject judgeStringNil:dic[@"wxname"]];
    model.wallet = [GlobalObject judgeStringNil:dic[@"accountMy"]];
    model.openid = [GlobalObject judgeStringNil:dic[@"openid"]];
    NSString *strWallet = [NSString stringWithFormat:@"%0.1f",[[GlobalObject judgeStringNil:dic[@"accountMy"]] floatValue]];
     model.wallet = strWallet;
    
    NSString *accountYajin = [NSString stringWithFormat:@"%0.1f",[[GlobalObject judgeStringNil:dic[@"accountYajin"]] floatValue]];
    model.defaultAccount = accountYajin;
}


+ (void)requestCus
{
    NSString *str = [ChargingApi stringByAppendingString:@"/UserApp/More/about"];
     
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            [GlobalObject shareObject].serviceCus = responseObject[@"data"];
          
        }
        else
        {
          //  [gAppDelegate showAlter:responseObject[@"message"]  bSucc:NO];
        }
    } failure:^(NSError *error) {
     
    }];
}


+ (UIImage *)getMapIcon:(BOOL)bOnli bBig:(BOOL)bBig number:(int)number
{
    NSString *strImage = @"";
    if (bOnli) {
        
        strImage = bBig ? @"map_sele_" : @"map_sele_sm_";
    }
    else
    {
        strImage = bBig ? @"map_" : @"map_sm_";
    }
    strImage = [strImage stringByAppendingFormat:@"%d",number];
    return [UIImage imageNamed:strImage];
}


+(void)requestUserInfor
{
   // __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:@"/UserApp/User/Info"];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            [UserModel updateUserInfor:responseObject[@"data"]];
        }
        else
        {
            [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:NO];
        }
    } failure:^(NSError *error) {
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
        
    }];
}

+ (void)updateUserInfor:(NSDictionary *)dic
{
    [UserModel updateUserModel:[GlobalObject shareObject].userModel dic:dic];
}
@end
