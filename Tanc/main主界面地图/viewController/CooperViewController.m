//
//  CooperViewController.m
//  Tanc
//
//  Created by f on 2019/12/10.
//  Copyright © 2019 f. All rights reserved.
//

#import "CooperViewController.h"
#import "WSPlaceholderTextView.h"

@interface CooperViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
      WSPlaceholderTextView *textViewHelp;
    
    NSMutableArray *mutArray;
}
@end

@implementation CooperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    mutArray = [NSMutableArray array];
    
    [self initUI];
    
  
    
    [super setBtnGOHiddenNO];
    // Do any additional setup after loading the view.
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initUI
{
    
    CGRect rect = MY_RECT(0, 0, IPHONE6SWIDTH, 134.5);
    // rect.size.height = IPHONE6SWIDTH / WIDTH * 134.5;
    rect.origin.y = GetRectNavAndStatusHight;
    UIImageView *imageTop = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageTop];
    imageTop.image = [UIImage imageNamed:@"Cooperative_advertising"];
    
    CGFloat floY = GetRectNavAndStatusHight + rect.size.height;
    rect = MY_RECT(33, 24, 160, 22.5);
    rect.origin.y = rect.origin.y + floY;
    UILabel *labCoopTit = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:labCoopTit];
    labCoopTit.font = [GlobalObject getAvenirFontEnumType:Avenir_Black fontSize:21];;
    labCoopTit.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    labCoopTit.textAlignment = NSTextAlignmentLeft;
    labCoopTit.text = CurLanguageCon(@"Cooperation");
    
    floY = rect.origin.y + rect.size.height;
    
    rect = MY_RECT(33, 14, 305, 36);
    rect.origin.y = rect.origin.y + floY;
    UILabel *lab = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:lab];;
    lab.numberOfLines = 0;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:12];
    lab.text = CurLanguageCon(@"Is willing to cooperate with you for a win-win si-tuation and create unlimited possibilities forth-e future");
    lab.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    
    floY = rect.origin.y + rect.size.height;
    
    rect = MY_RECT(33, 13, 326, 0.5);
    rect.origin.y = rect.origin.y + floY;
    UIView *viewLine = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewLine];
    viewLine.backgroundColor = [UIColor colorWithRed:227 / 255.0 green:227 / 255.0 blue:227 / 255.0 alpha:1];
    
    floY = rect.origin.y + rect.size.height;
    
    rect = MY_RECT(0, 15, 347, 251);
    rect.origin.y = rect.origin.y + floY;
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgr];
    viewBackgr.backgroundColor = [UIColor colorWithRed:249/255.0 green:255/255.0 blue:249/255.0 alpha:1.0];
    [viewBackgr qi_clipCorners:UIRectCornerTopRight | UIRectCornerBottomRight radius:20];
    
    floY = rect.origin.y + rect.size.height;
    
    
    NSArray *array = @[@"Shop name",@"Contact person",@"phone",@"cooperative contents",
                       @"Please enter a shop name",@"Please enter a contact",@"Please enter your phone number",@"Please enter the information you want to cooperate with"];
    
    
    for (int i = 0; i < array.count / 2.0; i ++) {
        
        CGFloat floCurHei = i == 3 ? 42 + 15 + 15 : 42 + 15;//18 / IPHONE6SHEIGHT * HEIGHT;
        rect = MY_RECT(0, (42 + 15) * i, 347, floCurHei);
        UIView *view = [[UIView alloc]initWithFrame:rect];
        [viewBackgr addSubview:view];
        
        rect = MY_RECT(33, 18, 190, 13);
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [view addSubview:lab];
        lab.textColor = [UIColor colorWithRed:29/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];
        lab.text = CurLanguageCon(array[i]);
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:12];
        lab.textAlignment = NSTextAlignmentLeft;
        
        
        floCurHei = i == 3 ? 15 + 15 : 15;
        rect = MY_RECT(33, 38, 289, floCurHei);
        if (i == 3) {
            textViewHelp = [[WSPlaceholderTextView alloc]initWithFrame:rect];
            textViewHelp.placeholder = CurLanguageCon(array[i + 4]);
            textViewHelp.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:14];
            textViewHelp.textColor = lab.textColor;
            textViewHelp.delegate = self;
            textViewHelp.backgroundColor = [UIColor clearColor];
            [view addSubview:textViewHelp];
            
             [mutArray addObject:textViewHelp];
        }
        else
        {
            UITextField *textField = [[UITextField alloc]initWithFrame:rect];
            [view addSubview:textField];
            textField.placeholder = CurLanguageCon(array[i + 4]);
            textField.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:14];
            textField.textColor = lab.textColor;
            textField.delegate = self;
            [mutArray addObject:textField];
            textField.keyboardType = i == 2 ? UIKeyboardTypeNumberPad : UIKeyboardTypeASCIICapable;
        }
    }
    
    rect = MY_RECT(45, 29, 285, 44);
    rect.origin.y = rect.origin.y + floY;
    
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
    
    
    UIButton *buttonOK = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonOK];
    [buttonOK setTitle:[GlobalObject getCurLanguage:@"submit"] forState:UIControlStateNormal];
    [buttonOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonOK.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
//    buttonOK.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
//    buttonOK.shadowOpacity(0.7).shadowColor((UIColor *)AllColorShadow).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    [buttonOK addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
   
}


#pragma mark ---click
- (void)click
{
   NSMutableDictionary *mutDic = [self getRegDic];
    if ( mutDic && mutDic.count > 0) {
        [self requestCooper:mutDic];
    }
}

- (void)keyboardShow:(NSNotification *)aNotification
{
    CGRect keyBoardRect=[[[aNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue];
    NSTimeInterval animalInterval=[[[aNotification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:@"keyboardshow" context:nil];
    [UIView setAnimationDuration:animalInterval];
    self.view.frame=CGRectMake(0, -keyBoardRect.size.height + 100, WIDTH, HEIGHT);
    [UIView commitAnimations];
}

-(void)keyboardHide:(NSNotification *)aNotification
{
    NSTimeInterval animalInterval=[[[aNotification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:@"keyboardshow" context:nil];
    [UIView setAnimationDuration:animalInterval];
    self.view.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    [UIView commitAnimations];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    BOOL bHidd = YES;
    for (int i = 0; i < mutArray.count; i ++) {
        UIView *view = mutArray[i];
        if (touch.view == view) {
            bHidd = NO;
            break;
        }
    }
    if (!bHidd) {
        return;
    }
    
    for (int i = 0; i < mutArray.count; i ++) {
        UITextField *view = mutArray[i];
        [view resignFirstResponder];
    }
   
}

#pragma mark ---keyBoard delegate

-(void)viewWillAppear:(BOOL)animated
{
    self.title =  CurLanguageCon(@"Cooperation");
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    //设置文字颜色 大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],NSFontAttributeName : [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16]}];
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor whiteColor] image:nil isOpaque:YES];//颜色
    [self.navigationController.navigationBar navBarAlpha:1 isOpaque:NO];//透明度 如果设置了透明度 所以导航栏会隐藏
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
      [self  addNotification];
    [super viewWillAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
     
   [super viewWillDisappear:animated];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
  
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


#pragma mark ---request cooper
/*注册*/
-(void)requestCooper:(NSDictionary *)dic
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:@"/UserApp/More/cooperation/submit"];
      
    [CLNetwork POST:str parameter:dic success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            [weakSelf cooperSucc];
            
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
    
    for (int i = 0; i < mutArray.count; i ++) {
        UITextField *textFi = mutArray[i];
        switch (i) {
            case 0:
            {
                if([textFi.text length] < 0)
                {
                    [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter a shop name"]  bSucc:NO];
                    
                }
                else
                    [mutDic setValue:textFi.text forKey:@"shopName"];
            }
                break;
            case 1:
            {
                if([textFi.text length] < 0)
                {
                     [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter a contact"]  bSucc:NO];
                }
                else
                    [mutDic setValue:textFi.text forKey:@"personName"];
            }
                break;
            case 2:
            {
                if([textFi.text length] < 0)
                {
                     [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter your phone number"]  bSucc:NO];
                }
                else
                    [mutDic setValue:textFi.text forKey:@"phone"];
            }
                break;
            case 3:
            {
                if([textFi.text length] < 0)
                {
                    [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please enter the information you want to cooperate with"]  bSucc:NO];
                }
                else
                    [mutDic setValue:textFi.text forKey:@"contents"];
            }
                break;
                
                
            default:
                break;
        }
    }
    
    
  
    
    return mutDic;
}

- (void)cooperSucc
{
    for (int i = 0; i < mutArray.count; i ++) {
           UITextField *view = mutArray[i];
           view.text = @"";
       }
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
