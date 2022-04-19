//
//  RentalSucceViewController.m
//  Tanc
//
//  Created by f on 2020/1/15.
//  Copyright © 2020 f. All rights reserved.
//

#import "RentalSucceViewController.h"
#import "MainViewController.h"
#import "NearbybusinViewController.h"
#import "OrderViewController.h"

@interface RentalSucceViewController ()

@end

@implementation RentalSucceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
   
     [super setBtnGOHiddenNO];
    
    self.title = _bSuc ? [GlobalObject getCurLanguage:@"Rental success"] : [GlobalObject getCurLanguage:@"Lease failed"];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    CGRect rect = MY_RECT(41, 123, 292, 203);
    rect.size.height = rect.size.width / 292.0 * 203;
    UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageIcon];
    imageIcon.image = _bSuc ? [UIImage imageNamed:@"Rental_success"] : [UIImage imageNamed:@"Lease_failed"];

       NSString *strrr =  _bSuc ? [GlobalObject getCurLanguage:@"Charging treasure pops up successfully"] : [GlobalObject getCurLanguage:@"Charging treasure failed to eject"];
    rect = MY_RECT(20, 362, IPHONE6SWIDTH - 40 * 2, 49);
    rect.size.height = [GlobalObject getStringHeightWithText:strrr font:[GlobalObject getAvenirFontEnumType:Avenir_Black fontSize:21] viewWidth:rect.size.width];
    UILabel *labPro = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labPro];
    labPro.numberOfLines = 0;
    labPro.text = strrr;//_bSuc ? [GlobalObject getCurLanguage:@"Charging treasure pops up successfully"] : [GlobalObject getCurLanguage:@"Charging treasure failed to eject"];
    labPro.font = [GlobalObject getAvenirFontEnumType:Avenir_Black fontSize:21];
    labPro.textColor = [UIColor blackColor];
    labPro.textAlignment = NSTextAlignmentCenter;
    
    //Please remove the No.5battery, if you have any questions, please contact customer service
    
    NSString *str  = _bSuc ?[NSString stringWithFormat:[GlobalObject getCurLanguage:@"Please remove the No.%@battery, if you have any questions, please contact customer service"],_strNumber] : CurLanguageCon(@"Sorry, the device cannot connect to the network. Please find other nearby  businesses or contact customer service.");
    
    rect = MY_RECT(80, 421, IPHONE6SWIDTH - 80 * 2, 72);
    rect.size.height = [GlobalObject getStringHeightWithText:str font:[GlobalObject getAvenirFontEnumType:Avenir_Black fontSize:12] viewWidth:rect.size.width];
    UILabel *labFile = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labFile];
    labFile.numberOfLines = 0;//测试
    labFile.text = str;
    
    labFile.font = [GlobalObject getAvenirFontEnumType:Avenir_Black fontSize:12];
    labFile.textColor = [UIColor blackColor];
    labFile.textAlignment = NSTextAlignmentCenter;
    
     
   str = _bSuc ? @"Order details":@"Nearby businesses";
 
  rect = MY_RECT(42, 491, 285, 44);
       
    
    UIView *viewBtnBackgr = [[UIView alloc]initWithFrame:rect];
      [self.view addSubview:viewBtnBackgr];
      
      CAGradientLayer *gl = [CAGradientLayer layer];
      gl.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
      gl.startPoint = CGPointMake(0, 0);
      gl.endPoint = CGPointMake(1, 1);
      gl.colors = @[(__bridge id)[UIColor colorWithRed:0x93/255.0 green:0xc1/255.0 blue:0x5f/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0x63/255.0 green:0xb1/255.0 blue:0x5e/255.0 alpha:1.0].CGColor];
      gl.locations = @[@(0.0),@(1.0)];
      
      [viewBtnBackgr.layer addSublayer:gl];
      viewBtnBackgr.shadowOpacity(0.7).shadowColor((UIColor *)[UIColor colorWithRed:99/255.0 green:177/255.0 blue:94/255.0 alpha:1.0]).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    
        UIButton *button = [[UIButton alloc]initWithFrame:rect];
        [self.view addSubview:button];
        [button setTitle:[GlobalObject getCurLanguage:str] forState:UIControlStateNormal];
        button.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
//        button.backgroundColor = [UIColor clearColor];
//        button.titleLabel.numberOfLines = 0;
//        button.layer.cornerRadius = rect.size.height /2.0;
//        button.layer.borderWidth = 1;
//        button.layer.borderColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0].CGColor;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
      
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
   // }
                                                           
}

- (void)click:(UIButton *)btn
{
    if (_bSuc) {
        OrderViewController *viewController =[[OrderViewController alloc]init];
                   
        [self moveSubViewAddNew:viewController];
    }
    else
    {
        NearbybusinViewController *viewController =[[NearbybusinViewController alloc]init];
                 
        [self moveSubViewAddNew:viewController];
    }
    return; 
}

- (void)moveSubView:(BOOL)bAnimation
{
    UINavigationController *navVC = self.navigationController;
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    for (UIViewController *vc in [navVC viewControllers]) {
        
        [viewControllers addObject:vc];
        
        if ([vc isKindOfClass:[MainViewController class]]) {
            
            break;
        }
    }
//    [viewControllers addObject:[NearbybusinViewController new]];
    [navVC setViewControllers:viewControllers animated:bAnimation];
}

- (void)moveSubViewAddNew:(UIViewController *)viewControlle
{
    UINavigationController *navVC = self.navigationController;
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    for (UIViewController *vc in [navVC viewControllers]) {
        
        [viewControllers addObject:vc];
        
        if ([vc isKindOfClass:[MainViewController class]]) {
            
            break;
        }
    }
    [viewControllers addObject:viewControlle];
    [navVC setViewControllers:viewControllers animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
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
