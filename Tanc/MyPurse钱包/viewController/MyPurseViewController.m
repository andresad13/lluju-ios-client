//
//  MyPurseViewController.m
//  Tanc
//
//  Created by f on 2019/12/11.
//  Copyright © 2019 f. All rights reserved.
//

#import "MyPurseViewController.h"
#import "RechargeViewController.h"
#import "TransDetaiViewController.h"
#import "RechargeResultViewController.h"
#import "MainViewController.h"
#import "CreditCardViewController.h"

@interface MyPurseViewController ()
{
    UILabel *labdeposit;
      UILabel *labUserMon;
}
@end

@implementation MyPurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
     
    [self initUI];
    
    
     [super setBtnGOHiddenNO];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    
    CGRect rect = MY_RECT(0, 129 - PhoneHeight, 199, 159);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    rect.size.width = rect.size.height / 159.0 * 199;
    rect.origin.x = (WIDTH - rect.size.width) / 2.0;
    UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageIcon];
    imageIcon.image = [UIImage imageNamed:@"myPurse_Icon"];
  
    NSArray *array = @[[GlobalObject getCurLanguage:@"Account Balance"],[@"$ " stringByAppendingString:[GlobalObject shareObject].userModel.wallet]];
    for (int i = 0; i < array.count; i ++) {
        
        rect = MY_RECT(0, 319 + 25 * i, IPHONE6SWIDTH, 16);
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [self.view addSubview:lab];
        lab.textColor = [UIColor colorWithRed:23/255.0 green:31/255.0 blue:36/255.0 alpha:1.0];
        lab.text = array[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = i == 0 ? [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13] : [GlobalObject getAvenirFontEnumType:Avenir_Black fontSize:20];
   
     labUserMon = i == 1 ? lab : labUserMon;
    
    }
    
    rect = MY_RECT(100.5, 415, 174, 39);
    UIView *viewBtnBackgr = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBtnBackgr];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:0x93/255.0 green:0xc1/255.0 blue:0x5f/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0x63/255.0 green:0xb1/255.0 blue:0x5e/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    
    [viewBtnBackgr.layer addSublayer:gl];
    [viewBtnBackgr qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
     
    UIButton *button = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:button];
    [button setTitle:[GlobalObject getCurLanguage:@"Recharge"] forState:UIControlStateNormal];
     [button addTarget:self action:@selector(clickRecharge) forControlEvents:UIControlEventTouchUpInside];
   
    ;
  array = @[@"DepositPurse",@"creditCardPurse",@"TransactionDetailsPurse",
                @"Pre-authorization：",@"credit card",@"Transaction details"];
      for (int i = 0; i < 3; i ++) {
          
          rect = MY_RECT(61 + (83 + 26) * i, 587, 26, 26);
          rect.size.width = rect.size.height;
          UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:rect];
          [self.view addSubview:imageIcon];
          imageIcon.image = [UIImage imageNamed:array[i]];
          
        //  imageIcon.hidden = i == 1 ? YES :NO;
          
          rect =  MY_RECT( 0, 622, 150, 14);
          UILabel *lab = [[UILabel alloc]initWithFrame:rect];
          [self.view addSubview:lab];
          lab.textAlignment = NSTextAlignmentCenter;
          lab.textColor = [UIColor colorWithRed:11/255.0 green:11/255.0 blue:11/255.0 alpha:1.0];
          lab.text = [GlobalObject getCurLanguage:array[i + 3]];
          lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10];
          lab.center = CGPointMake(imageIcon.center.x, lab.center.y);
          
          //lab.hidden = i == 1 ? YES :NO;
     
          
          if (i == 0) {
              rect =  MY_RECT( 0, 635, 100, 8);
              UILabel *labS = [[UILabel alloc]initWithFrame:rect];
              [self.view addSubview:labS];
              labS.textAlignment = NSTextAlignmentCenter;
              labS.textColor = [UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:1.0];
              labS.text = [NSString stringWithFormat:@"$%0.1f",[[GlobalObject shareObject].userModel.defaultAccount floatValue]];
              labS.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:9];
              labS.center = CGPointMake(imageIcon.center.x, labS.center.y);
              labdeposit =labS;
          }
          
          rect = MY_RECT(IPHONE6SWIDTH / 3.0 * i, 587, IPHONE6SWIDTH / 3.0, 50);
          UIButton *button = [[UIButton alloc]initWithFrame:rect];
          [self.view addSubview:button];
          [button addTarget:self action:@selector(clickMon:) forControlEvents:UIControlEventTouchUpInside];
          button.tag = i + 200;
      }
    
}

#pragma mark ---click

- (void)clickMon:(UIButton *)button
{
    NSInteger tag = button.tag - 200;
    if (tag == 0) {
        //押金 提现
        //判断 余额 假设余额小于 0 d那么需要先减去余额
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[GlobalObject getCurLanguage:@"prompt"] message:[GlobalObject getCurLanguage:@"Are you sure you want to withdraw the deposit?"] preferredStyle:UIAlertControllerStyleAlert];
                       
                       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"cancel"] style:UIAlertActionStyleCancel handler:nil];
                       UIAlertAction *okAction = [UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"determine"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                           [self requestWithdraw];
                           
                       }];
                        
                       [alertController addAction:cancelAction];
                       [alertController addAction:okAction];
                       [self presentViewController:alertController animated:YES completion:nil];
    }
    else if(tag == 1)
    {
        [self.navigationController pushViewController:[CreditCardViewController new] animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:[TransDetaiViewController new] animated:YES];
    }
    
}

- (void)clickTopRight
{
     [self.navigationController pushViewController:[TransDetaiViewController new] animated:YES];
} 

- (void)clickRecharge
{
    [self.navigationController pushViewController:[RechargeViewController new] animated:YES];
}


- (void)requestWithdraw
{
     [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    
    NSString *strType =  [NSString stringWithFormat:@"/UserApp/User/refund"];
    
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,strType];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        //0 1 2
         if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {//支付成功
            [gAppDelegate  removeActivityView];
            
             [weakSelf createRechargeResultViewController:YES buyId:responseObject[@"data"]];
            
        }
        else
        {//租借失败
            [gAppDelegate  removeActivityView];
            [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:NO];
            
             [weakSelf createRechargeResultViewController:!YES buyId:@""];
             
        }
    } failure:^(NSError *error) {
       
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"]  bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
}

- (void)createRechargeResultViewController:(BOOL)bSucc buyId:(NSString *)buyID
{
    NSString *strAddTime = [self getTodayDate];
    NSDictionary *dic = @{@"id":[NSString stringWithFormat:@"%d",[buyID intValue]],@"addTime":strAddTime};
    RechargeResultViewController *viewController = [[RechargeResultViewController alloc]init];
    viewController.bSucces = bSucc;
    viewController.bBuy= !YES;
    viewController.dic = dic;
    viewController.bWithdraw =  YES;
    viewController.strTime = [self getTodayDate];
    [self moveSubViewAddNew:viewController];
    //[self.navigationController pushViewController:viewController animated:YES];
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

- (NSString *)getTodayDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [forMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [forMatter stringFromDate:date];
    return dateStr;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.title = [GlobalObject getCurLanguage:@"My purse"];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //设置文字颜色 大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16]}];
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor clearColor] image:nil isOpaque:YES];//颜色
    [self.navigationController.navigationBar navBarAlpha:0 isOpaque:NO];//透明度 如果设置了透明度 所以导航栏会隐藏
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];//隐藏底线
 
    
    [self.navigationController setNavigationBarHidden:NO];
     
    [self updateUI];
    
    [super viewWillAppear:animated];
}


- (void)updateUI
{
    labUserMon.text = [@"$ " stringByAppendingString:[GlobalObject shareObject].userModel.wallet];
      labdeposit.text =  [NSString stringWithFormat:@"$%0.1f",[[GlobalObject shareObject].userModel.defaultAccount floatValue]]; ;
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
