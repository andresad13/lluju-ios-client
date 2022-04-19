//
//  AboutUsViewController.m
//  Tanc
//
//  Created by f on 2019/12/9.
//  Copyright © 2019 f. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    if ([GlobalObject shareObject].serviceCus && [[GlobalObject shareObject].serviceCus allKeys] > 0) {
        [self initUI:[GlobalObject shareObject].serviceCus];
    }
    else
    [self requeAbout];
    
    
    // Do any additional setup after loading the view.
}

- (void)initUI:(NSDictionary *)dic
{
    
    CGRect rect = MY_RECT(155, 121 - PhoneHeight, 63, 63);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    rect.size.width = rect.size.height;
    rect.origin.x = (WIDTH - rect.size.width) / 2.0;
    UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageIcon];
    imageIcon.image = [UIImage imageNamed:@"merchantsDef"];
    
    NSArray *array = @[@"Customer Hotline",@"E-mail",@"Company website",
                       dic[@"tel"],dic[@"customerServiceEmail"],dic[@"webSite"]];
    //email dic[@""]
    for (int i = 0; i < array.count / 2.0; i ++) {
        
        rect = MY_RECT(0, 232  - PhoneHeight + i * 54, IPHONE6SWIDTH, 54);
        rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
        UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
        [self.view addSubview:viewBackgr];
        
        rect = MY_RECT(20, 0, 250, 54);
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [viewBackgr addSubview:lab];
        lab.text = CurLanguageCon(array[i]);
        lab.textColor = [UIColor colorWithRed:48/255.0 green:52/255.0 blue:66/255.0 alpha:1.0];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
        
        
        rect = MY_RECT(IPHONE6SWIDTH - 23 - 180, 0, 180, 54);
        UILabel *labSec = [[UILabel alloc]initWithFrame:rect];
        [viewBackgr addSubview:labSec];
        labSec.text = [GlobalObject judgeStringNil: array[i + 3]];
        labSec.textColor = [UIColor colorWithRed:48/255.0 green:52/255.0 blue:66/255.0 alpha:1.0];
        labSec.textAlignment = NSTextAlignmentRight;
        labSec.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
        labSec.numberOfLines = 0;
        
        rect = MY_RECT(7.5, 54- 1, IPHONE6SWIDTH - 7.5 * 2, 1);
        UIView *viewLine = [[UIView alloc]initWithFrame:rect];
        [viewBackgr addSubview:viewLine];
        viewLine.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        
    }
    
    array = @[[NSString stringWithFormat:@"%@ %@",[GlobalObject getCurLanguage:@"current version"],@"1.3.2"],[GlobalObject getCurLanguage:@"Copyright©2020 SOFTWARE"]];
    for ( int i = 0; i < 2; i ++)
    {
        CGRect rect = MY_RECT(0, 611 + i * 25, IPHONE6SWIDTH , 11);
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [self.view addSubview:lab];
        lab.text = array[i];
        int fontInt = i == 0 ? 13 : 11;
        lab.textColor = [UIColor colorWithRed:155/255.0 green:160/255.0 blue:167/255.0 alpha:1.0];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:fontInt];
        
    }
     
     [super setBtnGOHiddenNO];
    
}

-(void)requeAbout
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:@"/UserApp/More/about"];
    
  
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
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


-(void)viewWillAppear:(BOOL)animated
{
    self.title = CurLanguageCon(@"About Us");
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
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
            //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
             [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色
           // Fallback on earlier versions
       }
    [super viewWillAppear:animated];
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
