//
//  ViewController.m
//  Tanc
//
//  Created by f on 2019/12/3.
//  Copyright © 2019 f. All rights reserved.
//

#import "LogReiViewController.h"
#import "RegisteredView.h"
#import "LoginView.h"
#import "RegisteredView.h"
#import "AreaCodeViewController.h"
#import "RetrievePasswViewController.h"
#import "MainViewController.h"

@interface LogReiViewController ()<UIScrollViewDelegate,LoginViewDelegate,RegisteredViewDelegate,AreaCodeViewDelegate>
{
    UIScrollView *scrollView;//
    
    UIButton *buttonLogIn;//log in
    UIButton *buttonRegi;//registered
    
    UIView *viewLine;//
    
    LoginView *loginView;
    RegisteredView * registeredView;
    
    int curSeleCodeType;//当前选择的区号
    
}
@end

@implementation LogReiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self intUI];
    
    [self initScrollView];
    
    [self  addNotification];
    // Do any additional setup after loading the view.
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)intUI
{
    /*顶部 图标*/
    CGRect rect = MY_RECT(0, 0, IPHONE6SWIDTH, 251);
    UIImageView *imageBackgr = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageBackgr];
    imageBackgr.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
      gl.frame = MY_RECT(0, 0, IPHONE6SWIDTH, 251);
      gl.startPoint = CGPointMake(0, 0);
      gl.endPoint = CGPointMake(1, 1);
      gl.colors = @[(__bridge id)[UIColor colorWithRed:0x93/255.0 green:0xc1/255.0 blue:0x5f/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0x63/255.0 green:0xb1/255.0 blue:0x5e/255.0 alpha:1.0].CGColor];
      gl.locations = @[@(0.0),@(1.0)];

      [imageBackgr.layer addSublayer:gl];
    
    
    rect = MY_RECT(117.5, 73, 140, 87);
    rect.size.width = rect.size.height / 87.0 * 61;
    UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageIcon];
    imageIcon.image = [UIImage imageNamed:@"loginIcon"];
    imageIcon.center = CGPointMake(WIDTH / 2.0, imageIcon.center.y);
    
    NSArray *array = @[@"log in",@"registered"];
    /*分页 控件*/
    for (int i = 0; i < 2; i ++) {
        
        rect = MY_RECT((IPHONE6SWIDTH / 2.0 - 100) / 2.0 + IPHONE6SWIDTH / 2.0 * i, 214 - 5, 100, 17.5 + 10);
        UIButton *button= [[UIButton alloc]initWithFrame:rect];
        [self.view addSubview:button];
        [button setTitle:[GlobalObject getCurLanguage:array[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:228/255.0 green:255/255.0 blue:228/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
        [button addTarget:self action:@selector(clickCheckPaging:) forControlEvents:UIControlEventTouchUpInside];
        button.selected = i == 0? YES : NO;
        buttonLogIn = i == 0 ? button : buttonLogIn;
        buttonRegi = i == 1 ? button : buttonRegi;
    }
    
    rect = MY_RECT((IPHONE6SWIDTH / 2.0 - 54) / 2.0, 251 - 2, 54, 2);
    viewLine = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewLine];
    viewLine.backgroundColor = [UIColor whiteColor];
    
}

- (void)initScrollView
{
    CGRect rect = MY_RECT(0, 251, IPHONE6SWIDTH, IPHONE6SHEIGHT - 251);
    scrollView = [[UIScrollView alloc]initWithFrame:rect];
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(WIDTH *2, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    rect = MY_RECT(0, 0, IPHONE6SWIDTH, IPHONE6SHEIGHT - 251);
    LoginView *viewFir=  [[LoginView alloc]initWithFrame:rect];
    [scrollView addSubview:viewFir];
    viewFir.backgroundColor = [UIColor whiteColor];
    viewFir.delegate = self;
    loginView = viewFir;
    
    rect = MY_RECT(IPHONE6SWIDTH  , 0, IPHONE6SWIDTH, IPHONE6SHEIGHT - 251);
    RegisteredView *viewSec=  [[RegisteredView alloc]initWithFrame:rect];
    [scrollView addSubview:viewSec];
    viewSec.backgroundColor = [UIColor whiteColor];
    viewSec.delegate = self;
    registeredView = viewSec;
}


#pragma mark ---click

- (void)clickCheckPaging:(UIButton *)btn
{
    int number = btn == buttonLogIn ? 0 : 1;
    
    [self updatePagingView:number];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int number = scrollView.contentOffset.x  / WIDTH;
    
    [self updatePagingView:number];
}

- (void)updatePagingView:(int)intType
{
    /*重新计算 线 的位置*/
    CGRect rect = viewLine.frame;
    
    rect.origin.x =  intType == 0 ? (WIDTH / 2.0 - rect.size.width) / 2.0 : (WIDTH / 2.0 - rect.size.width) / 2.0 + WIDTH / 2.0;
    
    [scrollView setContentOffset:CGPointMake(WIDTH * intType, 0) animated:YES];
    
    
    if (intType == 0) {
        buttonLogIn.selected = YES;
        buttonRegi.selected = NO;
    }
    else
    {
        buttonLogIn.selected = !YES;
        buttonRegi.selected = !NO;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self->viewLine.frame = rect;
    }];
    
    [loginView StopInput];
    [registeredView StopInput];
}


#pragma mark ---logon registered code delegate

/*找回密码*/
- (void)openForgetPassword
{
    RetrievePasswViewController *viewController = [[RetrievePasswViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)openLoginSucc
{
    MainViewController *viewController = [[MainViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}
/*打开选择区号的界面*/
- (void)openCode:(int)intType
{
    curSeleCodeType = intType;
    AreaCodeViewController *viewController = [[AreaCodeViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.delegate = self;
    
}

- (void)goBackLogin
{
    [self updatePagingView:0];
}


- (void)updateAreaCode:(NSString *)strNumb
{
    if (curSeleCodeType == 0) {
        [loginView.phoneTextfiel.buttonCode setTitle:strNumb forState:UIControlStateNormal];
        loginView.strCode = strNumb;
        
    }
    else
    {
        [registeredView setCode:strNumb];
    }
    
}

#pragma mark ---keyBoard delegate

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    
    
    if (@available(iOS 13.0, *)) {
          // [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDarkContent;//黑色
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
       } else {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
             //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色
           // Fallback on earlier versions
       }
    [GlobalObject shareObject].toKenSear = @"";
    [super viewWillAppear:animated];
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
    [loginView endAndUpdate];
    
    [registeredView endAndUpdate];
    
}



@end
