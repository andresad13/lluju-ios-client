//
//  UseTutorialViewController.m
//  Tanc
//
//  Created by f on 2019/12/10.
//  Copyright © 2019 f. All rights reserved.
//

#import "UseTutorialViewController.h"

@interface UseTutorialViewController ()

@end

@implementation UseTutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    [self initUI];
    
     [super setBtnGOHiddenNO];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    CGRect rect = MY_RECT(0, PhoneHeight, IPHONE6SWIDTH, 90);
    rect.origin.y =  GetRectNavAndStatusHight;
    rect.size.height = HEIGHT - GetRectNavAndStatusHight;
    UIScrollView *scrollview =[[UIScrollView alloc]initWithFrame:rect];
    [self.view addSubview:scrollview];
    scrollview.backgroundColor = [UIColor clearColor];
    

    rect = MY_RECT(0, 0, IPHONE6SWIDTH, 0);
    rect.size.height = rect.size.width / 375.0 * 820;
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:rect];
    [scrollview addSubview:imageView];
    imageView.image =[UIImage imageNamed:@"UseTutorial"];
    
    rect.size.height = rect.size.height  + 60;
    scrollview.contentSize = CGSizeMake(WIDTH, rect.size.height);
}


-(void)viewWillAppear:(BOOL)animated
{
    self.title = CurLanguageCon(@"Use tutorial");
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
