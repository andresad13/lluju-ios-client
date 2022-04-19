//
//  BusinessDetailsViewController.m
//  Tanc
//
//  Created by f on 2019/12/12.
//  Copyright © 2019 f. All rights reserved.
//

#import "BusinessDetailsViewController.h"
#import "ShufflingFigureView.h"
#import <GoogleMaps/GoogleMaps.h>

@interface BusinessDetailsViewController ()
{
    NSDictionary *busDetaDic;
}

@property(nonatomic,strong)ShufflingFigureView *shufflingFigureView;//轮播图

@end

@implementation BusinessDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackWhiteImage];
    
    self.title = CurLanguageCon(@"Business details");
    
    [self request];
    
     [super setBtnGOHiddenNO];
    // Do any additional setup after loading the view.
}

-(ShufflingFigureView *)shufflingFigureView
{
    if (!_shufflingFigureView) {
        CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 255 / IPHONE6SHEIGHT * HEIGHT);
        _shufflingFigureView = [[ShufflingFigureView alloc]initWithFrame:rect];
        [self.view addSubview:_shufflingFigureView];
        
        rect  = MY_RECT(0, 182, IPHONE6SWIDTH, 15);
        [_shufflingFigureView setPageContrRect:rect];
    }
    return _shufflingFigureView;
}


- (void)request
{
    __weak __typeof(self) weakSelf = self;
    
    [gAppDelegate createActivityView];
    
    NSString *str = [NSString stringWithFormat:@"%@%@?shopId=%@&latitude=%@&longitude=%@",ChargingApi,@"/UserApp/Shop/details",_shopId,[GlobalObject shareObject].nearbyLatitude,[GlobalObject shareObject].nearbyLongitude];
    [CLNetwork POST:str parameter:@{@"shopId":_shopId} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
           //刷新UI
            [weakSelf updateUI:responseObject[@"data"]];
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

- (void)updateUI:(NSDictionary *)dic
{
    busDetaDic = [dic copy];
    if ([[dic allKeys] containsObject:@"banner"]  && dic[@"banner"]  &&  [dic[@"banner"]  length] > 0) {
        NSArray *array = [dic[@"banner"] componentsSeparatedByString:@","];
        self.shufflingFigureView.hidden = NO;
        [self.shufflingFigureView setShufflingFigure:array];
    }
    else
    {
        self.shufflingFigureView.hidden = NO;
        self.shufflingFigureView.bDefImage = YES;
        NSArray *array = @[@"def_banner1",@"def_banner2"];
        [self.shufflingFigureView setShufflingFigure:array];
    }
    CGRect rect = MY_RECT(0, 223, IPHONE6SWIDTH, IPHONE6SHEIGHT - 223);
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgr];
    [viewBackgr qi_clipCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:20];
    viewBackgr.backgroundColor = [UIColor whiteColor];
    
    rect = MY_RECT(0, 201, 63, 63);
    rect.size.width = rect.size.height;
    rect.origin.x = (WIDTH - rect.size.width) / 2.0;
    UIView *viewTop = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewTop];
    viewTop.backgroundColor = [UIColor whiteColor];
    [viewTop qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    
  
    rect = MY_RECT(0, 205, 63, 54);
    rect.size.width = rect.size.height;
    rect.origin.x = (WIDTH - rect.size.width) / 2.0;
    UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageIcon];
    [imageIcon qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    imageIcon.image = [UIImage imageNamed:@"merchantsDef"];
    
    rect = MY_RECT(0, 51, IPHONE6SWIDTH, 17);
    UILabel *labName = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labName];
    labName.text = dic[@"shopname"];
    labName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    labName.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
    labName.textAlignment = NSTextAlignmentCenter;
    
    NSArray *array = @[@"Opening hours:",@"address:",@"phone:",@"Merchant description:",
    @"Opening_hours",@"addressDef",@"phoneDef",@"Merchant_description",
    dic[@"serviceTime"],dic[@"address"],dic[@"tel"],dic[@"info"]];
   
    CGFloat floViewHei = 82 / IPHONE6SHEIGHT * HEIGHT;
    for (int i = 0; i < 4; i ++) {
        
        rect = MY_RECT(20, 0, 335, 63);
        rect.origin.y = floViewHei;
        UIView *viewTitBackgr = [[UIView alloc]initWithFrame:rect];
        [viewBackgr addSubview:viewTitBackgr];
        
        rect = MY_RECT(58, 15, 267, 15);
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [viewTitBackgr addSubview:lab];
        lab.text = CurLanguageCon(array[i]);
        lab.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
        
        UIFont *font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:12];
        CGFloat floHei = [GlobalObject getStringHeightWithText:array[i + 8] font:font viewWidth:rect.size.width];
        rect = MY_RECT(58, 37, 267, 15);
        rect.size.height = floHei;
        UILabel *labCont = [[UILabel alloc]initWithFrame:rect];
        [viewTitBackgr addSubview:labCont];
        labCont.text = array[i + 8];
        labCont.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
        labCont.textAlignment = NSTextAlignmentLeft;
        labCont.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:12];
        
        rect = viewTitBackgr.frame;
        rect.size.height = labCont.frame.origin.y + labCont.frame.size.height + 13 / IPHONE6SHEIGHT * HEIGHT;
        viewTitBackgr.frame = rect;
        viewTitBackgr.backgroundColor =[UIColor whiteColor];
        viewTitBackgr.shadowOpacity(0.7).shadowColor([UIColor colorWithWhite:0 alpha:0.1]).shadowRadius(7).shadowOffset(CGSizeMake(0, 7)).conrnerRadius(8).conrnerCorner(UIRectCornerAllCorners).showVisual();
        
        
        rect = MY_RECT(58, 0, 22, 22);
        rect.size.width = rect.size.height;
        rect.origin.x = (rect.origin.x - rect.size.height) / 2.0;
        rect.origin.y = (viewTitBackgr.frame.size.height - rect.size.height) / 2.0;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
        [viewTitBackgr addSubview:imageView];
        imageView.image = [UIImage imageNamed:array[i + 4]];
        
        floViewHei = floViewHei + viewTitBackgr.frame.size.height + 15 / IPHONE6SHEIGHT * HEIGHT;
        
        if (i != 2) {
            continue;
        }
        UIButton *button = [[UIButton alloc]initWithFrame:rect];
        [viewBackgr addSubview:button];
        [button addTarget:self action:@selector(clickBusDet:) forControlEvents:UIControlEventTouchUpInside];
    }
      
    rect = MY_RECT(313, 381 + 223, 42, 42);
    rect.size.width = rect.size.height;
    UIButton *buttonNavigation = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonNavigation];
    [buttonNavigation setImage:[UIImage imageNamed:@"busiDetaNavigatio"] forState:UIControlStateNormal];
    [buttonNavigation addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    rect = MY_RECT(0, 26, 0, 10);
    rect.size.width = CGRectGetWidth(buttonNavigation.frame);
    UILabel *labdistance = [[UILabel alloc]initWithFrame:rect];
    [buttonNavigation addSubview:labdistance];
    labdistance.textAlignment = NSTextAlignmentCenter;
    
     labdistance.text = [GlobalObject getDistanceTransformation:[dic[@"distance"] intValue]];
    labdistance.textColor = [UIColor whiteColor];
    labdistance.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:11];
}

- (void)click
{
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
        [gAppDelegate showAlter:@"Please download Google maps first" bSucc:NO];
        return;
    }
    __block NSString *urlScheme = @"URI://";
    __block NSString *appName = @"SOFTWARE";
    
    __block CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([busDetaDic[@"latitude"] doubleValue], [busDetaDic[@"longitude"] doubleValue]);
    
    NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (void)clickBusDet:(UIButton *)btn
{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",busDetaDic[@"shopPhone"]]]];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //设置文字颜色 大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName : [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16]}];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
