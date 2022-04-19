//
//  AppDelegate.m
//  Tanc
//
//  Created by f on 2019/12/3.
//  Copyright © 2019 f. All rights reserved.
//

#import "AppDelegate.h"
#import  "LogReiViewController.h"
#import "USerProWindow.h"
#import "MainViewController.h"
#import "OpeningAnimaViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MercadoPago.h"
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>
#import "NSDate+FSCalendar.h"

@interface AppDelegate ()<JPUSHRegisterDelegate>
{
       UINavigationController *navController; 
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self initData:launchOptions];
    
    [self initLogReiViewController];
    
 
//    NSDate *currentMonthDate = [NSDate date];;
//   NSInteger num = [currentMonthDate dateDay];
    return YES;
}

- (void)initData:(NSDictionary *)launchOptions
{
    [MercadoPago setPublishableKey:@"APP_USR-1701a76a-89e1-40ad-9da6-a5ac6ef4e90e"];
    
    [GMSServices provideAPIKey:@"AIzaSyDgwxHMLznfINTlLTgtVNACdGW9Nu2KUPQ"];
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService removeNotification:nil];
    
    [JPUSHService setBadge:0];
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    [JPUSHService setupWithOption:launchOptions appKey:@"f135527120de39541140f846"
                             channel:@"" apsForProduction:NO];
    
}

- (void)initLogReiViewController
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    if (@available(iOS 13.0, *)) {
           
           self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
       }
    
    [self startinitView];
//   OpeningAnimaViewController *viewCon = [[OpeningAnimaViewController alloc]init];
//
//      self.window.rootViewController = viewCon;
}

- (void)startinitView
{
    LogReiViewController *viewController = [[LogReiViewController alloc]init];
       
       navController = [[UINavigationController alloc]initWithRootViewController:viewController];
       
       self.window.rootViewController = navController;
       
       
       NSDictionary *dic = [[GlobalObject shareObject] getUserAccountShare];
        if (!(dic == nil || [dic allKeys].count == 0)) {
            
            [GlobalObject shareObject].toKenSear = dic[@"token"];
            MainViewController *mainViewController = [[MainViewController alloc]init];
            [navController pushViewController:mainViewController animated:NO];
        }
}


- (void)popViewController
{
    UINavigationController *navVC = navController;
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    for (UIViewController *vc in [navVC viewControllers]) {
        
        [viewControllers addObject:vc];
        
        if ([vc isKindOfClass:[LogReiViewController class]]) {
            
            break;
        }
    }
    [navVC setViewControllers:viewControllers animated:YES];
}
 

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
       [JPUSHService removeNotification:nil];
       [JPUSHService setBadge:0];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    
//    if ([[userInfo allKeys] containsObject:@"aps"] &&
//        [[userInfo[@"aps"] allKeys] containsObject:@"alert"] &&
//        [userInfo[@"aps"][@"alert"] isKindOfClass:[NSString class]]  &&
//        [userInfo[@"aps"][@"alert"] containsString:@"歸還成功"]) {
//        //租借成功
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PushNotification" object:nil];
//    }
   
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
       [[NSNotificationCenter defaultCenter] postNotificationName:@"PushNotification" object:nil];
//    if ([[userInfo allKeys] containsObject:@"aps"] &&
//        [[userInfo[@"aps"] allKeys] containsObject:@"alert"] &&
//        [userInfo[@"aps"][@"alert"] isKindOfClass:[NSString class]] &&
//        [userInfo[@"aps"][@"alert"] containsString:@"歸還成功"]) {
//        //租借成功
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"RequestWallet" object:nil];
//    }
    
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/*创建加载*/
- (void)createActivityView
{
    if (activityView) {
        [activityView removeFromSuperview];
               activityView = nil;
    }
    if (!activityView) {
        activityView = [[ActivityView alloc]initWithFrame:MY_RECT(0, 0, IPHONE6SWIDTH, IPHONE6SHEIGHT)];
    }
    
    
     [self.window addSubview:activityView];
}

- (void)removeActivityView
{
    if (activityView) {
        [activityView removeFromSuperview];
        activityView = nil;
    }
}

- (void)addTopView:(UIView *)view
{
    [self.window addSubview:view];
}

- (void)showAlter:(NSString *)message bSucc:(BOOL)bSucc
{
    USerProWindow *view = [[USerProWindow alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    [self.window addSubview:view];
    
    
    view.bSucce = bSucc;
    view.strPro = message;
    //
    view.backgroundColor =[UIColor redColor];
    [view initUI];
}

@end
