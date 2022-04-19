//
//  AddCreditCardViewController.m
//  Tanc
//
//  Created by f on 2019/12/26.
//  Copyright © 2019 f. All rights reserved.
//添加银行卡

#import "AddCreditCardViewController.h"
#import "AllInputBoxView.h"
#import "Conekta.h"
#import "MercadoPago.h"
#import "MPCard.h"
#import "AreaCodeViewController.h"


@interface AddCreditCardViewController ()<UITextFieldDelegate,AreaCodeViewDelegate>
{
    NSMutableArray *mutArray;
    NSString *cardholderIDNumberTit;
    NSString *cardholderIDNumberCon;
    NSArray *arrayCC;
     
    AllInputBoxView *temporaryAllInputBoxView;//临时
    CGRect temporaryRect;
    
    UIView *textFieldView;//
    UILabel *labText;
}

@property (nonatomic,strong)NSString *strCode;
@end

@implementation AddCreditCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    _strCode = @"+57";//
    cardholderIDNumberTit = @"C.C.";
    cardholderIDNumberCon = @"CC";
    mutArray = [NSMutableArray array];
    self.title = CurLanguageCon(@"Add credit card");
    
    [self initUI];
    
    [self initTextField];
    
    [self addNotification];
    
    [super setBtnGOHiddenNO];
    // Do any additional setup after loading the view.
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initUI
{//165- 118 = 47
    CGRect rect = MY_RECT(14.5, 79 - PhoneHeight, 345.5, 118);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgr];
    viewBackgr.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
    viewBackgr.shadowOpacity(0.7).shadowColor([UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:0.38]).shadowRadius(7).shadowOffset(CGSizeMake(0, 7)).conrnerRadius(5).conrnerCorner(UIRectCornerAllCorners).showVisual();
    
    rect = CGRectMake(0,0,CGRectGetWidth(viewBackgr.frame),CGRectGetHeight(viewBackgr.frame));
    UIView *viewBackgrSec = [[UIView alloc]initWithFrame:rect];
    [viewBackgr addSubview:viewBackgrSec];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,CGRectGetWidth(viewBackgr.frame),CGRectGetHeight(viewBackgr.frame));
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:147/255.0 green:193/255.0 blue:95/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    
    [viewBackgrSec.layer addSublayer:gl];
    
    
    rect = MY_RECT(19, 20, 160, 8);
    UILabel *labCar = [[UILabel alloc]initWithFrame:rect];
    [viewBackgrSec addSubview:labCar];
    labCar.textColor = [UIColor whiteColor];
    labCar.textAlignment = NSTextAlignmentLeft;
    labCar.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10];
    labCar.text = CurLanguageCon(@"Card number");
    
    rect = MY_RECT(19, 36, 270, 13);
    UILabel *_labNumber = [[UILabel alloc]initWithFrame:rect];
    [viewBackgrSec addSubview:_labNumber];
    _labNumber.text = CurLanguageCon(@"Please enter the card number");
    _labNumber.textColor = [UIColor whiteColor];
    _labNumber.textAlignment = NSTextAlignmentLeft;
    _labNumber.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    
    rect = MY_RECT(281, 20, 44, 44);
    rect.size.width = rect.size.height;
    UIImageView *_imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgrSec addSubview:_imageIcon];
    [_imageIcon qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    _imageIcon.image = [UIImage imageNamed:@"defIconCreditCard"];
    
    rect = MY_RECT(19, 67, 270, 12);
    UILabel *labExp = [[UILabel alloc]initWithFrame:rect];
    [viewBackgrSec addSubview:labExp];
    labExp.text = CurLanguageCon(@"Expiration date");
    labExp.textColor = [UIColor whiteColor];
    labExp.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10];
       labExp.textAlignment = NSTextAlignmentLeft;
    //
    rect = MY_RECT(19, 82, 320, 15);
    UILabel * _labMon = [[UILabel alloc]initWithFrame:rect];
    [viewBackgrSec addSubview:_labMon];
    _labMon.text = CurLanguageCon(@"Please enter a validity period");
    _labMon.textColor = [UIColor whiteColor];
    _labMon.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    _labMon.textAlignment = NSTextAlignmentLeft;
    
    
    
}

- (void)createCC
{
    //
    //    arrayCC = @[@{@"content":@"CC",@"name":@"C.C."},
    //                       @{@"content":@"CE",@"name":@"C.E."},
    //                       @{@"content":@"NIT",@"name":@"NIT"},
    //                       @{@"content":@"Otro",@"name":@"Otro"}];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[GlobalObject getCurLanguage:@"Please select identity type"] preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"C.C." style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //      self->cardholderIDNumberCon = @"CC";
        [self updateCC:@"CC" title:@"C.C."];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"C.E." style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        self->cardholderIDNumberCon = @"CE";
        [self updateCC:@"CE" title:@"C.E."];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"NIT" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //        self->cardholderIDNumberCon = @"NIT";
        [self updateCC:@"NIT" title:@"NIT"];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Otro" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // self->cardholderIDNumberCon = @"Otro";
        [self updateCC:@"Otro" title:@"Otro"];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)updateCC:(NSString *)str title:(NSString *)strTitle
{
    cardholderIDNumberCon = str;
    AllInputBoxView *_passTextfiel = mutArray[4];
    [_passTextfiel.buttonCode setTitle:strTitle forState:UIControlStateNormal];
    // _passTextfiel.textField.text = str;
}



- (void)initTextField
{
    NSArray *array = @[@"Cardholder's Name",@"Card number",@"Expiration date（MM/AA）",@"Security code",@"Cardholder ID Number",@"Phone number",@"E-mail"];
   //NSArray *arrayTest = @[@"JUAN SAMACA",@"5303730265884515",@"09/24",@"715",@"7321582",@"3209388763",@"jusam_86@hotmail.com"];
    for (int i = 0; i < array.count; i ++) {
        CGRect  rect = MY_RECT(26, 276 - 64 - PhoneHeight + i * 54 - 10, IPHONE6SWIDTH - 26 * 2, 54);
        rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
        BOOL bCod = i == 5 || i == 4 ? YES : NO;
        
        AllInputBoxView *_passTextfiel = [AllInputBoxView createAllInput:rect bCode:bCod];
        [self.view addSubview:_passTextfiel];
        [_passTextfiel.labPro setLabText:@"" strSec:[GlobalObject getCurLanguage:array[i]] font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13]];
        _passTextfiel.textField.text =  @"";//arrayTest[i];//
        _passTextfiel.textField.delegate = self;
        _passTextfiel.textField.keyboardType = i != 0 && i != 6 ? UIKeyboardTypePhonePad : UIKeyboardTypeASCIICapable;
        [_passTextfiel updateTextUI];
        
        [mutArray addObject:_passTextfiel];
        
        if(i == 5)
        {
            [_passTextfiel.buttonCode addTarget:self action:@selector(clickCode) forControlEvents:UIControlEventTouchUpInside];
        }
        else if(i == 4)
        {
            [_passTextfiel.buttonCode addTarget:self action:@selector(clickCardholder) forControlEvents:UIControlEventTouchUpInside];
            [_passTextfiel.buttonCode setTitle:@"C.C." forState:UIControlStateNormal];
        }
        
        //  _passTextfiel.textField.text = arrayTest[i];
    }
    
    
    
    CGRect  rect = MY_RECT((IPHONE6SWIDTH - 164) / 2.0, 588 - PhoneHeight, 164, 44);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    rect.size.height = rect.size.width / 164.0 * 44;
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
    UIButton *buttonLogin = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonLogin];
    [buttonLogin setTitle:[GlobalObject getCurLanguage:@"Confirm"] forState:UIControlStateNormal];
    [buttonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonLogin.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
    [buttonLogin addTarget:self action:@selector(clickConfirm) forControlEvents:UIControlEventTouchUpInside];
    
    rect = MY_RECT((IPHONE6SWIDTH - 250) / 2.0, IPHONE6SHEIGHT, 250, 50);
    textFieldView = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:textFieldView];
    
    gl = [CAGradientLayer layer];
      gl.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
      gl.startPoint = CGPointMake(0, 0);
      gl.endPoint = CGPointMake(1, 1);
      gl.colors = @[(__bridge id)[UIColor colorWithRed:0x93/255.0 green:0xc1/255.0 blue:0x5f/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0x63/255.0 green:0xb1/255.0 blue:0x5e/255.0 alpha:1.0].CGColor];
      gl.locations = @[@(0.0),@(1.0)];
      
      [textFieldView.layer addSublayer:gl];
    
    
    
    [textFieldView qi_clipCorners:UIRectCornerAllCorners radius:5];
    
    rect = MY_RECT(15, 0, 200, 50);
   labText = [[UILabel alloc]initWithFrame:rect];
    [textFieldView addSubview:labText];
    labText.textColor = [UIColor blackColor];
    labText.textAlignment = NSTextAlignmentLeft;
    labText.font =[GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
   
}

- (void)updateAreaCode:(NSString *)strNumb
{
    AllInputBoxView *allInputBoxView = mutArray[5];
    [allInputBoxView.buttonCode setTitle:strNumb forState:UIControlStateNormal];
    _strCode = strNumb;
}

#pragma mark ---click

- (void)clickCardholder
{//持卡人身份证
    [self createCC];
}

- (void)clickCode
{
    AreaCodeViewController *viewController = [[AreaCodeViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.delegate = self;
}


- (void)clickConfirm
{//点击
    
    NSDictionary *dic = [self getRequestDic];
    
    if (!dic) {
        return;
    }
    //@[@"name",@"cardNumber",@"monYear",@"secuCode",@"tipo",@"phone",@"email"];
    NSArray *arrat = [dic[@"monYear"] componentsSeparatedByString:@"/"];
//    MPCard *_card = [[MPCard alloc]init];
//    _card.cardNumber = dic[@"cardNumber"];
//    _card.expirationMonth = [NSNumber numberWithInt:[arrat.firstObject intValue]];
//    _card.expirationYear = [NSNumber numberWithInt:[arrat.lastObject intValue]];
//    _card.securityCode = dic[@"secuCode"];
//    _card.cardholderName = dic[@"name"];
//
//    _card.cardholderIDNumber = dic[@"tipo"];;
//
//    _card.cardholderIDType = cardholderIDNumberCon;
    
    //Depends on the country. See MPUtils.h for possible values
    //card.cardholderIDSubType = @"J"; //Only for Venezuela. See MPUtils for possible values
    //Now post the information to MercadoPago to create a Card Token.
    //    [MercadoPago createTokenWithCard:_card
    //                           onSuccess:^(MPCardToken *tokenResponse){
    //        NSLog(@"Success creating token, response is %@",tokenResponse);
    //        //  NSString *result = [NSString stringWithFormat:@"Info posted ok! response = %@",tokenResponse];
    //        //always update UI in main queue
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //
    //            [self requestAddBank:tokenResponse.tokenId];
    //            // [resultController setResultInfo:result];
    //        });
    //        //TODO: your code here.
    //        //send token, installments, customer email, etc. to your server
    //    }
    //                           onFailure:^(NSError *error){
    //        NSLog(@"Error creating token: %@",error);
    //        NSString *result = [NSString stringWithFormat:@"Error! %@",error];
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [gAppDelegate showAlter:result  bSucc:NO];
    //            //[resultController setResultInfo:result];
    //        });
    //    }
    //     ];
    
    
    NSString *expiration_year= arrat.lastObject;
    if (expiration_year  && [expiration_year intValue] < 100) {

        expiration_year = [NSString stringWithFormat:@"20%d",[expiration_year intValue]];
    }
    
    [gAppDelegate createActivityView];
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setValue:dic[@"cardNumber"] forKey:@"card_number"];
    [mutDic setValue:arrat.firstObject forKey:@"expiration_month"];
    [mutDic setValue:expiration_year forKey:@"expiration_year"];
    [mutDic setValue:@{@"name":dic[@"name"],@"identification":@{@"type":cardholderIDNumberCon,@"number":dic[@"tipo"]}} forKey:@"cardholder"];
    [mutDic setValue:dic[@"secuCode"] forKey:@"security_code"];
    //TEST-0cec2e72-de6a-43e6-b414-c238b553eba9
    [AddCreditCardViewController POST:@"https://api.mercadopago.com/v1/card_tokens?public_key=APP_USR-1701a76a-89e1-40ad-9da6-a5ac6ef4e90e" parameter:mutDic success:^(id responseObject) {
        
        if ([[responseObject allKeys] containsObject:@"id"] && [responseObject[@"id"] length] > 0) {
           [self requestAddBank:responseObject[@"id"]];
        }
        else
        {
             [gAppDelegate showAlter:responseObject[@"message"] bSucc:NO];
            [gAppDelegate removeActivityView];
        }
        
        
        
        
    } failure:^(NSError *error) {
        
        [gAppDelegate showAlter:@"Failed to add bank card" bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
    
    
    
}

- (NSDictionary *)getRequestDic
{
    int notSele = -1;
    NSArray *array = @[@"name",@"cardNumber",@"monYear",@"secuCode",@"tipo",@"phone",@"email"];
    NSMutableDictionary *mutDic = nil;
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        if ([view.textField.text length] <= 0) {
            notSele = i;
            break;
        }
        else
        {
            if (!mutDic) {
                mutDic = [NSMutableDictionary dictionary];
            }
            
            [mutDic setValue:view.textField.text forKey:array[i]];
        }
    }
    
    switch (notSele) {
        case 0:
        {
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter the correct cardholder name"] bSucc:NO];
        }
            break;
        case 1:
        {
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter the correct bank card number"] bSucc:NO];
        }
            break;
        case 2:
        {
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter the correct expiration date"] bSucc:NO];
        }
            break;
        case 3:
        {
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter the correct security code"] bSucc:NO];
        }
            break;
        case 4:
        {
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter the cardholder ID number"] bSucc:NO];
        }
            break;
            
        case 5:
        {
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter the correct phone number"] bSucc:NO];
        }
            break;
            
        case 6:
        {
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"please enter your vaild email"] bSucc:NO];
        }
            break;
            
        default:
            break;
    }
    if (notSele != -1) {
        return nil;
    }
    
    return mutDic;
}



#pragma mark ---textFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        if (view.textField == textField) {
            [view updateSeleUI:YES];
            [view setAllinputViewState:YES];
        }
        else{
            [view updateSeleUI:!YES];
        }
    }
    
    labText.text = textField.text;
    
//    temporaryAllInputBoxView = textField.superview;
//
//    temporaryRect = temporaryAllInputBoxView.frame;
    //    AllInputBoxView *_passTextfiel = mutArray[4];
    // _passTextfiel.textField
    //    if (_passTextfiel.textField == textField) {
    //
    //        //出现弹窗
    //        return NO;
    //    }
    
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * textfieldContent = [textField.text stringByReplacingCharactersInRange:range withString:string];
    AllInputBoxView *allInputBoxView = mutArray[2];
    
    if (textField == allInputBoxView.textField  &&[textfieldContent length] > 7) {
        return NO;
    }
    else if(textField == allInputBoxView.textField  &&[textfieldContent length] == 3 && ![textfieldContent containsString:@"/"])
    {
        textField.text = [textField.text stringByAppendingString:@"/"];
        textField.text = [textField.text stringByAppendingString:string];
        labText.text = textField.text;
        return NO;
    }
    else  if (textField == allInputBoxView.textField  && [textfieldContent length] == 2 && !([string length] == 0)) {
        
        textField.text = [textfieldContent stringByAppendingString:@"/"];
        labText.text = textField.text;
        
        return NO;
    }
    
    labText.text = textfieldContent;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        if (view.textField == textField) {
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
            
            [view.textField resignFirstResponder];
            [view updateSeleUI:NO];
            [view updateTextUI];
        }
    }
}

/*停止键盘输入*/
- (void)StopInput
{
    for (int i = 0; i < mutArray.count; i ++) {
        AllInputBoxView *view = mutArray[i];
        [view.textField resignFirstResponder];
        
    }
}

- (void)keyboardShow:(NSNotification *)aNotification
{
 
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    CGRect rect = textFieldView.frame;
    
    rect.origin.y = HEIGHT - keyboardHeight - rect.size.height;
    [UIView animateWithDuration:0.2 animations:^{
        self->textFieldView.frame = rect;
    }];
 
}

-(void)keyboardHide:(NSNotification *)aNotification
{
    
    CGRect rect = textFieldView.frame;
      
      rect.origin.y = HEIGHT;
      [UIView animateWithDuration:0.2 animations:^{
          self->textFieldView.frame = rect;
      }];
    
//    NSTimeInterval animalInterval=[[[aNotification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    [UIView beginAnimations:@"keyboardshow" context:nil];
//    [UIView setAnimationDuration:animalInterval];
//    self.view.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
//    [UIView commitAnimations];
}


-(void)requestAddBank:(NSString *)token
{
    
    AllInputBoxView *allInputBoxView = mutArray[5];
    AllInputBoxView *emailAllInputBoxView = mutArray.lastObject;
    NSString * mobile = [GlobalObject isHaveAdd:_strCode];
    
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:[NSString stringWithFormat:@"/UserApp/User/addCard/%@?code=%@&phone=%@&email=%@",token,mobile,allInputBoxView.textField.text,emailAllInputBoxView.textField.text]];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            [weakSelf addSuccUpdateUI:responseObject[@"data"]];
            
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

- (void)addSuccUpdateUI:(NSString *)bankID
{
    if (_addCareditCardType == 1 || _addCareditCardType == 2 ) {
        if (_delegate && [_delegate respondsToSelector:@selector(addBankID:)]) {
            [_delegate addBankID:bankID];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
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
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
