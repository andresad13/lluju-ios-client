//
//  AllHeader.h
//  Tanc
//
//  Created by f on 2019/12/4.
//  Copyright © 2019 f. All rights reserved.
//所有头文件 宏

#ifndef AllHeader_h
#define AllHeader_h

#import "AppDelegate.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "NSDictionary+SetNullWithStr.h"

#define gAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate

#define MY_RECT(x,y,w,h) [GlobalObject ConvertScreen: CGRectMake(x, y, w, h)]

#define  CurLanguageCon(langu) (NSString *)[GlobalObject getCurLanguage:langu];
#define FontSize (IPHONE6SHEIGHT / IPHONE6SWIDTH)
#define HEIGHT [UIScreen mainScreen].bounds.size.height //获得当前屏幕高度
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define IPHONE6SHEIGHT      667.0 // 6S的尺寸
#define IPHONE6SWIDTH  375.0  // 6S的尺寸
   
#define curLanguage [GlobalObject shareObject].seleLanguage

#define  AllColorShadow [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:0.35]

#define GetRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height

#define PhoneHeight 64

#define ChargingApi @"https://cdb.lluju.com"

#define UpdateUserInfor @"updateUserInfor" //更新用户通知 用户更新了信息

#define GoMainNotification @"goMainNotification"

typedef enum
{
    Avenir_Light   = 1,//正常体
    Avenir_Roman  = 2,//中粗体
    Avenir_Black   = 3,//大粗体
    //r 中等 l正常的 b最粗的
}AvenirFontEnumType;//字体

#endif /* AllHeader_h */
