//
//  CreditCardDefViewController.m
//  Tanc
//
//  Created by f on 2019/12/26.
//  Copyright © 2019 f. All rights reserved.
//

#import "CreditCardDefViewController.h"
#import "DeleteBankCardView.h"
@interface CreditCardDefViewController ()<DeleteBankCardViewDelegate>
{
    
}
@end

@implementation CreditCardDefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    [self initTopRight];
    
    [self initUI];
    
     [super setBtnGOHiddenNO];
    // Do any additional setup after loading the view.
}

- (void)initTopRight
{
    UIButton *buttonRigh = [[UIButton alloc]init];
    [buttonRigh setImage:[UIImage imageNamed:@"deleteCreditCard"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:buttonRigh];
    self.navigationItem.rightBarButtonItem = buttonItem;
    [buttonRigh addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
    
    self.title = CurLanguageCon(@"Credit card details");
    
}

- (void)initUI
{
    CGRect rect = MY_RECT(14.5, 79 - PhoneHeight, 345.5, 165.5);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgr];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:147/255.0 green:193/255.0 blue:95/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    [viewBackgr.layer addSublayer:gl];
    [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:5];
    
    rect = MY_RECT(19, 20, 100, 8);
    UILabel *labCar = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labCar];
    labCar.textColor = [UIColor whiteColor];
    labCar.textAlignment = NSTextAlignmentLeft;
    labCar.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10];
    labCar.text = CurLanguageCon(@"Card number");
    
    rect = MY_RECT(19, 36, 180, 13);
    UILabel *_labNumber = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:_labNumber];
    _labNumber.text = [@"**** **** **** " stringByAppendingString:_dic[@"lastFourDigits"]];
    _labNumber.textColor = [UIColor whiteColor];
    _labNumber.textAlignment = NSTextAlignmentLeft;
    _labNumber.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    
    rect = MY_RECT(281, 20, 44, 44);
    rect.size.width = rect.size.height;
    UIImageView *_imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgr addSubview:_imageIcon];
    [_imageIcon qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    
    NSString *strImageBank = _dic[@"paymentMethod"][@"name"];
    
    if ([strImageBank isEqualToString:@"Mastercard"]) {
        strImageBank = @"careditbank_mastercard";//[@"bank_" stringByAppendingString:@"masterCard"];
    }//
    else
    {//creditbank_visa
        strImageBank =@"creditbank_visa";
    }
 
    _imageIcon.image =   [UIImage imageNamed:strImageBank];
    
    rect = MY_RECT(19, 67, 160, 12);
    UILabel *labExp = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labExp];
    labExp.text = CurLanguageCon(@"Expiration date");
    labExp.textColor = [UIColor whiteColor];
    labExp.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10];
    //
    rect = MY_RECT(19, 82, 160, 15);
    UILabel * _labMon = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:_labMon];
    _labMon.text = [NSString stringWithFormat:@"%@/%@",_dic[@"expirationYear"],_dic[@"expirationMonth"]];
    _labMon.textColor = [UIColor whiteColor];
    _labMon.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    
    //    rect = MY_RECT(19, 116, 160, 12);
    //    UILabel *labSecurityCode = [[UILabel alloc]initWithFrame:rect];
    //    [viewBackgr addSubview:labSecurityCode];
    //    labSecurityCode.text = CurLanguageCon(@"Security code");
    //    labSecurityCode.textColor = [UIColor whiteColor];
    //    labSecurityCode.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10];
    //
    //    //
    //    rect = MY_RECT(19, 131, 160, 15);
    //    UILabel * _labCode = [[UILabel alloc]initWithFrame:rect];
    //    [viewBackgr addSubview:_labCode];
    //    _labCode.text = @"122";
    //    _labCode.textColor = [UIColor whiteColor];
    //    _labCode.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    
    NSString *str = @"*";
    UIFont *font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
    rect = MY_RECT(14.5, 272 - PhoneHeight, 5, 5);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    rect.size.width = [GlobalObject widthOfString:str font:font];
    rect.size.height = [GlobalObject getStringHeightWithText:str font:font viewWidth:rect.size.width];
    UILabel *labStar = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labStar];
    labStar.text = str;
    labStar.font = font;
    labStar.textColor = [UIColor colorWithRed:0xf4/ 255.0 green:53 / 255.0 blue:44 / 255.0 alpha:1];
    
    str = CurLanguageCon(@"To unbind a credit card, just click the unbind button at the top right of the page, and rebind if necessary.");
    rect = MY_RECT(2, 272, 345.5, 3);
    rect.size.width = rect.size.width - CGRectGetWidth(labStar.frame) - rect.origin.x;
    rect.origin.x = labStar.frame.origin.x + CGRectGetWidth(labStar.frame)  + rect.origin.x;
    rect.size.height = [GlobalObject getStringHeightWithText:str font:font viewWidth:rect.size.width];
    UILabel *labTit = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labTit];
    labTit.numberOfLines = 0;
    labTit.text = str;
    labTit.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
    labTit.textColor = [UIColor colorWithRed:36/255.0 green:39/255.0 blue:43/255.0 alpha:1.0];
    labTit.textAlignment = NSTextAlignmentLeft;
    
}

- (void)clickDelete
{
    [self createDeleteBankCardView];
}

- (void)createDeleteBankCardView
{
    DeleteBankCardView *view = [[DeleteBankCardView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    view.delegate = self;
    [gAppDelegate addTopView:view];
}


- (void)removeBank
{
    [self requestAddBank];
}

-(void)requestAddBank
{
    //
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:[NSString stringWithFormat:@"/UserApp/User/DropCard/%@",_dic[@"id"]]];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            [weakSelf removeBankSucc];
            
            [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:YES];
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

- (void)removeBankSucc
{
    [self.navigationController popViewControllerAnimated:YES];
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
