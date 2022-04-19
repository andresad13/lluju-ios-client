//
//  ChargingRulesViewController.m
//  Tanc
//
//  Created by f on 2020/1/15.
//  Copyright © 2020 f. All rights reserved.
//

#import "ChargingRulesViewController.h"
#import "RechargeViewController.h"
#import "MainViewController.h"
#import "CustomerServiceView.h"
#import "BankCardCheckView.h"
#import <MercadoPagoSDK/MercadoPagoSDK.h>
#import <MercadoPagoSDK/MercadoPagoSDK-Swift.h>
#import <MercadoPagoSDK/MercadoPagoSDK-Swift.h>
#import <MercadoPagoSDK/MercadoPagoSDK.h>
//
#include <sys/time.h>
#import "DepositProView.h"
#import "RentalSucceViewController.h"
#import "AddCreditCardViewController.h"
#import "RechargeViewController.h"

@interface ChargingRulesViewController ()<AddCreditCardViewControllerDelegate,BankCardCheckViewDelegate,PXLifeCycleProtocol,DepositProViewDelegate>
{
    BOOL bStart_Pay;//是否开始支付
    BOOL bRequest;
    long long curTime;//记录当前时间
    int number;//记录次数
    NSTimer *timer;
    NSString *order_Id;
    NSString *curOrderID;
    NSString *payResultID;//支付需要用的
    
    NSString *paymentId;//支付方返回的
    
    NSString *slotNum;
    
    NSString *seleBankId;//银行卡 卡号
    
    NSArray *arrayBank;
    
    BOOL bInsufficienDeposit;//是否押金不足
}
@end

@implementation ChargingRulesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    paymentId = @"";
    
    [self initUI];
    
    [super setBtnGOHiddenNO];
    
    [self requestBank];
    //Do any additional setup after loading the view.
}

- (void)initUI
{
    
    CGRect rect = MY_RECT(0,0, IPHONE6SWIDTH, 134);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    rect.size.height = rect.size.width / IPHONE6SWIDTH * 134;
    UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageIcon];
    imageIcon.image = [UIImage imageNamed:@"Charging_rulesIcon"];
    
    rect = MY_RECT(14, 16, IPHONE6SWIDTH - 28, 200);
    rect.origin.y = rect.origin.y + imageIcon.frame.size.height + imageIcon.frame.origin.y;
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgr];
    viewBackgr.backgroundColor = [UIColor colorWithRed:248/255.0 green:255/255.0 blue:247/255.0 alpha:1.0];
    [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:5];
    
    rect = MY_RECT(16, 21, 250, 20);
    UILabel *labRules = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labRules];
    labRules.text = CurLanguageCon(@"Billing rules:");
    labRules.textColor = [UIColor blackColor];
    labRules.textAlignment = NSTextAlignmentLeft;
    labRules.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:18];
    
    NSArray *arrayTit = @[@"Pre-authorization",@"Free duration",@"Charge per hour",@"Day cap",@"Total cap",@"End order"];
    
    
    NSArray *arrayCon = @[[NSString stringWithFormat:@"%0d",[_dicM[@"yajin"] intValue]],
                          [NSString stringWithFormat:@"%dmin",[_dicM[@"freetime"] intValue]],
                          [NSString stringWithFormat:@"$%d",[_dicM[@"price"] intValue]],
                          [NSString stringWithFormat:@"$%d",[_dicM[@"fengding"] intValue]],
                          [NSString stringWithFormat:@"$%d",[_dicM[@"yajin"] intValue]],
    ];
    for (int i = 0; i < arrayTit.count; i ++) {
        
        rect = MY_RECT(16, 54 + 24 * i, 180, 14);
        UILabel *labTit = [[UILabel alloc]initWithFrame:rect];
        [viewBackgr addSubview:labTit];
        labTit.text = CurLanguageCon(arrayTit[i]);
        labTit.textColor = [UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1.0];
        labTit.textAlignment = NSTextAlignmentLeft;
        labTit.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
        
        if (i == 0) {
            
            //             floWid = [GlobalObject widthOfString:@"/h" font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13]];
            //                     rect = MY_RECT(345 - 18, 54 + 24 * i, 140, 14);
            //                     rect.size.width = floWid;
            //                     rect.origin.x = rect.origin.x - floWid;
            //                     UILabel *labunit = [[UILabel alloc]initWithFrame:rect];
            //                     [viewBackgr addSubview:labunit];
            //                     labunit.text = @"/h";
            //                     labunit.textColor = [UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1.0];
            //                     labunit.textAlignment = NSTextAlignmentRight;
            //                     labunit.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
            
            
            CGFloat floWid = [GlobalObject widthOfString:arrayCon[i] font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13]];
            rect = MY_RECT(345 - 18, 54 + 24 * i, 140, 14);
            rect.size.width = floWid;
            rect.origin.x = rect.origin.x - floWid;
            UILabel *labCon = [[UILabel alloc]initWithFrame:rect];
            [viewBackgr addSubview:labCon];
            labCon.text = arrayCon[i];
            labCon.textColor = [UIColor colorWithRed:242/255.0 green:59/255.0 blue:71/255.0 alpha:1.0];
            labCon.textAlignment = NSTextAlignmentRight;
            labCon.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
            
            rect = MY_RECT(345 - 18, 54 + 24 * i, 140, 14);
            rect.origin.x = labCon.frame.origin.x - rect.size.width;
            UILabel *labConSec = [[UILabel alloc]initWithFrame:rect];
            [viewBackgr addSubview:labConSec];
            labConSec.text = @"$";
            labConSec.textColor = [UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1.0];
            labConSec.textAlignment = NSTextAlignmentRight;
            labConSec.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
            
        }
        else if (i <= 4)
        {
            rect = MY_RECT(345 - 18, 54 + 24 * i, 140, 14);
            rect.origin.x = rect.origin.x - rect.size.width;
            UILabel *labCon = [[UILabel alloc]initWithFrame:rect];
            [viewBackgr addSubview:labCon];
            labCon.text =CurLanguageCon(arrayCon[i]);
            labCon.textColor = [UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1.0];
            labCon.textAlignment = NSTextAlignmentRight;
            labCon.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
        }
        
    }
    
    rect = MY_RECT(45, 598 - PhoneHeight, 285, 44);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    
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
    button.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    [button setTitle:[GlobalObject getCurLanguage:@"Agree and rent immediately"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // button.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
    // button.shadowOpacity(0.7).shadowColor([UIColor colorWithRed:253/255.0 green:89/255.0 blue:148/255.0 alpha:0.38]).shadowRadius(6).shadowOffset(CGSizeMake(0, 7)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createBankCardCheckView
{
    BankCardCheckView *view = [[BankCardCheckView alloc]initWithFrame:MY_RECT(0, 0, IPHONE6SWIDTH, IPHONE6SHEIGHT)];;
    [gAppDelegate addTopView:view];
    view.delegate = self;
    [view updateBankList:arrayBank strWall:_dicM[@"myyue"]];
}


- (void)createDepositProView:(BOOL)bDeposit mon:(NSString *)mon
{
    DepositProView *view = [[DepositProView alloc]initWithFrame:MY_RECT(0, 0, IPHONE6SWIDTH, IPHONE6SHEIGHT)];;
    [gAppDelegate addTopView:view];
    view.delegate = self;
    view.strMon = mon;
    view.bDeposit = bDeposit;
    
    [view updateUI];
}


#pragma mark --- click

- (void)click
{//充值
    //押金大于 d余额d》 0  余额大于
    bInsufficienDeposit = NO;
    int  isBorrow =  [_dicM[@"isBorrow"] intValue];
    if (isBorrow == 1) {
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"El banco de energía que alquiló no ha sido devuelto, devuelva primero el banco de energía"]  bSucc:NO];
    }
    else
    {
        [self createBankCardCheckView];
    }
    
    //    if (([_dicM[@"userAccountYajin"] intValue] >=[_dicM[@"yajin"] intValue] &&
    //         [_dicM[@"userAccountYajin"] intValue] > 0) ||([_dicM[@"myyue"] intValue] >= [_dicM[@"yajin"] intValue] &&
    //         [_dicM[@"myyue"] intValue] > 0)) {
    //       [self requestBorrow:@""];
    //    }
    //    else
    //    {
    
    //}
    
    
    //押金充足 余额充足。马上租借 。余额 必须大于d 押金才可以租借  银汉卡列表租借
    
    
    //
    
    
    //    if ([_dicM[@"zucount"] intValue] != 0) {
    //            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"You have already rented the power bank, please return the power bank first"]  bSucc:NO];
    //           return;
    //       }
    //
    //       //押金不对 需要下载订单号 余额不对 直接进入充值余额的界面
    //       if([_dicM[@"userAccoutMy"] floatValue] < 0)
    //       {//千万余额充值界面
    //           [self createDepositProView:NO mon:[NSString stringWithFormat:@"%f",[_dicM[@"userAccoutMy"] floatValue]]];
    //       }
    //       else
    //       {
    //           [self requestBorrow];
    //          // [self requestGetOrderid];
    //       }
    
    
    //    if ([_dicM[@"userAccountYajin"] intValue] < [_dicM[@"yajin"] intValue] && [_dicM[@"userAccountYajin"] intValue] <= 0)
    //          {//押金不变
    //              bInsufficienDeposit = YES;
    //              [self createDepositProView:!NO mon:[NSString stringWithFormat:@"%f",[_dicM[@"userAccountYajin"] floatValue]]];
    //          }
    //          else
}


-(void (^ _Nullable)(void))cancelCheckout {
    return ^ {
        [self.navigationController popViewControllerAnimated:YES];
        //[self.navigationController popToRootViewControllerAnimated:YES];
    };
}


- (void (^)(id<PXResult> _Nullable))finishCheckout {
    return ^ (id<PXResult> _Nullable result) {
        PXPayment *payment = (PXPayment *) result;
        NSLog(@"%@",[payment getStatus]);
        NSString *approved = [payment getStatus];
        NSString *getPaymentId = [payment getPaymentId];
        
        if ([approved isEqualToString:@"approved"]) {
            //已批准
            [self updateRecharge:getPaymentId];
        }
        else
        {
            
        }
        
    };
}

- (void)updateRecharge:(NSString *)payment_Id
{
    paymentId = payment_Id;
    
    
    [self updateDataPay:order_Id];
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    self.title = CurLanguageCon(@"Charging rules");
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];//进入前台
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];//今日后台
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rechargeSuccessfulLease) name:@"RechargeSuccessfulLease" object:nil];
    
    [super viewWillAppear:animated];
}

- (void)applicationBecomeActive
{
    if (bStart_Pay) {
        [gAppDelegate createActivityView];
        
        [self timingNumber];
    }
}

- (void)applicationEnterBackground
{
    if (bStart_Pay) {
        [gAppDelegate  removeActivityView];
    }
}


-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RechargeSuccessfulLease" object:nil];
    
    [super viewWillDisappear:animated];
    
}

- (void)rechargeSuccessfulLease
{
    [self requestBorrow:@""];
}

//立即租借
-(void)requestBorrow:(NSString *)bankID
{
    paymentId = @"";
    
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:[NSString stringWithFormat:@"/UserApp/Borrow/borrow"]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:_strCodeID forKey:@"id"];
    if (bankID && [bankID length] > 0) {
        [dic setValue:bankID forKey:@"cardId"];
    }
    
    [CLNetwork POST:str parameter:dic success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {//支付租借
            [weakSelf updatebayonetInt:responseObject[@"bayonetInt"]];
            [weakSelf UpdatePayResult:responseObject];
            // [weakSelf needDeposit:responseObject[@"payResult"] orderID:responseObject[@"orderID"]];
        }
        else  if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 2) {//余额充足 直接租借
            //租借成功的界面 需要调用 查询接口
            [weakSelf updatebayonetInt:responseObject[@"bayonetInt"]];
            [weakSelf updateDataPay:responseObject[@"orderID"]];
        }
        else
        {
            [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:NO];
        }
    } failure:^(NSError *error) {
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
}

- (void)updatebayonetInt:(NSString *)bayonetInt
{
    slotNum = [NSString stringWithFormat:@"%d",[bayonetInt intValue]];
}


- (void)UpdatePayResult:(NSDictionary *)dic
{
    paymentId = dic[@"payResult"];
    
    curTime = [[NSDate date] timeIntervalSince1970];
    
    order_Id = dic[@"orderID"];
    
    
    
    bStart_Pay = YES;
    
    [gAppDelegate createActivityView];
    
    [self requestRes];
    // orderID = dic[@"orderID"];
}


//- (void)needDeposit:(NSString *)jsonString orderID:(NSString *)orderID
//{
//    if (jsonString == nil) {
//           return ;
//       }
//       NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//       NSError *err;
//       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
//       if(err) {
//           NSLog(@"json解析失败：%@",err);
//           return ;
//       }
//    order_Id = orderID;
//    bInsufficienDeposit = YES;
//    payResultID = dic[@"id"];
//    [self createDepositProView:YES mon:[NSString stringWithFormat:@"%f",[self->_dicM[@"yajin"] floatValue]]];
//
//}

- (void)requestRes
{
    __weak __typeof(self) weakSelf = self;
    
    NSString *strType =  [NSString stringWithFormat:@"/UserApp/Borrow/BorrowFinish?orderId=%@&paymentId=%@",order_Id,paymentId];
    
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,strType];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        //0 1 2
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 2) {
            // 正在请求中
            [weakSelf updateDataUpOrder];
        }
        else if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {//租借成功
            [gAppDelegate  removeActivityView];
            [weakSelf updateRentalResults:!NO];
            self->bStart_Pay = NO;
            //
        }
        else
        {//租借失败
            [gAppDelegate  removeActivityView];
            self->bStart_Pay = NO;
            [ weakSelf updateRentalResults:NO];
            [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:NO];
        }
    } failure:^(NSError *error) {
        self->bStart_Pay = NO;
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"]  bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
}


- (void)requestBank
{//请求银行卡列表
    __weak __typeof(self) weakSelf = self;
    
    
    NSString *strType =  [NSString stringWithFormat:@"/pay/mercadopago/getCards/%@",[GlobalObject shareObject].userModel.openid];
    //https://cdb.lluju.com/pay/mercadopago/getCards/
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,strType];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        //0 1 2
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            // 正在请求中
            [weakSelf updateBankList:responseObject[@"data"][@"cards"]];
        }
        else
        {//租借失败
            // [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:NO];
        }
    } failure:^(NSError *error) {
        
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"]  bSucc:NO];
        
    }];
}

- (void)updateBankList:(NSArray *)array
{
    //   [GlobalObject judgeStringNil:array]
    arrayBank = array;
}


- (void)updateDataPay:(NSString *)orderId
{
    curTime = [[NSDate date] timeIntervalSince1970];
    order_Id = orderId;
    
    bStart_Pay = YES;
    
    [gAppDelegate createActivityView];
    
    [self requestRes];
}



- (void)updateDataUpOrder
{
    long long differenceTime = [[NSDate date] timeIntervalSince1970] - curTime;
    
    if (differenceTime > 5) {
        curTime =  [[NSDate date] timeIntervalSince1970];
        
        [self requestRes];
    }
    else
    {//开启定时
        timer = [NSTimer scheduledTimerWithTimeInterval:differenceTime target:self selector:@selector(timingNumber) userInfo:nil repeats:NO];
    }
}

- (void)timingNumber
{
    number ++;
    if (number > 10) {
        //进入失败界面去
        bStart_Pay = NO;
        number = 0;
        [gAppDelegate  removeActivityView];
        [self updateRentalResults:!YES];
    }
    else
        [self requestRes];
}

- (void)updateRentalResults:(BOOL)bSucc
{
    RentalSucceViewController *rentalSucceViewController = [[RentalSucceViewController alloc]init];
    rentalSucceViewController.bSuc = bSucc;
    
    rentalSucceViewController.strNumber = [NSString stringWithFormat:@"%d",[slotNum intValue]];
    if (bSucc) {
        [self moveSubViewAddNew:rentalSucceViewController];
    }
    else
        [self.navigationController pushViewController:rentalSucceViewController animated:YES];
    
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


- (void)recharge
{
    
    RechargeViewController  *viewController = [[RechargeViewController alloc]init];
    viewController.bChargin = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    
    // payResultID = @"502190411-a615ba92-862a-4429-8c20-3546d9affbd4";
    //    if (bInsufficienDeposit) {
    //        //发起充值
    //
    ////        MercadoPagoCheckoutBuilder * mp = [[MercadoPagoCheckoutBuilder alloc] initWithPublicKey:@"" preferenceId:@""];
    //        //@"APP_USR-1701a76a-89e1-40ad-9da6-a5ac6ef4e90e"
    //        //@"TEST-0cec2e72-de6a-43e6-b414-c238b553eba9"
    //        MercadoPagoCheckout *checkout  = [[MercadoPagoCheckout alloc] initWithBuilder:[[MercadoPagoCheckoutBuilder alloc] initWithPublicKey:@"APP_USR-1701a76a-89e1-40ad-9da6-a5ac6ef4e90e" preferenceId:payResultID]];
    //
    //        [checkout startWithNavigationController:self.navigationController lifeCycleProtocol:self];
    //
    //
    //       // PXPaymentData *ce = [[PXPaymentData alloc]init];
    //        // MercadoPago *mp = [[MercadoPago alloc] initWithPublicKey:@"444a9ef5-8a6b-429f-abdf-587639155d88"];
    ////            Identification *identification = [[Identification alloc] init];
    ////            identification.type = @"DNI";
    ////            identification.number = @"12345678";
    ////
    ////            Cardholder *cardholder = [[Cardholder alloc] init];
    ////            cardholder.identification = identification;
    ////            cardholder.name = @"APRO";
    ////
    ////            CardToken *cardToken = [[CardToken alloc] initWithCardNumber:@"4170068810108020" expirationMonth:10 expirationYear:15 securityCode:@"123" cardholderName:@"APRO" docType:@"DNI" docNumber:@"12345678"];
    ////
    ////            [mp createNewCardToken:cardToken success: ^(Token *t) {
    ////                NSLog(@"TOKEN %@", t._id);
    ////            } failure: ^(NSError *e) {
    ////                NSLog(@"ERROR");
    ////            }];
    //
    //
    //    }
    //    else
    //    {//待看
    //
    //    }
}

- (void)addBankID:(NSString *)bankI_d
{
    [self requestBorrow:bankI_d];
}

#pragma mark ---BankCardCheckViewDelegate
- (void)addOtherBank
{//添加银行卡的界面
    
    AddCreditCardViewController *addCreditCardViewController = [[AddCreditCardViewController alloc]init];
    addCreditCardViewController.delegate =self;
    addCreditCardViewController.addCareditCardType = 2;
    [self.navigationController pushViewController:addCreditCardViewController animated:YES];
}

- (void)seleBankPay:(NSString *)bankID
{
    //
    [self requestBorrow:bankID];
}

- (void)seleBalancePay
{//选择余额支付
    if([_dicM[@"myyue"] floatValue] < [_dicM[@"yajin"] floatValue])
    {//出现提示框
        [self createDepositProView:!NO mon:_dicM[@"myyue"]];
    }
    else  if ([_dicM[@"myyue"] intValue] >= [_dicM[@"yajin"] intValue] &&
              [_dicM[@"myyue"] intValue] > 0)
    {
        [self requestBorrow:@""];
    }
    else
    {//前往充值界面
        RechargeViewController *viewController = [[RechargeViewController alloc]init];
        viewController.bChargin = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}//选择余额支付

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
