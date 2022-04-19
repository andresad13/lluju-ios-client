//
//  RetrievePasswViewController.m
//  Tanc
//
//  Created by f on 2019/12/6.
//  Copyright © 2019 f. All rights reserved.
//

#import "RetrievePasswViewController.h"
#import "AllInputBoxView.h"
#import "AreaCodeViewController.h"

@interface RetrievePasswViewController ()<UITextFieldDelegate,AreaCodeViewDelegate>
{
    NSMutableArray *mutArray;
    
    UIButton *buttonSend;
    
    NSTimer *timer;
    int numberTime;
    AllInputBoxView *_phoneTextfiel;
    long long curSeleTime;//记录当前选中的时间
}
@end

@implementation RetrievePasswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    [self initData];
    
    [self initUI];
    
    
    // Do any additional setup after loading the view.
}

- (void)initData
{
    mutArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];//进入前台
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];//今日后台
}

- (void)initUI
{
    _strCode = @"+57";
    NSArray *array = @[@"Phone number",@"Verification code",@"new password"];
    
    for (int i = 0; i < array.count; i ++) {
        
        CGRect rect = MY_RECT(29, 172 - PhoneHeight - 54 + 54 * i, IPHONE6SWIDTH - 29 * 2, 54);
        rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
        BOOL bCode = i == 0  ? YES : NO;
        AllInputBoxView *allInputView = [AllInputBoxView createAllInput:rect bCode:bCode];
        [self.view addSubview:allInputView];
        
        allInputView.textField.delegate = self;
        allInputView.textField.keyboardType = i == 0 ? UIKeyboardTypeNumberPad : UIKeyboardTypeASCIICapable;
        
        if (i == 0)
        {
            _phoneTextfiel = allInputView;
            [allInputView.buttonCode addTarget:self action:@selector(clickCode) forControlEvents:UIControlEventTouchUpInside];
            
            //验证码
        }
        else if(i == 2)
        {//眼睛
            allInputView.textField.secureTextEntry = YES;
        }
        
        NSString *str = @"";
        
        [allInputView.labPro setLabText:str strSec:[GlobalObject getCurLanguage:array[i]] font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13]];
        
        [mutArray addObject:allInputView];
        
        
    }
    
    CGRect rect = MY_RECT(321 - 10,  276 - PhoneHeight - 24 - 54 * 2 , 19 + 20, 12 + 20);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    UIButton *buttonEmail = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonEmail];
    [buttonEmail setImage:[UIImage imageNamed:@"emailLogin"] forState:UIControlStateNormal];
    [buttonEmail setImage:[UIImage imageNamed:@"phoneLogin"] forState:UIControlStateSelected];
    [buttonEmail addTarget:self action:@selector(clickEmail:) forControlEvents:UIControlEventTouchUpInside];
//    buttonEmail.center = CGPointMake(buttonEmail.center.x, _phoneTextfiel.center.y);
    
    
    rect = MY_RECT(321 - 10, 276 - PhoneHeight - 24, 19 + 20, 12 + 20);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    UIButton *buttonEyes = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonEyes];
    [buttonEyes setImage:[UIImage imageNamed:@"loginPas_show"] forState:UIControlStateNormal];
    [buttonEyes setImage:[UIImage imageNamed:@"loginPas_hidden"] forState:UIControlStateSelected];
    [buttonEyes addTarget:self action:@selector(clickEyes:) forControlEvents:UIControlEventTouchUpInside];
    
    
    rect = MY_RECT(264 - 8, 202 - PhoneHeight  - 10, 78.5 + 8, 26.5);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    buttonSend = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonSend];
    [buttonSend setTitle:[GlobalObject getCurLanguage:@"verification code"] forState:UIControlStateNormal];
    
    [buttonSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonSend.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10];
    [buttonSend addTarget:self action:@selector(clickSend) forControlEvents:UIControlEventTouchUpInside];
    buttonSend.backgroundColor = [UIColor colorWithRed:99/255.0 green:177/255.0 blue:94/255.0 alpha:1.0];
    [buttonSend qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    buttonSend.titleLabel.numberOfLines = 0;
    
    //找回密码
    rect = MY_RECT((IPHONE6SWIDTH - 284) / 2.0, 360 - PhoneHeight, 284, 44);
    rect.size.height = rect.size.width / 284.0 * 44;
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
    
    
      UIButton *buttonLogin = [[UIButton alloc]initWithFrame:rect];
      [self.view addSubview:buttonLogin];
      [buttonLogin setTitle:[GlobalObject getCurLanguage:@"determine"] forState:UIControlStateNormal];
      [buttonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      buttonLogin.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
      [buttonLogin addTarget:self action:@selector(clickDetermine) forControlEvents:UIControlEventTouchUpInside];
//      buttonLogin.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
//      buttonLogin.shadowOpacity(0.7).shadowColor((UIColor *)AllColorShadow).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
}


#pragma mark ---click

- (void)clickDetermine
{
    [self StopInput];
       BOOL bShow = NO;
       for (int i = 0; i < mutArray.count ; i ++) {
           
           AllInputBoxView *view = mutArray[i];
           if ([view.textField.text length] <= 0) {
               [self showPro:i];
               bShow = YES;
               break;
           }
       }
       
       if (!bShow) {
           //注册
           [self requestRegi];
       }
}

- (void)clickCode
{
    [self StopInput];
    AreaCodeViewController *viewController = [[AreaCodeViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.delegate = self;
}

- (void)clickEmail:(UIButton *)btn
{
    btn.selected = !btn.selected;
       [_phoneTextfiel setEmail:btn.selected];
       
       bEmail = btn.selected;
       
       if (!btn.selected) {
           
           _phoneTextfiel.textField.keyboardType = UIKeyboardTypeNumberPad;
           [_phoneTextfiel.labPro setLabText:@"" strSec:[GlobalObject getCurLanguage:@"Phone number"] font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13]];
       }
       else
       {
           [_phoneTextfiel.labPro setLabText:@"" strSec:[GlobalObject getCurLanguage:@"Mailbox"] font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13]];
           _phoneTextfiel.textField.keyboardType = UIKeyboardTypeASCIICapable;
       }
       [_phoneTextfiel.textField resignFirstResponder];
       
       [_phoneTextfiel.textField becomeFirstResponder];
}

- (void)clickEyes:(UIButton *)button
{
    [self StopInput];
    AllInputBoxView *view = mutArray[2];
    button.selected = !button.selected;
    view.textField.secureTextEntry = !button.selected;
    
}

- (void)clickSend
{
    [self StopInput];
    AllInputBoxView *phoneView = mutArray.firstObject;
    if ([phoneView.textField.text length] <= 0) {
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter the correct phone number"] bSucc:NO];
        return;
    }
    
    buttonSend.userInteractionEnabled = YES;
    
    [self requestSendCode:@""];
}

/*停止键盘输入*/
- (void)StopInput
{
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        [view.textField resignFirstResponder];
    }
}


- (void)updateAreaCode:(NSString *)strNumb
{
    
    AllInputBoxView *view = mutArray.firstObject;
    [view.buttonCode setTitle:strNumb forState:UIControlStateNormal];
    _strCode = strNumb;
    
}


- (void)applicationBecomeActive
{
    long long newTime = [[NSDate date] timeIntervalSince1970] - curSeleTime;
    
    if (numberTime > 0 && numberTime - newTime > 0) {
        numberTime = (int)(numberTime - newTime);
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerSend:) userInfo:nil repeats:YES];
    }
    else
    {
        numberTime = 0;
    }
}

- (void)applicationEnterBackground
{
    if (numberTime > 0 && timer) {
        curSeleTime = [[NSDate date] timeIntervalSince1970];//记录当前选中的时间
    }
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)timerSend:(NSTimer *)timer
{
    numberTime --;
    
    [buttonSend setTitle:[NSString stringWithFormat:@"%ds",numberTime] forState:UIControlStateNormal];
    if (numberTime <= 0)
    {
        
        [timer invalidate];
        timer = nil;
        NSString *str =  CurLanguageCon(@"verification code")
        [buttonSend setTitle:str forState:UIControlStateNormal];
        buttonSend.userInteractionEnabled = YES;
    }
}





- (void)updateBtnMess
{
    numberTime = 60;
    
    [buttonSend setTitle:[NSString stringWithFormat:@"%ds",numberTime] forState:UIControlStateNormal];
    
    
    buttonSend.userInteractionEnabled = NO;
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerSend:) userInfo:nil repeats:YES];
}

#pragma mark ---textFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        if (view.textField == textField) {
            if (i == 0) {
                 view.bEnter = YES;
            }
            [view updateSeleUI:YES];
            [view setAllinputViewState:YES];
        }
        else{
            [view updateSeleUI:!YES];
        }
    }
    
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        if (view.textField == textField) {
            if (i == 0) {
                view.bEnter = !YES;
            }
            [view updateSeleUI:NO];
        }
        [view updateTextUI];
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    BOOL bSele = NO;
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        if (view == touch.view) {
            bSele = YES;
            break;
        }
        
    }
    if (!bSele) {
        for (int i = 0; i < mutArray.count; i ++) {
            AllInputBoxView *view = mutArray[i];
            
            if(i == 0)
            {
                view.bEnter = YES;
            }
            [view.textField resignFirstResponder];
            [view updateSeleUI:NO];
            [view updateTextUI];
        }
    }
    
}

#pragma mark --- request

/*发送短信*/
-(void)requestSendCode:(NSString *)strr
{
    AllInputBoxView *allInpView=  mutArray.firstObject;
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    
    
    NSString * mobile = [GlobalObject isHaveAdd:_strCode];
    mobile = [NSString stringWithFormat:@"%@%@",mobile,allInpView.textField.text];
    
    NSString *str = [ChargingApi stringByAppendingString:@"/UserApp/LoginAPI/sendsmg"];
    NSDictionary *dic = @{@"code_type":@"2",
                          @"mobile":mobile
    };
    
    if (bEmail) {
          
          str = [ChargingApi stringByAppendingString:@"/UserApp/LoginAPI/sendMailMsg"];
          dic = @{@"code_type":@"2",
                  @"mail":allInpView.textField.text
          };
      }
      
    
    [CLNetwork POST:str parameter:dic success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            [ weakSelf updateBtnMess];
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

/*找回密码 请求*/
-(void)requestRegi
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:@"/UserApp/LoginAPI/forget_pwd"];
    
    NSMutableDictionary *mutDic = [self getRegDic];
    
    [CLNetwork POST:str parameter:mutDic success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            
            [weakSelf regiSucc];
            
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

- (NSMutableDictionary *)getRegDic
{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
       NSString *strMobi = bEmail ? @"mail": @"mobile";
    NSArray *array = @[strMobi,@"code",@"pwd"];
    for (int i = 0; i < array.count; i ++)
    {
        AllInputBoxView *viewBoxView = mutArray[i];
        if (i == 0 && !bEmail) {
            NSString * mobile = [GlobalObject isHaveAdd:_strCode];
            mobile = [NSString stringWithFormat:@"%@%@",mobile,viewBoxView.textField.text];
             [mutDic setValue:mobile forKey:array[i]];
            //[mutDic setValue:[GlobalObject isHaveAdd:_strCode] forKey:@"fomart"];//区号
            
        }
        else
        
        [mutDic setValue:viewBoxView.textField.text forKey:array[i]];
        
    }
    
    return mutDic;
}

/*获取提示*/
- (void)showPro:(int)intType
{
    switch (intType) {
        case 0:
        {
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter the correct phone number"] bSucc:NO];
            
        }
            break;
        case 1:
        {
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"please enter verification code"] bSucc:NO];
            
        }
            break;
        case 2:
        {
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter the correct password"] bSucc:NO];
            
        }
            break;
        default:
            break;
    }
}

/*修改 成功*/
- (void)regiSucc
{
    [self initData];
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    self.title = [GlobalObject getCurLanguage:@"Retrieve password"];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //设置文字颜色 大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16]}];
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
            // [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
             [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色
            // Fallback on earlier versions
        }
    
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
    [super viewWillDisappear:animated];
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
