//
//  RegisteredView.m
//  Tanc
//
//  Created by f on 2019/12/4.
//  Copyright © 2019 f. All rights reserved.
//

#import "RegisteredView.h"

@implementation RegisteredView

- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        mutArray = [NSMutableArray array];
        [self initUI];
        
        
        
        [self addNotification];
    }
    return self;
}
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];//进入前台
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];//今日后台
}

- (void)initUI
{
    CGFloat floCentY = 0.0;
    _strCode = @"+57";
    NSArray *array = @[@"Phone number",@"Verification code",@"Password",@"Mailbox"];
    //,@"Share code"
    for (int i = 0; i < array.count; i ++) {
        
        CGRect rect = MY_RECT(29, 87 - 54 + 54 * i, IPHONE6SWIDTH - 29 * 2, 54);
        BOOL bCode = i == 0  ? YES : NO;
        AllInputBoxView *allInputView = [AllInputBoxView createAllInput:rect bCode:bCode];
        [self addSubview:allInputView];
        
        allInputView.textField.delegate = self;
        allInputView.textField.keyboardType = i == 0 ? UIKeyboardTypeNumberPad : UIKeyboardTypeASCIICapable;
        
        if (i == 0)
        {
            floCentY = allInputView.center.y;
            [allInputView.buttonCode addTarget:self action:@selector(clickCode) forControlEvents:UIControlEventTouchUpInside];
            
            //验证码
        }
        else if(i == 2)
        {//眼睛
            allInputView.textField.secureTextEntry = YES;
        }
        
        NSString *str = i == array.count - 1 ? @"" : @"*";
        
        [allInputView.labPro setLabText:str strSec:[GlobalObject getCurLanguage:array[i]] font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13]];
        //测试
//        if(i ==3)
//        {
//            allInputView.textField.text = @"tafrijapowerbank@gmail.com";
//        }
        
        [mutArray addObject:allInputView];
    }
    
    CGRect rect = MY_RECT(321, 173, 19, 12);
    UIImageView *imageEyes = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:imageEyes];
    
    rect = MY_RECT(321 - 20, 173 - 15 - 53.5 * 2, 19 + 40, 12 + 30);
    UIButton *buttonEmail = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:buttonEmail];
//    [buttonEmail setImage:[UIImage imageNamed:@"loginPas_show"] forState:UIControlStateNormal];
//    [buttonEmail setImage:[UIImage imageNamed:@"loginPas_hidden"] forState:UIControlStateSelected];
    [buttonEmail addTarget:self action:@selector(clickEmail:) forControlEvents:UIControlEventTouchUpInside];
    [buttonEmail setImage:[UIImage imageNamed:@"emailLogin"] forState:UIControlStateNormal];
      [buttonEmail setImage:[UIImage imageNamed:@"phoneLogin"] forState:UIControlStateSelected];
     // buttonEmail.center = CGPointMake(buttonEmail.center.x,floCentY);
    
    rect = MY_RECT(321 - 20, 173 - 15, 19 + 40, 12 + 30);
    UIButton *buttonEyes = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:buttonEyes];
    [buttonEyes setImage:[UIImage imageNamed:@"loginPas_show"] forState:UIControlStateNormal];
    [buttonEyes setImage:[UIImage imageNamed:@"loginPas_hidden"] forState:UIControlStateSelected];
    [buttonEyes addTarget:self action:@selector(clickEyes:) forControlEvents:UIControlEventTouchUpInside];
    
    rect = MY_RECT(0, 330, IPHONE6SWIDTH, 14);
    UILabel *labPro = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:labPro];//
    labPro.numberOfLines = 0;
    labPro.text = [GlobalObject getCurLanguage:@"Note: Items marked with * are required"];
    labPro.textAlignment = NSTextAlignmentCenter;
    labPro.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
    labPro.textColor = [UIColor colorWithRed:99/255.0 green:177/255.0 blue:94/255.0 alpha:1.0];
    
    rect = MY_RECT(267 - 8, 104, 78.5 + 8, 26.5);
    buttonSend = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:buttonSend];
    [buttonSend setTitle:[GlobalObject getCurLanguage:@"verification code"] forState:UIControlStateNormal];
    
    [buttonSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonSend.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10];
    [buttonSend addTarget:self action:@selector(clickSend) forControlEvents:UIControlEventTouchUpInside];
    buttonSend.backgroundColor =  [UIColor colorWithRed:99/255.0 green:177/255.0 blue:94/255.0 alpha:1.0];
    [buttonSend qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    buttonSend.titleLabel.numberOfLines = 0;
    
    //注册
    rect = MY_RECT((IPHONE6SWIDTH - 284) / 2.0, 356, 284, 44);
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
    [buttonLogin setTitle:[GlobalObject getCurLanguage:@"registered"] forState:UIControlStateNormal];
    [buttonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonLogin.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    [buttonLogin addTarget:self action:@selector(clickRegistered) forControlEvents:UIControlEventTouchUpInside];
    //    buttonLogin.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
    //    buttonLogin.shadowOpacity(0.7).shadowColor((UIColor *)AllColorShadow).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
}

#pragma mark --- click

- (void)clickCode
{
    [self StopInput];
    if (_delegate && [_delegate respondsToSelector:@selector(openCode:)]) {
        [_delegate openCode:1];
    }
}

- (void)clickSend
{
    [self StopInput];
    AllInputBoxView *phoneView = mutArray.firstObject;
    if ([phoneView.textField.text length] <= 0) {
        
        NSString *str = !bEmail ? [GlobalObject getCurLanguage:@"Please enter the correct phone number"] : [GlobalObject getCurLanguage:@"please enter your vaild email"];
        
        [gAppDelegate showAlter:str bSucc:NO];
        return;
    }
    
    buttonSend.userInteractionEnabled = YES;
    
    [self requestSendCode:@""];
}

/*注册界面*/
- (void)clickRegistered
{
    [self StopInput];
    BOOL bShow = NO;
    for (int i = 0; i < mutArray.count - 1; i ++) {
        
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

- (void)clickEyes:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    AllInputBoxView *view = mutArray[2];
    
    view.textField.secureTextEntry = !btn.selected;
    
    [self StopInput];
    
}

- (void)clickEmail:(UIButton *)btn
{
    //NO 不是邮箱是电话号码。YES 是邮箱
    btn.selected = !btn.selected;
    AllInputBoxView *_phoneTextfiel = mutArray[0];
    [_phoneTextfiel setEmail:btn.selected];
    
    bEmail = btn.selected;
    NSString *strF = @"*";
    if (!btn.selected) {
        
        _phoneTextfiel.textField.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneTextfiel.labPro setLabText:strF strSec:[GlobalObject getCurLanguage:@"Phone number"] font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13]];
    }
    else
    {
        [_phoneTextfiel.labPro setLabText:strF strSec:[GlobalObject getCurLanguage:@"Mailbox"] font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13]];
        _phoneTextfiel.textField.keyboardType = UIKeyboardTypeASCIICapable;
    }
    [_phoneTextfiel.textField resignFirstResponder];
    
    [_phoneTextfiel.textField becomeFirstResponder];
    
}


- (void)showPro:(int)intType
{
    switch (intType) {
        case 0:
        {
            if (bEmail) {
                [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"please input your email"] bSucc:NO];
            }
            else
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
        case 3:
        {
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"please input your email"] bSucc:NO];
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark ---textFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSInteger curView = -1;
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        if (view.textField == textField) {
            curView = i;
            [view updateSeleUI:YES];
            [view setAllinputViewState:YES];
        }
        else{
            [view updateSeleUI:!YES];
        }
    }
    AllInputBoxView *view = mutArray[0];
    if (curView == 0) {
        
        view.bEnter = YES;
    }
    else
    {
        view.bEnter = !YES;
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSInteger curView = -1;
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        if (view.textField == textField) {
            curView = i;
            [view updateSeleUI:NO];
        }
        [view updateTextUI];
    }
    
    AllInputBoxView *view = mutArray[0];
    if (curView == 0) {
        
        view.bEnter = YES;
    }
    else
    {
        view.bEnter = !YES;
    }
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    AllInputBoxView *allInputBoxView = mutArray.firstObject;
    if (bEmail && (textField == allInputBoxView.textField)) {
        NSString * textfieldContent = [textField.text stringByReplacingCharactersInRange:range withString:string];
        AllInputBoxView *allInputBoxView = mutArray.lastObject;
        allInputBoxView.textField.text = textfieldContent;
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
    
    AllInputBoxView *view = mutArray[0];
    
    view.bEnter = NO;
    
    if (!bSele) {
        for (int i = 0; i < mutArray.count; i ++) {
            AllInputBoxView *view = mutArray[i];
            
            [view.textField resignFirstResponder];
            [view updateSeleUI:NO];
            [view updateTextUI];
        }
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


/*停止键盘输入*/
- (void)StopInput
{
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        if (i == 0) {
            view.bEnter = NO;
        }
        [view.textField resignFirstResponder];
        
    }
}

- (void)initData
{
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        view.textField.text = @"";
        [view.textField resignFirstResponder];
        [view updateSeleUI:NO];
        [view updateTextUI];
        
    }
    
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    numberTime = 0;
    
    NSString *str =  CurLanguageCon(@"verification code")
    [buttonSend setTitle:str forState:UIControlStateNormal];
    buttonSend.userInteractionEnabled = YES;
}


- (void)setCode:(NSString *)strCode
{
    AllInputBoxView *view = mutArray.firstObject;
    [view.buttonCode setTitle:strCode forState:UIControlStateNormal];
    _strCode = strCode;
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

/*发送短信*/
-(void)requestSendCode:(NSString *)strr
{
    AllInputBoxView *allInpView=  mutArray.firstObject;
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    
    NSString * mobile = [GlobalObject isHaveAdd:_strCode];
    mobile = [NSString stringWithFormat:@"%@%@",mobile,allInpView.textField.text];
    NSString *str = [ChargingApi stringByAppendingString:@"/UserApp/LoginAPI/sendsmg"];
    NSDictionary *dic = @{@"code_type":@"1",
                          @"mobile":mobile
    };//3162221175 //
    if (bEmail) {
        
        str = [ChargingApi stringByAppendingString:@"/UserApp/LoginAPI/sendMailMsg"];
        dic = @{@"code_type":@"1",
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

/*注册*/
-(void)requestRegi
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:@"/UserApp/LoginAPI/register"];
    
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

/*注册成功*/
- (void)regiSucc
{
    [self initData];
    
    if (_delegate && [_delegate respondsToSelector:@selector(goBackLogin)]) {
        [_delegate goBackLogin];
    }
}

- (NSMutableDictionary *)getRegDic
{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    NSString *strMobi = bEmail ? @"email": @"mobile";
    NSArray *array = @[strMobi,@"code",@"pwd",@"email"];
    if (bEmail) {
        array =  @[strMobi,@"code",@"pwd"];
    }
    for (int i = 0; i < array.count; i ++)
    {
        AllInputBoxView *viewBoxView = mutArray[i];
        if (i == 0 && !bEmail) {
            NSString * mobile = [GlobalObject isHaveAdd:_strCode];
            mobile = [NSString stringWithFormat:@"%@%@",mobile,viewBoxView.textField.text];
            [mutDic setValue:mobile forKey:array[i]];
             //  [mutDic setValue:mobile forKey:@"areaCode"];
        }
        else
            [mutDic setValue:viewBoxView.textField.text forKey:array[i]];
        
    }
    strMobi = bEmail ? @"2": @"1";
    [mutDic setValue:strMobi forKey:@"type"];//区号
    return mutDic;
}

/*结束输入 并且更新*/
- (void)endAndUpdate
{
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        
        [view.textField resignFirstResponder];
        [view updateSeleUI:NO];
        [view updateTextUI];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
