//
//  OrderDetailsViewController.m
//  Tanc
//
//  Created by f on 2019/12/17.
//  Copyright © 2019 f. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "CustomerServiceView.h"
#import "LostPurchaseView.h"
#import "RechargeResultViewController.h"
#import "MainViewController.h"

@interface OrderDetailsViewController ()<LostPurchaseViewDelete>

@end

@implementation OrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setGoBackBlackImage];
    
    self.title = CurLanguageCon(@"order details");
    
    
    [self requestOrderDetail];
     
}

- (void)requestOrderDetail
{
    [gAppDelegate createActivityView];
      __weak __typeof(self) weakSelf = self;
    
   
      NSString *str = [NSString stringWithFormat:@"%@%@?orderId=%@",ChargingApi,@"/UserApp/order/detail",_orderId];
    
    [CLNetwork GET:str parameter:@{} success:^(id responseObject) {
          
          [gAppDelegate  removeActivityView];
          
          if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
              
              [weakSelf initUI:responseObject[@"data"]];
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


- (void)initTopRight
{
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"orderCustomerService"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    [button addTarget:self action:@selector(clickTopRight) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initUI:(NSDictionary *)dic
{
    CGRect rect = MY_RECT(0, 17.5, 14, 10.5);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    rect.size.width = rect.size.height /10.5 * 14;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"orderStatusImage"];
    
    rect = MY_RECT(29, 15, 220, 13);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    UILabel *labOrderStatus = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labOrderStatus];
    labOrderStatus.text = [GlobalObject getCurLanguage:@"Order Status"];
    labOrderStatus.textColor = [UIColor blackColor];
    labOrderStatus.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
    
    rect = MY_RECT(287 - 100, 15, 62 + 100, 13);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    UILabel *labCurSta = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labCurSta];
    labCurSta.textAlignment = NSTextAlignmentRight;
    
    labCurSta.textColor = [UIColor blackColor];
    labCurSta.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
    NSString *strOrdState  = [GlobalObject getOrderState:dic[@"orderState"]];
    labCurSta.text = [GlobalObject getCurLanguage:strOrdState];
    labCurSta.textColor = [GlobalObject getOrderColor:dic[@"orderState"]];
    
    
    
    rect = MY_RECT(30, 39.5, 332, 0);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgr];
    
    NSString *strStatus = dic[@"orderState"];
    NSArray *array = [self getAllTitle:strStatus];
    NSArray *arrayContent = [self getAllCon:dic];
    for (int i = 0; i < array.count; i ++) {
        
        rect = MY_RECT(10 , 15 + (19.5 + 11) * i, 130, 11);
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [viewBackgr addSubview:lab];
        lab.text = CurLanguageCon(array[i]);
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
        lab.textColor = [UIColor blackColor];
        
        rect = MY_RECT(11 , 15 + (19.5 + 11) * i, 200, 11);
        rect.origin.x =  CGRectGetWidth(viewBackgr.frame) - rect.origin.x - rect.size.width;
        UILabel *labCon = [[UILabel alloc]initWithFrame:rect];
        [viewBackgr addSubview:labCon];
        labCon.text = CurLanguageCon(arrayContent[i]);
        labCon.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
        labCon.textColor = [UIColor colorWithRed:87/255.0 green:87/255.0 blue:87/255.0 alpha:1.0];
        labCon.textAlignment = NSTextAlignmentRight;
    }
    rect = viewBackgr.frame;
      rect.size.height = (15 * 2 + (19.5 + 11) * array.count) / IPHONE6SHEIGHT * HEIGHT;
      viewBackgr.frame = rect;
      // [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:17];
      viewBackgr.layer.cornerRadius = 18;
      viewBackgr.layer.borderWidth = 0.7;
      viewBackgr.layer.borderColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0].CGColor;
    
    if (![strStatus isEqualToString:@"租借中"]) {
        return;
    }
    
  
    
    rect = MY_RECT((IPHONE6SWIDTH - 284) / 2.0, 598, 284, 44);
    rect.size.height = rect.size.width / 284.0 * 44;
    
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
    
    UIButton *buttonLogin = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonLogin];
    [buttonLogin setTitle:[GlobalObject getCurLanguage:@"Lost purchase"] forState:UIControlStateNormal];
    [buttonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonLogin.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    [buttonLogin addTarget:self action:@selector(clickLostPurchase) forControlEvents:UIControlEventTouchUpInside];
//    buttonLogin.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
//    buttonLogin.shadowOpacity(0.7).shadowColor((UIColor *)AllColorShadow).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    
     [super setBtnGOHiddenNO];
}


-(void)requestLogin
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:[NSString stringWithFormat:@"/UserApp/order/detail?orderId=%@",_orderId]];
    
    [CLNetwork GET:str parameter:@{} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            [weakSelf initUI:responseObject[@"data"]];
            
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
- (NSArray *)getAllCon:(NSDictionary *)dic
{
    NSArray *array;
    //[dic[@"payPrice"] intValue]
    NSString *strStatus = dic[@"orderState"];
    if ([strStatus isEqualToString:@"已归还"]) {
        
        NSString *strAdre = [[dic allKeys] containsObject:@"returnAddr"] ? dic[@"returnAddr"] : @"";
        
        array = @[[NSString stringWithFormat:@"%d",[dic[@"orderNum"] intValue]],
                  dic[@"borrowTime"],
                  dic[@"returnTime"],
                  [NSString stringWithFormat:@"%dh",[dic[@"useTime"] intValue]],
                  [NSString stringWithFormat:@"1h/SAR%0.2f",[dic[@"price"] floatValue]],
                  [NSString stringWithFormat:@"%dmin",[dic[@"freeTime"] intValue]],
                  dic[@"deviceType"],
                  dic[@"shopName"],
                  dic[@"returnShopName"],
                  dic[@"shopAdr"],
                  strAdre,
                  [NSString stringWithFormat:@"SAR%0.2f",[dic[@"payPrice"] floatValue]]];
    }
    else
    {
        array = @[[NSString stringWithFormat:@"%d",[dic[@"orderNum"] intValue]],
                  dic[@"borrowTime"],
                  [NSString stringWithFormat:@"%dh",[dic[@"useTime"] intValue]],
                   [NSString stringWithFormat:@"1h/SAR%0.2f",[dic[@"price"] floatValue]],
                  [NSString stringWithFormat:@"%dmin",[dic[@"freeTime"] intValue]],
                  dic[@"deviceType"],
                  dic[@"shopName"],
                  dic[@"shopAdr"]];
    }
    return array;
}

- (NSArray *)getAllTitle:(NSString *)strStatus
{
    NSArray *array;
    if ([strStatus isEqualToString:@"已归还"]) {
        array = @[[GlobalObject getCurLanguage:@"Order number:"],
                  [GlobalObject getCurLanguage:@"Rental time:"],
                  [GlobalObject getCurLanguage:@"return time:"],
                  [GlobalObject getCurLanguage:@"Lease duration:"],
                  [GlobalObject getCurLanguage:@"Charges:"],
                  [GlobalObject getCurLanguage:@"Free duration:"],
                  [GlobalObject getCurLanguage:@"Equipment type:"],
                  [GlobalObject getCurLanguage:@"Rental business:"],
                  [GlobalObject getCurLanguage:@"Return business:"],
                  [GlobalObject getCurLanguage:@"Rental address:"],
                  [GlobalObject getCurLanguage:@"Return address:"],
                  [GlobalObject getCurLanguage:@"Rental fees:"]];
    }
    else
    {
        array = @[[GlobalObject getCurLanguage:@"Order number:"],
                  [GlobalObject getCurLanguage:@"Rental time:"],
                  [GlobalObject getCurLanguage:@"Lease duration:"],
                  [GlobalObject getCurLanguage:@"Charges:"],
                  [GlobalObject getCurLanguage:@"Free duration:"],
                  [GlobalObject getCurLanguage:@"Equipment type:"],
                  [GlobalObject getCurLanguage:@"Rental business:"],
                  [GlobalObject getCurLanguage:@"Rental address:"]];
    }
    return array;
}


- (void)clickLostPurchase
{
    LostPurchaseView *customerServiceView = [[LostPurchaseView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    customerServiceView.delegate = self;
    [gAppDelegate addTopView:customerServiceView];
}

- (void)clickTopRight
{
    CustomerServiceView *customerServiceView = [[CustomerServiceView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    [gAppDelegate addTopView:customerServiceView];
}

- (void)requestPay
{
    [gAppDelegate createActivityView];
       __weak __typeof(self) weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"%@%@?orderId=%@",ChargingApi,@"/UserApp/Borrow/lossToBuy",_orderId]; //;//[ChargingApi stringByAppendingString:@"/UserApp/Borrow/lossToBuy"];
       
       NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
        
       [CLNetwork POST:str parameter:mutDic success:^(id responseObject) {
           
           [gAppDelegate  removeActivityView];
          
           if ( [[responseObject allKeys] containsObject:@"code"] &&
                [responseObject[@"code"] intValue] > 0) {
               
               [weakSelf createRechargeResultViewController:YES buyId:responseObject[@"data"]];
           }
           else
           {
               [gAppDelegate  removeActivityView];
              
               [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:NO];
               
               [weakSelf createRechargeResultViewController:!YES buyId:@"11"];
           }
       } failure:^(NSError *error) {
           [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
           [gAppDelegate  removeActivityView];
       }];
}


- (void)createRechargeResultViewController:(BOOL)bSucc buyId:(NSString *)buyID
{
    NSString *strAddTime = [self getTodayDate];
    NSDictionary *dic = @{@"id":[NSString stringWithFormat:@"%d",[buyID intValue]],@"addTime":strAddTime};
    RechargeResultViewController *viewController = [[RechargeResultViewController alloc]init];
    viewController.bSucces = bSucc;
    viewController.bBuy= YES;
    viewController.dic = dic;
    viewController.bWithdraw = !YES;
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
