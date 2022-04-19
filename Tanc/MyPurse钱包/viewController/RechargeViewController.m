//
//  RechargeViewController.m
//  Tanc
//
//  Created by f on 2019/12/11.
//  Copyright © 2019 f. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeResultViewController.h"
#import <MercadoPagoSDK/MercadoPagoSDK.h>
#import <MercadoPagoSDK/MercadoPagoSDK-Swift.h>
#import "AddCreditCardViewController.h"

#define RechargeTag 300

@interface RechargeViewController ()<PXLifeCycleProtocol,AddCreditCardViewControllerDelegate>
{
    NSMutableArray *mutArray;
    NSMutableArray *mutImageButton;
    NSMutableArray *mutBankId;
    
    NSMutableArray *mutSeleButton;
    NSArray *arrayCurMon;
    UILabel *labSeleMon;
    CGFloat CurfloY;
    
    
    NSString *seleBankCardID;
    
    NSInteger curSeleBank;
    NSInteger curSeleBankMon;
     
    NSInteger curSeleBankList;//选择的银行卡列表
    
    UIScrollView *scrollView;
    
    NSString *dataId;//
    NSString *rechargeId;//充值需要的idl
}
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [super setGoBackBlackImage];
    
    self.title = CurLanguageCon(@"Recharge");
    
    mutArray = [NSMutableArray array];
    mutImageButton = [NSMutableArray array];
    mutBankId = [NSMutableArray array];
    mutSeleButton = [NSMutableArray array];
    curSeleBank = 0;
    curSeleBankList = -1;
    curSeleBankMon = 0;
    
    [self initUI];
    
    [self requestamountList];
    

     // Do any additional setup after loading the view.
}

- (void)initUI
{
    
     CGRect rect = MY_RECT(0, 0, IPHONE6SWIDTH, 54);
     rect.origin.y = GetRectNavAndStatusHight;
    
    rect.size.height = HEIGHT - rect.origin.y - rect.size.height;
    scrollView = [[UIScrollView alloc]initWithFrame:rect];
    [self.view addSubview:scrollView];
    
    
   rect = MY_RECT(0, 0, IPHONE6SWIDTH, 134.5);
    rect.size.height = rect.size.width / IPHONE6SWIDTH * 134.5;
    UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [scrollView addSubview:imageIcon];
    imageIcon.image = [UIImage imageNamed:@"recharge_icon"];
    
    CurfloY = rect.origin.y + rect.size.height;
    
    rect = MY_RECT(20, 32, 300, 18);
    rect.origin.y = rect.origin.y + CurfloY;
    UILabel *labReharge = [[UILabel alloc]initWithFrame:rect];
    labReharge.text = [GlobalObject getCurLanguage:@"Unrefundable balance recharge"];
    labReharge.textAlignment = NSTextAlignmentLeft;
    labReharge.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16];
    labReharge.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
    [scrollView addSubview:labReharge];
    
    CurfloY = rect.origin.y + rect.size.height;
    
    
}


#pragma mark ---click

- (void)clickBankCheck:(UIButton *)button
{
   NSInteger tag = button.tag - 500;
    
    for (int i = 0; i < mutSeleButton.count; i ++) {
        
      UIButton *btn = mutSeleButton[i];
        if (i == tag) {
            curSeleBankList = i;
            btn.selected = !NO;
            
            NSDictionary *dic = mutBankId[i];
            seleBankCardID = dic[@"id"];
        }
        else
        {
            btn.selected = NO;
        }
        
    }
}

- (void)clickAddBank
{//创建 添加银行卡b列表
   AddCreditCardViewController *viewController = [[AddCreditCardViewController alloc]init];
    viewController.addCareditCardType = 1;
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)click:(UIButton *)button
{
    for (int i = 0; i < mutArray.count; i ++) {
        UIButton *btn = mutArray[i];
        if (btn == button) {
            
            curSeleBankMon = i;
            btn.selected = YES;
            btn.backgroundColor = [UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:1.0];
            
            labSeleMon.text = btn.titleLabel.text;
            
            btn.layer.borderColor = [UIColor clearColor].CGColor;
        }
        else
        {
            btn.layer.borderColor = [UIColor colorWithRed:0xc3 / 255.0 green:0xc3 / 255.0 blue:0xc3 / 255.0 alpha:1].CGColor;
            btn.selected = NO;
            btn.backgroundColor = [UIColor clearColor];
        }
    }
}

- (void)clickRec
{//直接开始对接 充值的接口
    if (mutBankId && mutBankId.count > 0 && seleBankCardID) {
        //开始钓鱼
        [self requestPay];
    }
    else
    {
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please select a bank card or add a bank card"] bSucc:NO];
    }
}

//- (void)requestRecharge
//{
//    NSString *strMon = arrayCurMon[curSeleBankMon];
//    __weak typeof(self) weakSelf = self;
//    [gAppDelegate createActivityView];
//
//    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/UserApp/User/recharge"];
//
//    [CLNetwork POST:str parameter:@{@"money":strMon} success:^(id responseObject) {
//
//        [gAppDelegate  removeActivityView];
//        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
//            [weakSelf updateMercadoPagoCheckout:responseObject[@"data"][@"dataId"] rechargeId:responseObject[@"data"][@"rechargeId"]];
//        }
//        else
//        {
//            [gAppDelegate showAlter:responseObject[@"msg"] bSucc:NO];
//            [weakSelf updateRechargeRes:!YES];
//        }
//    } failure:^(NSError *error) {
//
//        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
//        [gAppDelegate  removeActivityView];
//    }];
//}

-(void)requestamountList
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:[NSString stringWithFormat:@"/UserApp/User/rechargeInfo"]];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            [weakSelf createButton:responseObject[@"data"][@"price"]];
           // [weakSelf UpdateBankList:@[]];
           [weakSelf requesBankList];
            // [gAppDelegate showAlter:responseObject[@"message"]  bSucc:YES];
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


-(void)requesBankList
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
   NSString *strType =  [NSString stringWithFormat:@"/pay/mercadopago/getCards/%@",[GlobalObject shareObject].userModel.openid];
     NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,strType];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
           
            [weakSelf UpdateBankList:responseObject[@"data"][@"cards"]];
            //[weakSelf requestAct];
            // [gAppDelegate showAlter:responseObject[@"message"]  bSucc:YES];
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



//- (void)updateMercadoPagoCheckout:(NSString *)payResult_ID  rechargeId:(NSString *)recharge_Id
//{
//
//    MercadoPagoCheckout *checkout = [[MercadoPagoCheckout alloc] initWithBuilder:[[MercadoPagoCheckoutBuilder alloc] initWithPublicKey:@"APP_USR-1701a76a-89e1-40ad-9da6-a5ac6ef4e90e" preferenceId:payResult_ID]];
//
//    [checkout startWithNavigationController:self.navigationController lifeCycleProtocol:self];
//}

- (void)updateRechargeRes:(BOOL)bSucc
{
   if (bSucc) {
        [UserModel requestUserInfor];
    }
    
    if(_bChargin)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"RechargeSuccessfulLease" object:nil];
        //开始自己通知
        [self.navigationController popViewControllerAnimated:NO];
    }
    else
    {
        RechargeResultViewController *viewController = [[RechargeResultViewController alloc]init];
        viewController.bSucces = bSucc;
        viewController.dic = dicPay;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)createButton:(NSString *)strPrice
{
    arrayCurMon = [strPrice componentsSeparatedByString:@","];
    
    CGRect rect;
    for (int i = 0;i < arrayCurMon.count ; i ++) {
        
        CGFloat floX = i == 0 || i == 2 || i == 4 ?  25.5  : 199.5  ;
        NSInteger numberY = i / 2;
        
        CGFloat floY = 18.5 + 62 * numberY;//  i > 1 ? 80.5 : 18.5;
        NSString *strMon = arrayCurMon[i];
        rect = MY_RECT(floX, floY, 150, 46);
        rect.origin.y = rect.origin.y + CurfloY;
        UIButton *button = [[UIButton alloc]initWithFrame:rect];
        [scrollView addSubview:button];
        
        [button setTitle:[NSString stringWithFormat:@"$%d",[strMon intValue]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0] forState:UIControlStateNormal];
        button.backgroundColor = i == 0 ? [UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:1.0] : [UIColor clearColor];
        
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = RechargeTag + i;
        
        [mutArray addObject:button];
        button.layer.cornerRadius = rect.size.height / 2.0;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor clearColor].CGColor;
        if (i != 0) {
            //[button qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
            button.layer.borderColor = [UIColor colorWithRed:0xc3 / 255.0 green:0xc3 / 255.0 blue:0xc3 / 255.0 alpha:1].CGColor;
        }
        button.selected = i == 0 ? YES : NO;
        
        if(i == arrayCurMon.count - 1)
        {
            CurfloY = button.frame.origin.y + CGRectGetHeight(button.frame);
        }
            
    }
}

- (void)UpdateBankList:(NSArray *)array
{
    mutBankId = [array copy];
    
    CGRect rect = MY_RECT(20, 39, 300, 54);
    rect.origin.y = rect.origin.y + CurfloY;
    UILabel *labpayment = [[UILabel alloc]initWithFrame:rect];
    [scrollView addSubview:labpayment];
    labpayment.text = CurLanguageCon(@"Please select mode of payment");
    labpayment.textAlignment = NSTextAlignmentLeft;
    labpayment.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16];
    labpayment.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
    CurfloY = labpayment.frame.origin.y + CGRectGetHeight(labpayment.frame);
     
    if (mutBankId && mutBankId.count > 0) {
       
        //4  46.5
        for (int i = 0; i < mutBankId.count; i ++) {
            
            NSDictionary *dic = mutBankId[i];
            
            rect = MY_RECT(0, 4 + 46.5 * i, IPHONE6SWIDTH, 46.5);
            rect.origin.y = rect.origin.y + CurfloY;
            UIView *view = [[UIView alloc]initWithFrame:rect];
            [scrollView addSubview:view];
        
            NSString *strImageBank = dic[@"paymentMethod"][@"name"];
            CGFloat floHei = 30;
            if ([strImageBank isEqualToString:@"Mastercard"]) {
               strImageBank = @"careditbank_mastercard";//[@"bank_" stringByAppendingString:@"masterCard"];
            }//
            else
            {
                floHei = 20;
                strImageBank =@"creditbank_visa";
            }
            
            UIImage  *image = [UIImage imageNamed:strImageBank];
            rect = MY_RECT(25, (46.5 - floHei) / 2.0, 24, floHei);
            rect.size.width = rect.size.height / image.size.height * image.size.width;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
            [view addSubview:imageView];
            imageView.image = image;
            
            rect = MY_RECT(16, 0, 180, 46.5);
            rect.origin.x = rect.origin.x + imageView.frame.origin.x + CGRectGetWidth(imageView.frame);
            UILabel *labNumber = [[UILabel alloc]initWithFrame:rect];
            [view addSubview:labNumber];
            labNumber.text = [@"**** **** **** " stringByAppendingString:dic[@"lastFourDigits"]];;
            labNumber.textAlignment = NSTextAlignmentLeft;
            labNumber.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:19];
            labNumber.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
            
            rect =MY_RECT(21, 45, IPHONE6SWIDTH - 42, 0.6);
            UIView *viewLine = [[UIView alloc]initWithFrame:rect];
            [view addSubview:viewLine];
            viewLine.backgroundColor = [UIColor colorWithRed:0xe5 /255.0 green:0xe5 /255.0 blue:0xe5 /255.0 alpha:1];
            
            rect = MY_RECT(333, (46.5 - 18) / 2.0, 18, 18);
            rect.size.width = rect.size.height;
            UIButton *button = [[UIButton alloc]initWithFrame:rect];
            [view addSubview:button];
            [button setImage:[UIImage imageNamed:@"bankcheck"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"bankcheck_sele"] forState:UIControlStateSelected];
            button.userInteractionEnabled = NO;
            [mutSeleButton addObject:button];
            
            rect = MY_RECT(0, 0, IPHONE6SWIDTH, 46.5);
            UIButton *buttonBank = [[UIButton alloc]initWithFrame:rect];
            [view addSubview:buttonBank];
            [buttonBank addTarget:self action:@selector(clickBankCheck:) forControlEvents:UIControlEventTouchUpInside];
            buttonBank.tag = 500 + i;
           
            if (i == mutBankId.count - 1) {
              
                CurfloY = view.frame.origin.y + CGRectGetHeight(view.frame);
            }
        }
    }
    
    rect = MY_RECT(0, 0, IPHONE6SWIDTH, 46.5);
    rect.origin.y = CurfloY;
    UIButton *buttonAdd = [[UIButton alloc]initWithFrame:rect];
    [scrollView addSubview:buttonAdd];
    [buttonAdd  setTitle:[GlobalObject getCurLanguage:@"+ Other cards"] forState:UIControlStateNormal];
    [buttonAdd setTitleColor:[UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0] forState:UIControlStateNormal];
    buttonAdd.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
    [buttonAdd addTarget:self action:@selector(clickAddBank) forControlEvents:UIControlEventTouchUpInside];
                   
    
    scrollView.contentSize = CGSizeMake(WIDTH, CurfloY + rect.size.height);
     
    
    rect = MY_RECT(0,616, IPHONE6SWIDTH, 0.5);
    UIView *viewLIne = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewLIne];
    viewLIne.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:229 / 255.0 blue:229 / 255.0 alpha:1];
    
    rect = MY_RECT(20, 616, 57, 54);
    rect.size.width = [GlobalObject widthOfString:[GlobalObject getCurLanguage:@"total:"] font:[GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:19]];
    UILabel *labTatal = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labTatal];
    labTatal.text = CurLanguageCon(@"total:");
    labTatal.textAlignment = NSTextAlignmentLeft;
    labTatal.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:19];
      labTatal.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
    NSString *strMon = arrayCurMon.firstObject;
    
    rect = MY_RECT(20, 616, 100, 54);
    rect.origin.x = labTatal.frame.origin.x + CGRectGetWidth(labTatal.frame);
    labSeleMon = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labSeleMon];
    labSeleMon.text =  [NSString stringWithFormat:@"$%0.1f",[strMon floatValue]];
    labSeleMon.textAlignment = NSTextAlignmentLeft;
    labSeleMon.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:19];
    labSeleMon.textColor = [UIColor blackColor];
    
    rect = MY_RECT(248, 616, 127, 54);
    UIButton *buttonRecharge = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonRecharge];
    buttonRecharge.backgroundColor = [UIColor colorWithRed:64/255.0 green:0xb1/255.0 blue:0x5e/255.0 alpha:1.0];
    [buttonRecharge setTitle:[GlobalObject getCurLanguage:@"Recharge"] forState: UIControlStateNormal];
    [buttonRecharge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonRecharge addTarget:self action:@selector(clickRec) forControlEvents:UIControlEventTouchUpInside];
    
    
    [super setBtnGOHiddenNO];
}
// rechargeId ID。

//-(void (^ _Nullable)(void))cancelCheckout {
//    return ^ {
//        [self.navigationController popViewControllerAnimated:YES];
//        //[self.navigationController popToRootViewControllerAnimated:YES];
//    };
//}
//
//
//- (void (^)(id<PXResult> _Nullable))finishCheckout {
//    return ^ (id<PXResult> _Nullable result) {
//        PXPayment *payment = (PXPayment *) result;
//        NSLog(@"%@",[payment getStatus]);
//        NSString *approved = [payment getStatus];
//        NSString *getPaymentId = [payment getPaymentId];
//
////        if ([approved isEqualToString:@"approved"]) {
////            //已批准
////            [self updateRecharge:getPaymentId];
////        }
////        else if([@"rejected" isEqualToString:approved])
////        {
////            [self.navigationController popViewControllerAnimated: YES];
////        }
//    };
//}
 
//- (void)updateRecharge:(NSString *)payment_Id
//{
//    paymentId = payment_Id;
//  //  order_Id = [NSString stringWithFormat:@"%d",[dic[@"data"][@"rechargeId"] intValue]];
//          [self.navigationController popViewControllerAnimated:YES];
//      if (!_bChargin) {
//
//           curTime = [[NSDate date] timeIntervalSince1970];
//           //order_Id = orderId;
//           bStart_Pay = YES;
//
//           [gAppDelegate createActivityView];
//          [self requestRes];
//       }
//    else
//    {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"RechargeSuccessfulLease" object:nil];
//               //开始自己通知
//               [self.navigationController popViewControllerAnimated:NO];
//       // [self updateRechargeRes:YES];
//    }
//
//}

- (void)requestPay
{
    __weak __typeof(self) weakSelf = self;
     [gAppDelegate createActivityView];
   
    NSString *str = [NSString stringWithFormat:@"%@/%@",ChargingApi,@"UserApp/User/recharge"];
    NSString *strMon = arrayCurMon[curSeleBankMon];
    
    strMon = [NSString stringWithFormat:@"%d",[strMon intValue]];
    
    [CLNetwork POST:str parameter:@{@"cardId":seleBankCardID,@"money":strMon} success:^(id responseObject) {
        //0 1 2
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {//支付成功
            [gAppDelegate  removeActivityView];
            
            [self updatePayResult:responseObject[@"data"]];
        }
        else
        {//支付失败
            [gAppDelegate  removeActivityView];
            [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:NO];
            self->bStart_Pay = NO;
            [weakSelf updateRechargeRes:NO];
        }
    } failure:^(NSError *error) {
        self->bStart_Pay = NO;
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"]  bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
}

- (void)updatePayResult:(NSDictionary *)dic
{
    dataId = dic[@"dataId"];
    rechargeId = dic[@"rechargeId"];
    
    curTime = [[NSDate date] timeIntervalSince1970];
    //order_Id = orderId;
    bStart_Pay = YES;
    
    [gAppDelegate createActivityView];
    [self requestResult];
   // [self updateDataUpOrder];
    
}

//查询
- (void)requestResult
{
    __weak __typeof(self) weakSelf = self;
    
    NSString *str = [NSString stringWithFormat:@"%@/%@?id=%@&paymentId=%@",ChargingApi,@"UserApp/User/recharge/finish",rechargeId,dataId];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        //0 1 2
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 2) {
            //请求中
            [weakSelf updateDataUpOrder];
        }
        else if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {//支付成功
            [gAppDelegate  removeActivityView];
            
            [weakSelf updatePaySucc:responseObject];
            
            self->bStart_Pay = NO;
        }
        else
        {//租借失败
            [gAppDelegate  removeActivityView];
            [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:NO];
            self->bStart_Pay = NO;
            [ weakSelf updateRechargeRes:NO];
        }
    } failure:^(NSError *error) {
        self->bStart_Pay = NO;
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"]  bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
}


- (void)updatePaySucc:(NSDictionary *)dic
{
    dicPay = dic[@"data"];//@"";
    [self updateRechargeRes:!NO];
}


- (void)updateDataUpOrder
{
    long long differenceTime = [[NSDate date] timeIntervalSince1970] - curTime;
    
    if (differenceTime > 5) {
        curTime =  [[NSDate date] timeIntervalSince1970];
        
        [self requestResult];
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
        [self updateRechargeRes:!YES];
    }
    else
        [self requestResult];
}

- (void)addBankID:(NSString *)bankI_d
{//开始充值
    seleBankCardID = bankI_d;
    [self requestPay];
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
