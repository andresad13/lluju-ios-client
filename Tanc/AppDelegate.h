//
//  AppDelegate.h
//  Tanc
//
//  Created by f on 2019/12/3.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    ActivityView *activityView;
}
@property (strong, nonatomic) UIWindow *window;

//创建提示框
- (void)showAlter:(NSString *)message bSucc:(BOOL)bSucc;

- (void)addTopView:(UIView *)view;
//删除
- (void)removeActivityView;

/*创建加载*/
- (void)createActivityView;

/*退出*/
- (void)popViewController;

- (void)startinitView;
@end

