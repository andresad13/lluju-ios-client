//
//  UserAgreViewController.m
//  Tanc
//
//  Created by f on 2019/12/9.
//  Copyright © 2019 f. All rights reserved.
//

#import "UserAgreViewController.h"
#import <WebKit/WebKit.h>
@interface UserAgreViewController () 
{
      WKWebView *webView;
}
@end

@implementation UserAgreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    [self initUI];
     
     [super setBtnGOHiddenNO];
    [self request];
    
    // Do any additional setup after loading the view.
}

- (NSString *)getTitle
{
    if ([_strType isEqualToString:@"UserApp/More/agreement"]) {
        return CurLanguageCon(@"User Agreement");
    }
   
    return CurLanguageCon(@"Privacy Agreement");
}

- (void)initUI
{
    CGRect rect = MY_RECT(10, 100, IPHONE6SWIDTH - 20, IPHONE6SHEIGHT - 100);
    webView = [[WKWebView alloc]initWithFrame:rect];
    [self.view addSubview:webView];
    [webView setOpaque:NO];
    
}

- (void)request
{
    ///more/user/agreement

    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"%@/%@",ChargingApi,_strType];
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            [ weakSelf updateData:responseObject[@"data"]];
        }
        else
        {
            // [ weakSelf updateData:@[]];
             [gAppDelegate showAlter:responseObject[@"msg"] bSucc:NO];
        }
    } failure:^(NSError *error) {
       
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
}

- (void)updateData:(NSString *)str
{
  //  textView.text = str;
    //测试
 
//    NSString *fontSizeStr = @"document.getElementsByTagName('section')[0].style.fontSize='35px';";
//         [webView stringByEvaluatingJavaScriptFromString:fontSizeStr];
  
         NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-size:14px;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>"
                            "<script type='text/javascript'>"
                            "window.onload = function(){\n"
                            "var $img = document.getElementsByTagName('img');\n"
                            "for(var p in  $img){\n"
                            " $img[p].style.width = '100%%';\n"
                            "$img[p].style.height ='auto'\n"
                            "}\n"
                            "}"
                            "</script>%@"
                            "</body>"
                            "</html>",str];
         [webView loadHTMLString:htmls baseURL:nil];
         webView.backgroundColor = [UIColor clearColor];
           webView.scrollView.backgroundColor = [UIColor clearColor];
}

 

-(void)viewWillAppear:(BOOL)animated
{
    self.title = [self getTitle];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    //设置文字颜色 大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],NSFontAttributeName : [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16]}];
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor clearColor] image:nil isOpaque:YES];//颜色
    [self.navigationController.navigationBar navBarAlpha:0 isOpaque:NO];//透明度 如果设置了透明度 所以导航栏会隐藏
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];//隐藏底线
    //[self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    if (@available(iOS 13.0, *)) {
           [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDarkContent;//黑色
            //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
       } else {
            //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
             [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色
           // Fallback on earlier versions
       }
    [super viewWillAppear:animated];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
