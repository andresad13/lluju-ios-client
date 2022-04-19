//
//  LeftCouViewController.m
//  Tanc
//
//  Created by f on 2019/12/6.
//  Copyright © 2019 f. All rights reserved.
//

#import "LeftCouViewController.h"
#import "PersonalInformViewController.h"
#import "MyShareCodeViewController.h" 
#import "AboutUsViewController.h"
#import "UserAgreViewController.h"
#import "CooperViewController.h"
#import "UseTutorialViewController.h"
#import "HelpCenterViewController.h"
#import "MyPurseViewController.h"
#import "OrderViewController.h"
#import "CreditCardViewController.h"
#import "JPUSHService.h"

#define LeftTag 300

@interface LeftCouViewController ()<UIScrollViewDelegate>
{
    UIButton *buttonUserIcon;//用户头像
    
    UILabel *labName;
    
    UILabel *labMoney;//
    
    UIView *viewLeft;
    
    UIView *viewLeftFollowing;
    
    UIImageView *imageUserIcon;
    
    
}
@property (nonatomic,strong)UIScrollView *contentScrollView;
@end

@implementation LeftCouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self initLeftView];
    
    [self initTopView];
    
    [self initViewLeftFollowing];
    
    [self initNotification];
    // Do any additional setup after loading the view.
}

- (void)initNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateUserData) name:UpdateUserInfor object:nil];
}

- (void)initUI
{
    [self.view addSubview:self.contentScrollView];
}

- (void)initLeftView
{
    CGRect rect = MY_RECT(IPHONE6SWIDTH - 83, 0, 83 , IPHONE6SHEIGHT);
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    // viewBackgr.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];;
    [self.contentScrollView addSubview:viewBackgr];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = viewBackgr.bounds;
    gradient.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.3].CGColor,(id)[UIColor colorWithWhite:0 alpha:0].CGColor];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    //gradient.locations = @[@(0.5f), @(1.0f)];
    [viewBackgr.layer addSublayer:gradient];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [viewBackgr addGestureRecognizer:tapGes];
    
    
    rect = MY_RECT(0, 0, IPHONE6SWIDTH - 83, IPHONE6SHEIGHT);
    viewLeft = [[UIView alloc]initWithFrame:rect];
    [self.contentScrollView addSubview:viewLeft];
    viewLeft.userInteractionEnabled = YES;
    viewLeft.backgroundColor = [UIColor colorWithRed:0xf2 / 255.0 green:0xf3 / 255.0 blue:0xf6 / 255.0 alpha:1];
    
    rect = MY_RECT(0, 222, IPHONE6SWIDTH - 83, IPHONE6SHEIGHT - 222);
    viewLeftFollowing = [[UIView alloc]initWithFrame:rect];
    [viewLeft addSubview:viewLeftFollowing];
    viewLeftFollowing.userInteractionEnabled = YES;
    viewLeftFollowing.backgroundColor = [UIColor whiteColor];
}

- (void)initTopView
{
    CGRect rect= MY_RECT(20, 47, 65, 65);
    rect.size.width = rect.size.height;
    imageUserIcon = [[UIImageView alloc]initWithFrame:rect];
    [viewLeft addSubview:imageUserIcon];
    if ([GlobalObject shareObject].userModel.avatar &&  [[GlobalObject shareObject].userModel.avatar length] > 0) {
       // [imageUserIcon sd_setImageWithURL:[NSURL URLWithString:[GlobalObject shareObject].userModel.avatar]];
        [imageUserIcon sd_setImageWithURL:[NSURL URLWithString:[GlobalObject shareObject].userModel.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error) {
                self->imageUserIcon.image = [UIImage imageNamed:@"merchantsDef"];
            }
        }];
        
        
    }
    else
        imageUserIcon.image = [UIImage imageNamed:@"merchantsDef"];
    [imageUserIcon qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    
    rect = MY_RECT(20, 47, 16, 16);
    rect.size.width = rect.size.height;
    rect.origin.x = rect.origin.x + CGRectGetWidth(imageUserIcon.frame) - rect.size.height;
    rect.origin.y = rect.origin.y + CGRectGetHeight(imageUserIcon.frame) - rect.size.height;
    
    UIImageView *imageEdit = [[UIImageView alloc]initWithFrame:rect];
    [viewLeft addSubview:imageEdit];
    imageEdit.image =[UIImage imageNamed:@"leftCouEdit"];
    
    rect = MY_RECT(228 - 60 - 40, 66, 43 + 60 + 40, 20);
    labName = [[UILabel alloc]initWithFrame:rect];
    [viewLeft addSubview:labName];
    labName.text = [GlobalObject shareObject].userModel.userName;
    labName.textColor = [UIColor colorWithRed:11/255.0 green:11/255.0 blue:11/255.0 alpha:1.0];
    labName.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:19];;
    labName.textAlignment = NSTextAlignmentRight;
    
    rect = MY_RECT(228 - 60 - 40, 90, 43 + 60 + 40, 16);
    UILabel * labId = [[UILabel alloc]initWithFrame:rect];
    [viewLeft addSubview:labId];
    labId.text = [GlobalObject shareObject].userModel.tel;
    labId.textColor = [UIColor colorWithRed:81/255.0 green:81/255.0 blue:81/255.0 alpha:1.0];
    labId.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:11];;
    labId.textAlignment = NSTextAlignmentRight;
    
    rect = MY_RECT(20, 47, 290, 65);
    buttonUserIcon = [[UIButton alloc]initWithFrame:rect];
    [viewLeft addSubview:buttonUserIcon];
    [buttonUserIcon addTarget:self action:@selector(clickUserInfo) forControlEvents:UIControlEventTouchUpInside];
    
    
    rect = MY_RECT(20, 171, 256, 60 - 9.5);
    UIView *viewBackgrTop = [[UIView alloc]initWithFrame:rect];
    [viewLeft addSubview:viewBackgrTop];
    viewBackgrTop.backgroundColor = [UIColor colorWithRed:0x3a/255.0 green:0x3a/255.0 blue:0x3a/255.0 alpha:1.0];
    [viewBackgrTop qi_clipCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:10];
    
    CGFloat floX =0;
    
    NSArray *array = @[@"$",[NSString stringWithFormat:@"%0.1f",[[GlobalObject shareObject].userModel.wallet floatValue]]];
    for (int i = 0; i < 2; i++) {
        
        rect = MY_RECT(11, 11, 110, 13);
        rect.origin.x = rect.origin.x + floX;
        rect.size.width = i == 0 ? [GlobalObject widthOfString:@"$" font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10]] : rect.size.width;
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [viewBackgrTop addSubview:lab];
        lab.textColor = [UIColor colorWithRed:255/255.0 green:235/255.0 blue:233/255.0 alpha:1.0];
        lab.font =  i == 0 ? [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10] : [GlobalObject getAvenirFontEnumType:Avenir_Black fontSize:15];
        labMoney = i == 1 ? lab : labMoney;
        lab.text = array[i];
        
        floX = rect.size.width;
    }
    rect = MY_RECT(11, 32, 100, 8);
    UILabel *labAcc = [[UILabel alloc]initWithFrame:rect];
    [viewBackgrTop addSubview:labAcc];
    labAcc.textColor = [UIColor whiteColor];
    labAcc.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:9];
    labAcc.text = [GlobalObject getCurLanguage:@"Account Balance"];
    
    rect = MY_RECT(181, 17, 62, 22);
    UIButton *buttonView = [[UIButton alloc]initWithFrame:rect];
    [viewBackgrTop addSubview:buttonView];
    
    [buttonView setTitle:[GlobalObject getCurLanguage:@"View"] forState:UIControlStateNormal];
    [buttonView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonView.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10];
    buttonView.backgroundColor = [UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:1.0];
    [buttonView qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    
    UIButton *buttonMon =[[UIButton alloc]initWithFrame:viewBackgrTop.frame];
    [viewLeft addSubview:buttonMon];
    [buttonMon addTarget:self action:@selector(clickMon) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)initViewLeftFollowing
{
    CGRect rect ;
    NSArray *array = @[@"Rental records",@"Cooperation",@"Use tutorial",@"Help center",
                       @"Rental_recordsLeft",@"CooperationLeft",@"Use_tutorialLeft",@"Help_centerLeft"];
    for (int i = 0; i < 4; i ++) {
        CGFloat floX = 291  - 10;
        rect = MY_RECT(5 + floX / 4.0 * i, 0, floX / 4.0, 65);
        UIView *view = [[UIView alloc]initWithFrame:rect];
        [viewLeftFollowing addSubview:view];
        
        rect = MY_RECT(0, 22, 17, 19);
        rect.size.width = rect.size.height / 19.0 * 17;
        rect.origin.x = (CGRectGetWidth(view.frame) - rect.size.width) / 2.0;
        UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:rect];
        [view addSubview:imageIcon];
        imageIcon.image = [UIImage imageNamed:array[i + 4]];
        
        NSString * strCon = CurLanguageCon(array[i]);
        rect = MY_RECT(0, 55, floX / 4.0, 9);
        rect.size.height = [GlobalObject getStringHeightWithText:strCon font:[GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:10] viewWidth:rect.size.width];
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [view addSubview:lab];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor colorWithRed:11/255.0 green:11/255.0 blue:11/255.0 alpha:1.0];
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:10];
        lab.text = strCon;
        lab.numberOfLines = 0;
        
        rect = CGRectMake(0, 0, CGRectGetWidth(view.frame),  CGRectGetHeight(view.frame));
        UIButton *button = [[UIButton alloc]initWithFrame:rect];
        [view addSubview:button];
        [button addTarget:self action:@selector(clickTop:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = LeftTag + i + 50;
    }
    //Credit card
    array = @[@"About Us",@"User Agreement",@"Privacy Agreement",@"Sign out",
                 @"aboutUsLeft",@"UserAgreementLeft",@"PrivacyAgreementLeft",@"SignOutLeft"];
       
    
    for (int i = 0; i< array.count / 2.0 ; i ++) {
        
        rect = MY_RECT(20, 98 - 7  + i * 50, 200, 18 + 15);
        rect.origin.y = i == array.count / 2.0 - 1 ? (406  - 7) / IPHONE6SHEIGHT * HEIGHT : rect.origin.y;
        UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
        [viewLeftFollowing addSubview:viewBackgr];
        
        rect = MY_RECT(0, 7, 18, 18);
        rect.size.width = rect.size.height;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
        imageView.image = [UIImage imageNamed:array[i + (int)(array.count / 2.0)]];
        [viewBackgr addSubview:imageView];
        
        rect = MY_RECT(13, 0, 170, 18 + 15);
        rect.origin.x = rect.origin.x + CGRectGetWidth(imageView.frame);
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [viewBackgr addSubview:lab];
        lab.text = CurLanguageCon(array[i]);
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:12];
        lab.textColor = [UIColor colorWithRed:11/255.0 green:11/255.0 blue:11/255.0 alpha:1.0];
        lab.textAlignment = NSTextAlignmentLeft;
        
        rect = CGRectMake(0, 0, CGRectGetWidth(viewBackgr.frame),  CGRectGetHeight(viewBackgr.frame));
        UIButton *button = [[UIButton alloc]initWithFrame:rect];
        [viewBackgr addSubview:button];
        [button addTarget:self action:@selector(clickFollowing:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = LeftTag + i;
    }
    
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        //        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), SCREENWIDTH, SCREENHEIGHT - 44)];
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _contentScrollView.contentSize = CGSizeMake(WIDTH * 2, 0);
        // 开启分页
        _contentScrollView.pagingEnabled = YES;
        // 关闭回弹
        _contentScrollView.bounces = NO;
        // _contentScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //  _contentScrollView.backgroundColor = [UIColor blackColor];
        // 隐藏水平滚动条
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        // 设置代理
        _contentScrollView.delegate = self;
        // _contentScrollView.backgroundColor = [UIColor redColor];
    }
    return _contentScrollView;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 选中label
    int tag =(int) scrollView.contentOffset.x / WIDTH ;
    
    if (tag == 1) {
        //        [UIView animateWithDuration:0.2 animations:^{
        //   self.view.hidden = YES;
        //        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            //self.contentScrollView.contentOffset = CGPointMake(WIDTH * 1, 0);
        } completion:^(BOOL finished) {
            self.view.hidden = YES;
        }];
        
    }
    //[self updateTopView];
    // 显示对应控制器的view
    //  [self showContentVC:scrollView.contentOffset.x / SCREENWIDTH];
}



- (void)updateScroll
{
    self.contentScrollView.contentOffset = CGPointMake(WIDTH * 0, 0);
    
    CGRect rect = self.view.frame;
    rect.origin.x = - WIDTH;
    self.view.frame = rect;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.view.frame;
        rect.origin.x = 0;
        self.view.frame = rect;
    }];
}

#pragma mark --- click

- (void)clickFollowing:(UIButton *)btn
{
    
    
    
    NSInteger tag = btn.tag - LeftTag;
    switch (tag) {
          
        case 0:
            [self.naviga pushViewController:[AboutUsViewController new] animated:YES];
            break;
        case  1:
        case 2:
        {
            UserAgreViewController *viewController = [UserAgreViewController new];
            viewController.strType = tag == 1 ? @"UserApp/More/agreement" : @"UserApp/More/privacy";
            [self.naviga pushViewController:viewController animated:YES];
        }
            break;
        case 3:
            [self popLogin];
            break;
            
        default:
            break;
    }
}

- (void)clickTop:(UIButton *)btn
{
    NSInteger tag = btn.tag - LeftTag - 50;
    switch (tag) {
        case 0:
            [self.naviga pushViewController:[OrderViewController new] animated:YES];
            break;
        case 1:
            [self.naviga pushViewController:[CooperViewController new] animated:YES];
            
            break;
        case 2:
            [self.naviga pushViewController:[UseTutorialViewController new] animated:YES];
            
            break;
        case 3:
            [self.naviga pushViewController:[HelpCenterViewController new] animated:YES];
            
            break;
        default:
            break;
    }
}


- (void)tapView:(UITapGestureRecognizer *)tapGes
{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentScrollView.contentOffset = CGPointMake(WIDTH * 1, 0);
    } completion:^(BOOL finished) {
        self.view.hidden = YES;
    }];
}

- (void)clickMon
{
    [self.naviga pushViewController:[MyPurseViewController new] animated:YES];
}

- (void)clickUserInfo
{
    [self.naviga pushViewController:[PersonalInformViewController new] animated:YES];
    
}


- (void)updateUserData
{
    if ([GlobalObject shareObject].userModel.avatar &&  [[GlobalObject shareObject].userModel.avatar length] > 0) {
//        [imageUserIcon sd_setImageWithURL:[NSURL URLWithString:[GlobalObject shareObject].userModel.avatar]];
        [imageUserIcon sd_setImageWithURL:[NSURL URLWithString:[GlobalObject shareObject].userModel.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error) {
                self->imageUserIcon.image = [UIImage imageNamed:@"merchantsDef"];
            }
        }];
    }
    else
        imageUserIcon.image = [UIImage imageNamed:@"merchantsDef"];
    labName.text = [GlobalObject shareObject].userModel.userName;
      labMoney.text = [NSString stringWithFormat:@"%0.1f",[[GlobalObject shareObject].userModel.wallet floatValue]];
}

- (void)popLogin
{
      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[GlobalObject getCurLanguage:@"prompt"] message:[GlobalObject getCurLanguage:@"Are you sure you want to exit?"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"cancel"] style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"determine"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [JPUSHService deleteTags:[NSSet setWithObjects:[GlobalObject shareObject].userModel.openid,nil] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                        
                    } seq:1];
                    [[GlobalObject shareObject] deleteUserFile];
                    [GlobalObject shareObject].toKenSear = @"";
                    [gAppDelegate popViewController];
                    
                }];
                
    //            [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    //
    //            } seq:1];
                
                
                [alertController addAction:cancelAction];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
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
