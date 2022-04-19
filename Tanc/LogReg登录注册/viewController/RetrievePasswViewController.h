//
//  RetrievePasswViewController.h
//  Tanc
//
//  Created by f on 2019/12/6.
//  Copyright © 2019 f. All rights reserved.
//找回密码

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RetrievePasswViewController : AllSupViewController
{
      BOOL bEmail;//当前是否是邮箱
}
@property (nonatomic,strong)NSString *strCode;
@end

NS_ASSUME_NONNULL_END
