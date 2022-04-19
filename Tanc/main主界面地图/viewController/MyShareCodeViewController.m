//
//  MyShareCodeViewController.m
//  Tanc
//
//  Created by f on 2019/12/7.
//  Copyright © 2019 f. All rights reserved.
//

#import "MyShareCodeViewController.h"
#import "SGQRCodeGenerateManager.h"

@interface MyShareCodeViewController ()

@end

@implementation MyShareCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:244.0 / 255.0 green:83 / 255.0 blue:69 / 255.0 alpha:1];
    
    [self initUI];
    
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    CGRect rect = MY_RECT(18, 77 - PhoneHeight, IPHONE6SWIDTH - 18 * 2, 517);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    
    UIView *viewShadow = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewShadow];
    viewShadow.backgroundColor = [UIColor whiteColor];
    viewShadow.shadowOpacity(0.7).shadowColor((UIColor *)[UIColor colorWithRed:82 / 255.0 green:0x0b / 255.0 blue:0 alpha:1]).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(6).conrnerCorner(UIRectCornerAllCorners).showVisual();
    
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    viewBackgr.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewBackgr];
    
    for (int i = 0; i < 2; i ++) {
        
        rect = MY_RECT(0, 77 - PhoneHeight + 517 / 2.0, 18 * 2, 18 * 2);
        rect.size.height = rect.size.width;
        rect.origin.x = i == 1 ? WIDTH - rect.size.width : 0;
        rect.origin.y = rect.origin.y + GetRectNavAndStatusHight - rect.size.height;
        UIView *view = [[UIView alloc]initWithFrame:rect];
        [self.view addSubview:view];
        view.backgroundColor = [UIColor colorWithRed:244.0 / 255.0 green:83 / 255.0 blue:69 / 255.0 alpha:1];
        [view qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    }
    
    
    rect = MY_RECT(0, 55, IPHONE6SWIDTH - 18 * 2, 19);
    UILabel *labTit = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labTit];
    labTit.text = CurLanguageCon(@"My invitation code");
    labTit.textColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
    labTit.textAlignment = NSTextAlignmentCenter;
    labTit.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:18];
    
    rect = MY_RECT(0, 98, IPHONE6SWIDTH - 18 * 2, 28);
    UILabel *labCode = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labCode];
    labCode.text = @"12345";
    labCode.textColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
    labCode.textAlignment = NSTextAlignmentCenter;
    labCode.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:36];
    
    rect = MY_RECT((IPHONE6SWIDTH - 18 * 2 - 92) / 2.0, 156, 92, 34);
    UIButton *buttonCopy = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonCopy];
    [buttonCopy setTitle:[GlobalObject getCurLanguage:@"cpoy"] forState:UIControlStateNormal];
    buttonCopy.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14];
    [buttonCopy setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    buttonCopy.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
    [buttonCopy qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    
    
    NSArray *array = @[@"Copy the invitation code and invite more friends",@"to join us. The shared person will use the share",@"code to register and recharge the first account",@"balance successfully. The sharer and the shared",@"person can get a reward of"];
    
    CGFloat floY = 219 / IPHONE6SHEIGHT * HEIGHT;
    for (int i = 0; i < array.count; i ++)
    {
        rect = MY_RECT((IPHONE6SWIDTH - 18 * 2 - 250) / 2.0, 219, 250, 14);
        rect.origin.y = floY;
        UILabel *labText = [[UILabel alloc]initWithFrame:rect];
        [viewBackgr addSubview:labText];
        labText.text = CurLanguageCon(array[i]);
        labText.textColor = [UIColor blackColor];
        labText.textAlignment = NSTextAlignmentCenter;
        labText.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:11];
        
        if (i == array.count - 1) {
            //[GlobalObject shareObject].userModel.
            NSString *strMon = [NSString stringWithFormat:@"%@ %d",[GlobalObject getCurLanguage:@"$"],20];
            rect.size.width = [GlobalObject widthOfString:labText.text font:labText.font];
            labText.frame  = rect;
            
            rect.origin.x = rect.origin.x + rect.size.width + 3;
            rect.size.width = [GlobalObject widthOfString:strMon font:labText.font];
            UILabel *labTextMon = [[UILabel alloc]initWithFrame:rect];
            [viewBackgr addSubview:labTextMon];
            labTextMon.text = strMon;
            labTextMon.textColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
            labTextMon.textAlignment = NSTextAlignmentCenter;
            labTextMon.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:11];
            
            rect.origin.x = rect.origin.x + rect.size.width + 3;
            rect.size.width = [GlobalObject widthOfString:[GlobalObject getCurLanguage:@"at the same"] font:labText.font];
            UILabel *labTextSec = [[UILabel alloc]initWithFrame:rect];
            [viewBackgr addSubview:labTextSec];
            labTextSec.text = CurLanguageCon(@"at the same");
            labTextSec.textColor = [UIColor blackColor];
            labTextSec.textAlignment = NSTextAlignmentCenter;
            labTextSec.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:11];
            
            floY = floY + 14 / IPHONE6SHEIGHT * HEIGHT;
            rect.origin.x = labText.frame.origin.x;
            rect.origin.y = floY;
            rect.size.width =  250 / IPHONE6SWIDTH * WIDTH;
            UILabel *labTextTh = [[UILabel alloc]initWithFrame:rect];
            [viewBackgr addSubview:labTextTh];
            labTextTh.text = CurLanguageCon(@"time.");
            labTextTh.textColor = [UIColor blackColor];
            labTextTh.textAlignment = NSTextAlignmentCenter;
            labTextTh.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:11];
        }
        floY = floY + 14 / IPHONE6SHEIGHT * HEIGHT;
    }
    
    rect = MY_RECT(IPHONE6SWIDTH - 18 * 2 , 324, 90, 90);
    rect.size.width = rect.size.height;
    rect.origin.x = (rect.origin.x - rect.size.width) / 2.0;
    UIImageView *imageCode = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgr addSubview:imageCode];
//    [imageCode sd_setImageWithURL:[NSURL URLWithString:[GlobalObject shareObject].userModel.appQrCode]];
    
     imageCode.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:[GlobalObject shareObject].userModel.appQrCode logoImageName:@"" logoScaleToSuperView:0.2];
    // imageCode.backgroundColor = [UIColor yellowColor];
    
    rect = MY_RECT(0, 445, IPHONE6SWIDTH - 18 * 2, 12);
    UILabel *labScan = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labScan];
    labScan.text = CurLanguageCon(@"Scan code download APP");
    labScan.textColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:25/255.0 alpha:1.0];
    labScan.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14];
    labScan.textAlignment = NSTextAlignmentCenter;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.title = [GlobalObject getCurLanguage:@"My share code"];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //设置文字颜色 大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16]}];
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor clearColor] image:nil isOpaque:YES];//颜色
    [self.navigationController.navigationBar navBarAlpha:0 isOpaque:NO];//透明度 如果设置了透明度 所以导航栏会隐藏
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];//隐藏底线
    //[self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    if (@available(iOS 13.0, *)) {
           //[UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDarkContent;//黑色
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
       } else {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
             //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色
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
