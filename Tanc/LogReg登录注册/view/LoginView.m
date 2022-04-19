//
//  RegisteredView.m
//  Tanc
//
//  Created by f on 2019/12/4.
//  Copyright © 2019 f. All rights reserved.
//

#import "LoginView.h"


@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    _strCode = @"+57";//
    //测试
    //  _strCode = @"+966";
    
    CGRect rect = MY_RECT(26, 95 - 54, IPHONE6SWIDTH - 26 * 2, 54);
    _phoneTextfiel = [ AllInputBoxView createAllInput:rect bCode:YES];
    [self addSubview:_phoneTextfiel];
    [_phoneTextfiel.labPro setLabText:@"" strSec:[GlobalObject getCurLanguage:@"Phone number"] font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13]];
    _phoneTextfiel.textField.delegate = self;
    _phoneTextfiel.textField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextfiel.textField.text = @"";///@"13923435750";//
    [_phoneTextfiel.buttonCode addTarget:self action:@selector(clickCode) forControlEvents:UIControlEventTouchUpInside];
    
    //password
    rect = MY_RECT(26, 95, IPHONE6SWIDTH - 26 * 2, 54);
    _passTextfiel = [AllInputBoxView createAllInput:rect bCode:NO];
    [self addSubview:_passTextfiel];
    [_passTextfiel.labPro setLabText:@"" strSec:[GlobalObject getCurLanguage:@"Password"] font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13]];
    _passTextfiel.textField.text =  @"";//
    _passTextfiel.textField.delegate = self;
    _passTextfiel.textField.keyboardType = UIKeyboardTypeASCIICapable;
    _passTextfiel.textField.secureTextEntry = YES;
    
    [_phoneTextfiel updateTextUI];
    [_passTextfiel updateTextUI];
    //忘记密码
    rect = MY_RECT(232 - 10 - 30, 180, 107 + 20 + 30, 15);
    UIButton *buttonForPass = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:buttonForPass];
    [buttonForPass setTitle:[GlobalObject getCurLanguage:@"forget password?"] forState:UIControlStateNormal];
    [buttonForPass setTitleColor:[UIColor colorWithRed:99/255.0 green:177/255.0 blue:94/255.0 alpha:1.0] forState:UIControlStateNormal];
    buttonForPass.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
    [buttonForPass addTarget:self action:@selector(clickForPass) forControlEvents:UIControlEventTouchUpInside];
    
    //log
    rect = MY_RECT((IPHONE6SWIDTH - 284) / 2.0, 275, 284, 44);
    rect.size.height = rect.size.width / 284.0 * 44;
    UIView *viewBtnBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBtnBackgr];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:0x93/255.0 green:0xc1/255.0 blue:0x5f/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0x63/255.0 green:0xb1/255.0 blue:0x5e/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    
    [viewBtnBackgr.layer addSublayer:gl];
    viewBtnBackgr.shadowOpacity(0.7).shadowColor((UIColor *)[UIColor colorWithRed:99/255.0 green:177/255.0 blue:94/255.0 alpha:1.0]).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    
    
    UIButton *buttonLogin = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:buttonLogin];
    [buttonLogin setTitle:[GlobalObject getCurLanguage:@"log in"] forState:UIControlStateNormal];
    [buttonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonLogin.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    [buttonLogin addTarget:self action:@selector(clicklogin) forControlEvents:UIControlEventTouchUpInside];
    //    buttonLogin.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
    //    buttonLogin.shadowOpacity(0.7).shadowColor((UIColor *)AllColorShadow).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    
    //    rect = MY_RECT(321, 123, 19, 12);
    //    UIImageView *imageEyes = [[UIImageView alloc]initWithFrame:rect];
    //    [self addSubview:imageEyes];
    
    
    rect = MY_RECT(321 - 20, 123 - 15 - 53, 19 + 40, 12 + 30);
    UIButton *buttonEm = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:buttonEm];
//    [buttonEm setImage:[UIImage imageNamed:@"loginPas_show"] forState:UIControlStateNormal];
//    [buttonEm setImage:[UIImage imageNamed:@"loginPas_hidden"] forState:UIControlStateSelected];
    [buttonEm addTarget:self action:@selector(clickEm:) forControlEvents:UIControlEventTouchUpInside];
    [buttonEm setImage:[UIImage imageNamed:@"emailLogin"] forState:UIControlStateNormal];
    [buttonEm setImage:[UIImage imageNamed:@"phoneLogin"] forState:UIControlStateSelected];
   // buttonEm.center = CGPointMake(buttonEm.center.x,_phoneTextfiel.center.y);
    
    
    rect = MY_RECT(321 - 20, 123 - 15, 19 + 40, 12 + 30);
    UIButton *buttonEyes = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:buttonEyes];
    [buttonEyes setImage:[UIImage imageNamed:@"loginPas_show"] forState:UIControlStateNormal];
    [buttonEyes setImage:[UIImage imageNamed:@"loginPas_hidden"] forState:UIControlStateSelected];
    [buttonEyes addTarget:self action:@selector(clickEyes:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSArray *array = @[@"Sign in to read and agree to the",@"user agreement"];
    CGFloat floX = 0;
    
    rect = MY_RECT(0, 386 - 10, 0, 14);
    UIView *viewLabText = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewLabText];
    
    for (int i = 0; i< array.count; i ++) {
        
        NSString *str = [GlobalObject getCurLanguage:array[i]];
        UIFont *font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
        
        rect = MY_RECT(0, 0, 0, 14);
        rect.size.width = [GlobalObject widthOfString:str font:font];
        rect.origin.x = floX;
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [viewLabText addSubview:lab];
        lab.textColor = i == 0 ? [UIColor colorWithRed:188/255.0 green:190/255.0 blue:194/255.0 alpha:1.0] : [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        lab.font = font;
        lab.text = str;
        lab.textAlignment = NSTextAlignmentLeft;
        
        floX = floX + rect.size.width;
    }
    rect = MY_RECT(0, 386 - 10, 0, 14);
    rect.size.width = floX;
    rect.origin.x = (WIDTH - rect.size.width) / 2.0;
    viewLabText.frame = rect;
    
}

#pragma mark --- click
/*忘记密码*/
- (void)clickForPass
{
    [self StopInput];
    if (_delegate && [_delegate respondsToSelector:@selector(openForgetPassword)]) {
        [_delegate openForgetPassword];
    }
}

/*登录界面*/
- (void)clicklogin
{
//    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
//    [mutDic setValue:@"4235647728025682" forKey:@"card_number"];
//    [mutDic setValue:@"11" forKey:@"expiration_month"];
//    [mutDic setValue:@"2022" forKey:@"expiration_year"];
//    [mutDic setValue:@{@"name":@"APRO",@"identification":@{@"type":@"CC",@"number":@"12345678"}} forKey:@"cardholder"];
//    [mutDic setValue:@"123" forKey:@"security_code"];
//    //
//    [LoginView POST:@"https://api.mercadopago.com/v1/card_tokens?public_key=TEST-0cec2e72-de6a-43e6-b414-c238b553eba9" parameter:mutDic success:^(id responseObject) {
//        NSLog(@"");
//    } failure:^(NSError *error) {
//        NSLog(@"");
//    }];
//    return;
    
    [self StopInput];
    if ([_passTextfiel.textField.text length] <= 0) {
        
        NSString *str = !bEmail ? [GlobalObject getCurLanguage:@"Please enter the correct phone number"] : [GlobalObject getCurLanguage:@"please enter your vaild email"];
        
        [gAppDelegate showAlter:str bSucc:NO];
    }
    else if([_passTextfiel.textField.text length] <= 0)
    {
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter the correct password"] bSucc:NO];
    }
    else
    {
        [self requestLogin];
    }
}

- (void)clickCode
{
    if (_delegate && [_delegate respondsToSelector:@selector(openCode:)]) {
        [_delegate openCode:0];
    }
}

- (void)clickEyes:(UIButton *)btn
{   //[self StopInput];
    btn.selected = !btn.selected;
    _passTextfiel.textField.secureTextEntry = !btn.selected;
}

- (void)clickEm:(UIButton *)btn
{
    //NO 不是邮箱是电话号码。YES 是邮箱
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


#pragma mark ---textFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _phoneTextfiel.textField) {
        _phoneTextfiel.bEnter = YES;
        //   _passTextfiel.bEnter = YES;
        [_phoneTextfiel updateSeleUI:YES];
        [_passTextfiel updateSeleUI:NO];
        [_phoneTextfiel setAllinputViewState:YES];
    }
    else
    {
        [_phoneTextfiel updateSeleUI:!YES];
        [_passTextfiel updateSeleUI:!NO];
        
        [_passTextfiel setAllinputViewState:YES];
    }
    
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    AllInputBoxView *allInpView = (AllInputBoxView *)[textField superview];
    [allInpView updateSeleUI:NO];
    
    _phoneTextfiel.bEnter = !YES;
    _passTextfiel.bEnter = !YES;
    [_phoneTextfiel updateTextUI];
    [_passTextfiel updateTextUI];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != _passTextfiel  ||
        touch.view != _phoneTextfiel) {
        [self endAndUpdate];
    }
}

/*结束输入 并且更新*/
- (void)endAndUpdate
{
    _phoneTextfiel.bEnter = !YES;
    _passTextfiel.bEnter = !YES;
    
    [_phoneTextfiel.textField resignFirstResponder];
    [_passTextfiel.textField resignFirstResponder];
    
    [_phoneTextfiel updateSeleUI:NO];
    [_passTextfiel updateSeleUI:NO];
    
    [_phoneTextfiel updateTextUI];
    [_passTextfiel updateTextUI];
}

- (void)StopInput
{
    [_passTextfiel.textField resignFirstResponder];
    [_phoneTextfiel.textField resignFirstResponder];
    
}

#pragma mark ---request Login
/*注册*/
-(void)requestLogin
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:@"/UserApp/LoginAPI/login"];
    
    NSMutableDictionary *mutDic = [self getRegDic];
    
    [CLNetwork POST:str parameter:mutDic success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            [weakSelf loginSucc:responseObject];
            
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

- (NSMutableDictionary *)getRegDic
{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
 
  
    
    if (bEmail) {
        [mutDic setValue:_phoneTextfiel.textField.text forKey:@"mail"];
        //[mutDic setValue:[GlobalObject isHaveAdd:_strCode] forKey:@"fomart"];
    }
    else
    {
        NSString * mobile = [GlobalObject isHaveAdd:_strCode];
        mobile = [NSString stringWithFormat:@"%@%@",mobile,_phoneTextfiel.textField.text];
        [mutDic setValue:mobile forKey:@"mobile"];
    }
    
    
    [mutDic setValue:@"" forKey:@"latitude"];
    [mutDic setValue:@"" forKey:@"longitude"];
    [mutDic setValue:_passTextfiel.textField.text forKey:@"pwd"];
    
    return mutDic;
}


- (void)loginSucc:(NSDictionary *)data
{
    [GlobalObject shareObject].toKenSear = data[@"ptoKen"];
        [GlobalObject shareObject].openid = data[@"openid"];
    
    
    [[GlobalObject shareObject] addUserAccountShare:data[@"ptoKen"]];
    
    if (_delegate && [_delegate respondsToSelector:@selector(openLoginSucc)]) {
        [_delegate openLoginSucc];
    }
}


+ (void)POST:(NSString *)strURL parameter:(NSDictionary *)para success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSURL *nsurl = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //如果想要设置网络超时的时间的话，可以使用下面的方法：
//     NSMutableURLRequest *mutableRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:strURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //设置请求类型
    request.HTTPMethod = @"POST";
    
    //将需要的信息放入请求头 随便定义了几个
     [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
     [request setValue:@"no-cache" forHTTPHeaderField:@"cache-control"];
   // [request setValue:@" no-cache" forHTTPHeaderField:@"application/json"];
   
    
    NSString *paramString = [CLNetwork convertToJsonData:para];
    [request setValue:@"ba1d98a7-da48-4a71-9503-05372ba74a02" forHTTPHeaderField:@"Postman-Token"];
    //把参数放到请求体内
    request.HTTPBody = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            //请求失败
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (failure) {
                    failure(error);
                }
            }];
            
        } else {  //请求成功
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                
               if ([[result allKeys]containsObject:@"code"]  &&
                  ( [ result[@"code"] intValue] == -1   ) && [GlobalObject shareObject].toKenSear && [[GlobalObject shareObject].toKenSear length]> 0 )
               {
                   [gAppDelegate  removeActivityView];
                   [gAppDelegate popViewController];
//
                   [gAppDelegate showAlter:result[@"msg"] bSucc:NO];
               }
               else
               {
                   success(result);
               }
            }];
        }
    }];
    [dataTask resume];  //开始请求
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
