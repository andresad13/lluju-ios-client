//
//  RechargeResultViewController.m
//  Tanc
//
//  Created by f on 2020/1/14.
//  Copyright © 2020 f. All rights reserved.
//

#import "RechargeResultViewController.h"
#import "BillingDetailsViewController.h"

@interface RechargeResultViewController ()

@end

@implementation RechargeResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = CurLanguageCon(@"Recharge successful");
    self.title = !_bSucces ? [GlobalObject getCurLanguage:@"Recharge failed"] :self.title;
    if (_bWithdraw) {
        self.title = !_bSucces ? [GlobalObject getCurLanguage:@"Withdrawal failed"] :[GlobalObject getCurLanguage:@"Withdrawal success"];
    }
    if (_bBuy) {
        self.title =  _bSucces ? [GlobalObject getCurLanguage:@"Successful purchase"] :[GlobalObject getCurLanguage:@"Failed purchase"];
        [self initBuyUI];
    }
    else
        [self initUI];
    
     [super setBtnGOHiddenNO];
    // Do any additional setup after loading the view.
}

- (void)initBuyUI
{
    CGRect rect = MY_RECT(0, 173, 61, 61);
    rect.size.width = rect.size.height;
    rect.origin.x = (WIDTH - rect.size.width) / 2.0;
    UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageIcon];
    imageIcon.image = _bSucces ? [UIImage imageNamed:@"RechargeSuccessful"] :  [UIImage imageNamed:@"RechargeFailed"];
    
    
    NSString *str = _bSucces  ? [GlobalObject getCurLanguage:@"Successful purchase"] :[GlobalObject getCurLanguage:@"Sorry, your purchase application failed"];
    rect = MY_RECT(10, 288, IPHONE6SWIDTH - 20, 18);
    rect.size.height = [GlobalObject getStringHeightWithText:str font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16] viewWidth:rect.size.width];
    UILabel *labTit = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labTit];
    labTit.textAlignment = NSTextAlignmentCenter;
    labTit.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
    labTit.textColor = [UIColor blackColor];
    labTit.text = str;
    labTit.numberOfLines = 0;
    
    str = _bSucces  ? _dic[@"addTime"]:[GlobalObject getCurLanguage:@"If in doubt, please contact online customer service"];
    rect = MY_RECT(10, 10, IPHONE6SWIDTH - 20, 15);
    rect.origin.y = rect.origin.y + labTit.frame.origin.y + CGRectGetHeight(labTit.frame);
     rect.size.height = [GlobalObject getStringHeightWithText:str font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13] viewWidth:rect.size.width];
    
    UILabel *labTime = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labTime];
    labTime.textAlignment = NSTextAlignmentCenter;
    labTime.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
    labTime.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    labTime.text = str;
    labTime.numberOfLines = 0;
    
    str = _bSucces  ? [GlobalObject getCurLanguage:@"check order"]:[GlobalObject getCurLanguage:@"Customer service"];
    rect = MY_RECT(72.5, 408, 230, 46);
    
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
    [button setTitle:str forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
//    [button qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
}

- (void)initUI
{
    CGRect rect = MY_RECT(0, 173, 61, 61);
    rect.size.width = rect.size.height;
    rect.origin.x = (WIDTH - rect.size.width) / 2.0;
    UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageIcon];
    imageIcon.image = _bSucces ? [UIImage imageNamed:@"RechargeSuccessful"] :  [UIImage imageNamed:@"RechargeFailed"];
    
    if (!_bWithdraw) {
        [self withdrawalUI];
    }
    else
    {
        [self rechUI];
    }
    
    NSString * str = _bSucces  ? [GlobalObject getCurLanguage:@"Billing details"]:[GlobalObject getCurLanguage:@"Customer service"];
    rect = MY_RECT(72.5, 408, 230, 46);
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
    
    
    UIButton *buttonDet = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonDet];
    [buttonDet setTitle:[GlobalObject getCurLanguage:str] forState:UIControlStateNormal];
    
    [buttonDet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonDet.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
    [buttonDet addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)withdrawalUI
{
    //Recharge successful
    NSString *str = _bSucces  ? [GlobalObject getCurLanguage:@"Recharge successful"] :[GlobalObject getCurLanguage:@"Sorry, your withdrawal request failed"];
  
    CGRect  rect = MY_RECT(10, 288, IPHONE6SWIDTH - 20, 18);
    rect.size.height = [GlobalObject getStringHeightWithText:str font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16] viewWidth:rect.size.width];
    UILabel *labTit = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labTit];
    labTit.textAlignment = NSTextAlignmentCenter;
    labTit.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
    labTit.textColor = [UIColor blackColor];
    labTit.text = str;
    labTit.numberOfLines = 0;
    
    
    str = _bSucces  ? _dic[@"addTime"]:[GlobalObject getCurLanguage:@"If in doubt, please contact online customer service"];
    rect = MY_RECT(10, 10, IPHONE6SWIDTH-20, 15);
    rect.size.height = [GlobalObject getStringHeightWithText:str font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13] viewWidth:rect.size.width];
    rect.origin.y = labTit.frame.origin.y + labTit.frame.size.height + 6;
    UILabel *labTime = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labTime];
    labTime.textAlignment = NSTextAlignmentCenter;
    labTime.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
    labTime.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    labTime.text = str;
    labTime.numberOfLines = 0;
}

- (void)rechUI
{
    //Recharge successful
    NSString *str = _bSucces ? [GlobalObject getCurLanguage:@"Recharge successful"] :[GlobalObject getCurLanguage:@"Sorry, your balance failed to recharge"];
    CGRect rect = MY_RECT(10, 288, IPHONE6SWIDTH - 20, 18);
    rect.size.height = [GlobalObject getStringHeightWithText:str font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16] viewWidth:rect.size.width];
    UILabel *labTit = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labTit];
    labTit.textAlignment = NSTextAlignmentCenter;
    labTit.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
    labTit.textColor = [UIColor blackColor];
    labTit.text = str;
    labTit.numberOfLines = 0;
    
    
    str = _bSucces  ? _dic[@"addTime"]:[GlobalObject getCurLanguage:@"If in doubt, please contact online customer service"];
    rect = MY_RECT(10, 10, IPHONE6SWIDTH - 20, 15);
    rect.size.height = [GlobalObject getStringHeightWithText:str font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13] viewWidth:rect.size.width];
    rect.origin.y = rect.origin.y + labTit.frame.origin.y + CGRectGetHeight(labTit.frame);
    UILabel *labTime = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labTime];
    labTime.textAlignment = NSTextAlignmentCenter;
    labTime.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
    labTime.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    labTime.text = str;
    labTime.numberOfLines = 0;
}


- (void)click
{
    if (_bSucces) {
        //租借成功 订单详情
        BillingDetailsViewController *viewController = [[BillingDetailsViewController alloc]init];
        viewController.bill_id = _dic[@"id"];
        viewController.curSeleType = _bBuy || _bWithdraw ? 1 : 0;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {//联系客服
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[GlobalObject shareObject].serviceCus[@"tel"]]] options:@{} completionHandler:^(BOOL success) {
            
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
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
