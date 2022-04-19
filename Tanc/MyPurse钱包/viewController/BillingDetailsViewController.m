//
//  BillingDetailsViewController.m
//  Tanc
//
//  Created by f on 2019/12/12.
//  Copyright © 2019 f. All rights reserved.
//Billing details

#import "BillingDetailsViewController.h"

@interface BillingDetailsViewController ()

@end

@implementation BillingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    self.title = CurLanguageCon(@"Billing details");
    
    self.view.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1];
    
    
    [self request];
    
    // [self initUI];
    
    // Do any additional setup after loading the view.
}

- (void)request
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/UserApp/User/ChongzhiDetail"];
    if (_curSeleType == 1) {
        str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/UserApp/User/expenses/detail"];
    }
    [CLNetwork POST:str parameter:@{@"id":_bill_id} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            [ weakSelf initUI:responseObject[@"data"]];
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

- (void)initUI:(NSDictionary *)dic
{
    CGRect rect = MY_RECT(0, 0, IPHONE6SWIDTH, 0);
    rect.size.height = GetRectNavAndStatusHight;
    UIView *viewBackgrWhi =[[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgrWhi];
    viewBackgrWhi.backgroundColor = [UIColor whiteColor];
    
    rect = MY_RECT(15, 15, IPHONE6SWIDTH - 15 * 2, 272);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgr];
    [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:5];
    viewBackgr.backgroundColor = [UIColor whiteColor];
    
    rect = MY_RECT(0, 37, IPHONE6SWIDTH - 15 * 2, 15);
    UILabel *lab = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:lab];
    lab.text = _curSeleType == 1 ? [GlobalObject getCurLanguage:@"Rental Consumption"]  : [GlobalObject getCurLanguage:@"Top up to balance"];
    lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    
    NSString  *strMon;
    if (_curSeleType == 0) {
        strMon =  [NSString stringWithFormat:@"$ %0.2f",[dic[@"chongzhi"] floatValue]];
    }
    else
    {
        BOOL bStr = [GlobalObject isStringNil:dic[@"account_yajin"]];
        NSString *account_yajin = [GlobalObject judgeStringNil:dic[@"account_yajin"]];
        if (bStr && [account_yajin intValue] < 0) {
            account_yajin = [GlobalObject judgeStringNil:dic[@"account_yajin"]];
        }
        else
        {
            account_yajin = [GlobalObject judgeStringNil:dic[@"account_my"]];
        }
        strMon = [NSString stringWithFormat:@"$ %0.2f",[account_yajin floatValue]];
    }
    rect = MY_RECT(0, 68, IPHONE6SWIDTH - 15 * 2, 15);
    UILabel *labMOn = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labMOn];
    
    labMOn.text = strMon;
    labMOn.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14];
    labMOn.textAlignment = NSTextAlignmentCenter;
    labMOn.textColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
    
    rect = MY_RECT(10, 115, 324, 0.5);
    UIView *viewLIne = [[UIView alloc]initWithFrame:rect];
    [viewBackgr addSubview:viewLIne];
    viewLIne.backgroundColor = [UIColor colorWithRed:217 / 255.0 green:217 / 255.0 blue:217 / 255.0 alpha:1];
    
    
    NSArray *array;
    if (_curSeleType == 0) {
        NSString * strr = [dic[@"type"] intValue] == 0 ? [GlobalObject getCurLanguage:@"Deposit"]: [GlobalObject getCurLanguage:@"Recharge balance"];
        
        array = @[@"Current status",@"Recharge time",@"payment method",@"card number",@"Transaction number",
                  dic[@"status"], dic[@"addTime"],strr,[NSString stringWithFormat:@"**** **** **** %d",[dic[@"last4Digits"] intValue]], [NSString stringWithFormat:@"%d",[dic[@"trade_no"] intValue]]];
    }
    else
    {
        int sourceType = [dic[@"sourceType"] intValue];
        
        array = @[@"Recharge time",@"payment method",@"Transaction number",@"Billing status",
                  dic[@"add_time"],[self getMonState:sourceType],dic[@"sourceId"],[GlobalObject getCurLanguage:@"Successful transaction"]];
    }
    
    
    
    rect = viewBackgr.frame;
    rect.size.height = _curSeleType == 1 ? 304 / IPHONE6SHEIGHT * HEIGHT : 321 / IPHONE6SHEIGHT * HEIGHT;
    viewBackgr.frame = rect;
    
    [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:5];
    viewBackgr.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < array.count / 2 ; i ++) {
        
        rect = MY_RECT(10, 149 + i * 35, 170, 14);
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [viewBackgr addSubview:lab];
        lab.text = CurLanguageCon(array[i]);
        lab.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
        
        
        rect = MY_RECT(162, 149 + i * 35, 180, 14);
        UILabel *labCont = [[UILabel alloc]initWithFrame:rect];
        [viewBackgr addSubview:labCont];
        labCont.text = CurLanguageCon(array[i + (int)array.count / 2]);
        labCont.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
        labCont.textAlignment = NSTextAlignmentLeft;
        labCont.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
        
    }
     [super setBtnGOHiddenNO];
}

- (NSString *)getMonState:(NSInteger)intType
{
    NSString *str = @"consumption";
    switch (intType) {
        case 0 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Order consumption"];
        }
            break;
        case 1 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Merchant change"];
        }
            break;
        case 2 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Withdrawal balance"];
        }
            break;
        case 3 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Withdrawal balance"];
        }
            break;
        case 4 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Recharge balance"];
        }
            break;
        case 5 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Recharge deposit"];
        }
            break;
        case 7:
        {
            str = [GlobalObject getCurLanguage:@"Deduction balance before withdrawal"];
        }
            break;
        case 8:
        {
            str = [GlobalObject getCurLanguage:@"Lost purchase, deduction of deposit"];
        }
            break;
        case  9:
        {
            str = [GlobalObject getCurLanguage:@"Overtime orders, minus deposit"];
        }
            break;
            
        default:
            break;
    }
    return str;
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
