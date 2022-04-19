//
//  MainViewController.m
//  Tanc
//
//  Created by f on 2019/12/6.
//  Copyright © 2019 f. All rights reserved.
//

#import "MainViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "LeftCouViewController.h"
#import "UserModel.h"
#import "NearbybusinViewController.h"
#import "MerchantWindowView.h"
#import "QrCodeScanningViewController.h"
//#import "LBXPermission.h"
#import "ChargingRulesViewController.h"
#import "FeedbackViewController.h"
#import "BusinessDetailsViewController.h"
 
#import "JPUSHService.h"

#define TimeLimit 4

@interface MainViewController ()<GMSMapViewDelegate,CLLocationManagerDelegate,QrCodeScanningViewControllerDelegate>
{
    CLLocationManager *manager;
    CLGeocoder *geocoder;
    
    CLLocationCoordinate2D my_locationCoordinate2D;
    
    CLLocationCoordinate2D curCLLocationCoordinate2D;
    
    QrCodeScanningViewController *qqlBXScanViewController;
    NSMutableArray *mutMarker;
    NSMutableArray *mutLocation;
    
    UIImageView *imageUserIcon;
    
    NSDictionary *seleShopDic;
    
    MerchantWindowView  *merchantWindowView;
    
    long long curTime;
    int seleLocation;
    
    BOOL bFir;//是否是第一次
    
    UIView *viewSweepCode;//扫码
}

@property (nonatomic,strong)LeftCouViewController *leftCouViewController;

@property(nonatomic, assign) CLLocationCoordinate2D curCoordinate2D;
// @property (nonatomic,strong) CLLocationManager *locationManager;//地图定位对象
@property (nonatomic,strong) GMSMapView *mapView;//地图
@property (nonatomic,strong) GMSMarker *marker;//大头针

@property (nonatomic,strong) GMSCameraPosition*camera;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initData];
    
    [self initMapView];
    
    [self initgMsMapView];
    
    [self initTopView];
    
    [self initNotification];
    
    [self initViewSweepCode];
    
    [self initMerchantWindowView];
    
    // Do any additional setup after loading the view.
}

- (void)initNotification
{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotification) name:@"PushNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateEditUserInfor) name:UpdateUserInfor object:nil];
}


- (void)pushNotification
{
    if ( [GlobalObject shareObject].toKenSear && [[GlobalObject shareObject].toKenSear length] > 0) {
           [self  requestUserInfor];
       }
}


- (void)initData
{
    bFir = YES;
    mutLocation = [NSMutableArray array];
    mutMarker = [NSMutableArray array];
    
    
    [GlobalObject shareObject].nearbyLatitude = @"22.55329";
    [GlobalObject shareObject].nearbyLongitude = @"113.88410";
    [GlobalObject shareObject].curLongitude = @"113.88410";
    [GlobalObject shareObject].curLatitude = @"22.55329";
    
}

- (void)initViewSweepCode
{
    CGRect rect = MY_RECT(0, 588, IPHONE6SWIDTH, 79);
    viewSweepCode = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewSweepCode];
    
    rect = MY_RECT(5.5, 18.5, 50.5, 50.5);
    rect.size.width = rect.size.height;
    UIButton *buttonPositioning = [[UIButton alloc]initWithFrame:rect];
    [viewSweepCode addSubview:buttonPositioning];
    [buttonPositioning setImage:[UIImage imageNamed:@"map_reset"] forState:UIControlStateNormal];
    [buttonPositioning addTarget:self action:@selector(clickPositioning) forControlEvents:UIControlEventTouchUpInside];
    
    rect = MY_RECT(5.5, 18.5, 50.5, 50.5);
    rect.size.width = rect.size.height;
    rect.origin.x = WIDTH - rect.origin.x - rect.size.width;
    UIButton *buttonCustomerService = [[UIButton alloc]initWithFrame:rect];
    [viewSweepCode addSubview:buttonCustomerService];
    [buttonCustomerService setImage:[UIImage imageNamed:@"map_CustomerService"] forState:UIControlStateNormal];
    [buttonCustomerService addTarget:self action:@selector(clickCustomerService) forControlEvents:UIControlEventTouchUpInside];
    
    rect = MY_RECT(103, 18, 200, 43);
    UIView *viewCode = [[UIView alloc]initWithFrame:rect];
    [viewSweepCode addSubview:viewCode];
    viewCode.backgroundColor = [UIColor colorWithRed:26/255.0 green:27/255.0 blue:21/255.0 alpha:1.0];
//
    
    rect = MY_RECT(10, 13, 17, 17);
    rect.size.width = rect.size.height;
    UIImageView *imageCode = [[UIImageView alloc]initWithFrame:rect];
    [viewCode addSubview:imageCode];
    imageCode.image = [UIImage imageNamed:@"main_qrCode"];
    
    NSString *strScan = CurLanguageCon(@"Scan code rental");
    rect = MY_RECT(4, 14, 130, 43 - 14 * 2);
    rect.size.width = [GlobalObject widthOfString:strScan font:[GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15]];
    rect.origin.x = rect.origin.x + CGRectGetWidth(imageCode.frame) + imageCode.frame.origin.x;
    UILabel *lab = [[UILabel alloc]initWithFrame:rect];
    [viewCode addSubview:lab];
    lab.text = strScan;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    lab.textColor = [UIColor whiteColor];
    
  rect = viewCode.frame;
    rect.size.width = lab.frame.origin.x + CGRectGetWidth(lab.frame) + 10 / IPHONE6SWIDTH * WIDTH;
    rect.origin.x = (WIDTH - rect.size.width) / 2.0;
    viewCode.frame = rect;
       viewCode.shadowOpacity(0.7).shadowColor((UIColor *)[UIColor colorWithWhite:0 alpha:0.3]).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    
    rect = MY_RECT(103, 18, 169, 43);
    UIButton *buttonCode = [[UIButton alloc]initWithFrame:rect];
    [viewSweepCode addSubview:buttonCode];
    [buttonCode addTarget:self action:@selector(clickCode) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)initMerchantWindowView
{
    CGRect rect = MY_RECT(10, 511, 355, 142);
    merchantWindowView = [[MerchantWindowView alloc]initWithFrame:rect];
    [self.view addSubview:merchantWindowView];
    merchantWindowView.hidden = YES;
    [merchantWindowView qi_clipCorners:UIRectCornerAllCorners radius:4];
    merchantWindowView.backgroundColor = [UIColor whiteColor];
    
    [merchantWindowView.buttonDef addTarget:self action:@selector(clickDef) forControlEvents:UIControlEventTouchUpInside];
    [merchantWindowView.buttonNavigation addTarget:self action:@selector(clickTap) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initTopView
{
    CGRect rect = MY_RECT(21, 36, IPHONE6SWIDTH - 21 * 2, 50);
    UIView *viewBackgr =[[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgr];
    viewBackgr.backgroundColor = [UIColor whiteColor];
    viewBackgr.shadowOpacity(0.7).shadowColor([UIColor colorWithWhite:0 alpha:0.2 ]).shadowRadius(7).shadowOffset(CGSizeMake(0, 7)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTopView)];
    [viewBackgr addGestureRecognizer:tapGes];
    
    
    rect = MY_RECT(3, 2, 2, 50 - 4);
    rect.size.width = rect.size.height;
    imageUserIcon = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgr addSubview:imageUserIcon];
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
    
    UIButton *buttonIcon = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonIcon];
    [imageUserIcon qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    [buttonIcon addTarget:self action:@selector(clickLeft) forControlEvents:UIControlEventTouchUpInside];
    
    
    rect = MY_RECT(65, 10, 2200, 30);
    UILabel *lab = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:lab];
    lab.text = [GlobalObject getCurLanguage:@"Find nearby businesses"];
    lab.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
    lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14];
    
    rect = MY_RECT(23, (50 - 16) / 2.0, 16, 16);
    rect.size.width = rect.size.height;
    rect.origin.x = CGRectGetWidth(viewBackgr.frame) - rect.origin.x - rect.size.width;
    UIImageView *imageNext = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgr addSubview:imageNext];
    imageNext.image = [UIImage imageNamed:@"go_Next"];
    
    
}

- (LeftCouViewController *)leftCouViewController
{
    if (!_leftCouViewController) {
        _leftCouViewController = [[LeftCouViewController alloc]init];
        [self.view addSubview:_leftCouViewController.view];
        _leftCouViewController.naviga = self.navigationController;
        _leftCouViewController.view.hidden = YES;
    }
    
    return _leftCouViewController;
}

- (void)initMapView
{
    self.camera = [GMSCameraPosition cameraWithLatitude:1.285
                                              longitude:103.848
                                                   zoom:12];
    
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:self.camera];
    mapView.mapType = kGMSTypeNormal;
    mapView.myLocationEnabled = YES;
    [self.view addSubview:mapView];
    mapView.delegate = self;
    self.mapView = mapView;
    self.mapView.frame = CGRectMake(0, 0, WIDTH,HEIGHT);
}

- (void)initgMsMapView
{
    //    viewMapBackgr = [[UIView alloc]initWithFrame:self.view.bounds];
    //    [self.view addSubview:viewMapBackgr];
    
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
        
        manager = [[CLLocationManager alloc] init];
        
        geocoder = [[CLGeocoder alloc] init];
        
        manager.delegate = self;//遵循代理
        
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        
        manager.distanceFilter = 1000.0f;
        
        [manager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8以上版本定位需要）
        
        [manager startUpdatingLocation];//开始定位
        
    }else{//不能定位用户的位置的情况再次进行判断，并给与用户提示
        
        //1.提醒用户检查当前的网络状况
        
        //2.提醒用户打开定位开关
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[GlobalObject getCurLanguage:@"prompt"] message:[GlobalObject getCurLanguage:@"Actualmente no tienes activado el permiso de ubicación, ¿quieres ir a configurar permisos?"] preferredStyle:UIAlertControllerStyleAlert];
//
//                      UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"cancel"] style:UIAlertActionStyleCancel handler:nil];
//                      UIAlertAction *okAction = [UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"determine"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//
//                      }];
//
//                      [alertController addAction:cancelAction];
//                      [alertController addAction:okAction];
//                      [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    
}




#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray * _Nonnull)locations
{
    
    CLLocation*curLocation = [locations lastObject];
    
    // 通过location  或得到当前位置的经纬度
    
    CLLocationCoordinate2D curCoordinate2D = curLocation.coordinate;
    
    
    my_locationCoordinate2D = curCoordinate2D;
    
    [GlobalObject shareObject].curLongitude = [NSString stringWithFormat:@"%0.20f",curCoordinate2D.longitude];
    [GlobalObject shareObject].curLatitude = [NSString stringWithFormat:@"%0.20f",curCoordinate2D.latitude ];
    [GlobalObject shareObject].nearbyLatitude = [NSString stringWithFormat:@"%0.20f",curCoordinate2D.latitude];
    [GlobalObject shareObject].nearbyLongitude = [NSString stringWithFormat:@"%0.20f",curCoordinate2D.longitude];
    if (!_camera) {
        GMSCameraPosition*camera = [GMSCameraPosition cameraWithLatitude:curCoordinate2D.latitude longitude:curCoordinate2D.longitude zoom:14];
        self.camera = camera;
    }
    else
    {
        self.camera = [self.camera initWithTarget:curCoordinate2D zoom:14];
    }
    self.mapView.camera = _camera;
    
    curTime = [[NSDate date] timeIntervalSince1970];
    
    [self requestNear:[GlobalObject shareObject].nearbyLongitude latitude:[GlobalObject shareObject].nearbyLatitude];
    
    [manager stopUpdatingLocation];
}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position
{//position.target
    
    curCLLocationCoordinate2D = position.target;// CLLocationCoordinate2DMake(position.target.latitude, position.target.longitude);
    if ([[NSDate date] timeIntervalSince1970] - curTime > TimeLimit) {
        
        [GlobalObject shareObject].nearbyLatitude = [NSString stringWithFormat:@"%f",position.target.latitude];
        [GlobalObject shareObject].nearbyLongitude = [NSString stringWithFormat:@"%f",position.target.longitude];
        
        [self requestNear:[GlobalObject shareObject].nearbyLongitude latitude:[GlobalObject shareObject].nearbyLatitude];
        
        //[mutLocation addObject:@{@"latitude":[NSNumber numberWithDouble:position.target.latitude],@"longitude":[NSNumber numberWithDouble:position.target.longitude]}];
    }
    //curCLLocationCoordinate2D
    
    
}

-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(nonnull GMSCameraPosition *)position
{
    NSLog(@"didChangeCameraPosition");
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    NSLog(@"didTapInfoWindowOfMarker");
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    merchantWindowView.hidden = YES;
    
    viewSweepCode.hidden = NO;
    [self updateMarkerIcon];
    //所有的圖片讀變小
    NSLog(@"didTapAtCoordinate");
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(nonnull GMSMarker *)marker
{
    //GMSMarker
    for (int i = 0; i < mutMarker.count; i ++) {
        
        if (mutMarker[i] == marker) {
            
            if (i < mutLocation.count ) {
                seleLocation = i;
                NSMutableDictionary *dic = mutLocation[i];
                
                seleShopDic = [dic copy];
                BOOL bSele = ![dic[@"seleState"] boolValue];
                [dic setValue:[NSNumber numberWithBool:bSele] forKey:@"seleState"];
                int onlines = [dic[@"onlines"] intValue];
                int industryType = [dic[@"industry"] intValue];
                
                marker.icon = [UserModel getMapIcon:onlines bBig:bSele number:industryType];
                
                [self updateMerchantsBackgrView:dic bSele:bSele];
                
                [self updateOtherMarker:marker];
            }
            
        }
    }
    NSLog(@"didTapMarker");
    return YES;
}


- (void)requestNear:(NSString *)longitude latitude:(NSString *)latitude
{
    if (!([GlobalObject shareObject].toKenSear && [[GlobalObject shareObject].toKenSear length] > 0) || ![GlobalObject shareObject].curLongitude || ![GlobalObject shareObject].curLatitude) {
        return;
    }
    
    //[self showViewBackgrDown];
    __weak typeof(self) weakSelf = self;//UserApp/Shop/nearbyNoPager
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/UserApp/Shop/nearbyNoPager"];
    
    NSDictionary *dic = @{@"longitudeCenter":longitude,@"latitudeCenter":latitude,
                          @"longitude":[GlobalObject shareObject].curLongitude,@"latitude":[GlobalObject shareObject].curLatitude
    };
    [CLNetwork POST:str parameter:dic success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            [weakSelf updateData:responseObject[@"data"]];
        }
        else
        {
            
        }
    } failure:^(NSError *error) {
        
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
}

-(void)requestUserInfor
{
    if (bFir) {
        [gAppDelegate createActivityView];
    }
    
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:@"/UserApp/User/Info"];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            [weakSelf updateUserInfor:responseObject[@"data"]];
            
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

-(void)requestCheck:(NSString *)codeId
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:[NSString stringWithFormat:@"/UserApp/Borrow/Check"]];
    
    [CLNetwork POST:str parameter:@{@"id":codeId} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            [weakSelf createCharging:responseObject  codeId:codeId];
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

- (void)createCharging:(NSDictionary *)dic codeId:(NSString *)codeId
{
    ChargingRulesViewController * chargingRulesViewController =  [ChargingRulesViewController new];
    chargingRulesViewController.strCodeID = codeId;
    chargingRulesViewController.dicM  = dic;
    [self.navigationController pushViewController:chargingRulesViewController animated:YES];
}


#pragma mark ---click

//详情
- (void)clickDef
{
    NSString *shopId = seleShopDic[@"shopId"];
    BusinessDetailsViewController *viewController = [[BusinessDetailsViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.shopId = shopId;
}

//地图 导航
- (void)clickTap
{
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", @"585027354"]];
        [[UIApplication sharedApplication] openURL:url];
        return;
    }
    __block NSString *urlScheme = @"URI://";
    __block NSString *appName = @"SOFTWARE";
    
    __block CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([seleShopDic[@"lat"] doubleValue], [seleShopDic[@"lng"] doubleValue]);
    
    NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

// 
- (void)tapTopView
{
    if  ([CLLocationManager authorizationStatus] !=kCLAuthorizationStatusDenied)
    {
        NearbybusinViewController *viewController =[[NearbybusinViewController alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[GlobalObject getCurLanguage:@"prompt"] message:[GlobalObject getCurLanguage:@"Actualmente no tienes activado el permiso de ubicación, ¿quieres ir a configurar permisos?"] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"cancel"] style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"determine"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
   
}

- (void)clickPositioning
{//定位当前
    if (manager) {
        [manager startUpdatingLocation];//开始定位
    }
}

- (void)clickCustomerService
{//d
   // FeedbackViewController
    
    [self.navigationController pushViewController:[FeedbackViewController new] animated:YES];
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [GlobalObject shareObject].userModel.tel]]];
}

- (void)clickCode
{//测试
 
    __weak __typeof(self) weakSelf = self;
    
 

    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
      
      if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
      {
          //无权限
          NSString *strPro = CurLanguageCon(@"prompt");
          NSString *strPhoPro = CurLanguageCon(@"No camera permissions. Do you want to go to Settings?");
          NSString *strCancel = CurLanguageCon(@"cancel");
          NSString *strSeet = CurLanguageCon(@"Set up");
          
          
          UIAlertController *alertController = [UIAlertController alertControllerWithTitle:strPro message:strPhoPro preferredStyle:UIAlertControllerStyleAlert];
          
          UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:strCancel style:UIAlertActionStyleCancel handler:nil];
          UIAlertAction *okAction = [UIAlertAction actionWithTitle:strSeet style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              //前往
              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];

          }];
          
          [alertController addAction:cancelAction];
          [alertController addAction:okAction];
          [self presentViewController:alertController animated:YES completion:nil];
          
          
      }
      else
      {
          [weakSelf pushQQLBXScanViewController];
      }

}

- (void)clickLeft
{//左边
    self.leftCouViewController.view.hidden = NO;
    [self.view bringSubviewToFront:self.leftCouViewController.view];
    
    [self.leftCouViewController updateScroll];
}

- (void)updateUserInfor:(NSDictionary *)dic
{
   
    if (![GlobalObject shareObject].userModel) {
        [GlobalObject shareObject].userModel = [UserModel createUserModel:dic];
        
        [UserModel requestCus];
    }
    else
    {
        [UserModel updateUserModel:[GlobalObject shareObject].userModel dic:dic];
        [self.leftCouViewController updateUserData];
    }
    if (bFir) {
        [JPUSHService setTags:[NSSet setWithObjects:[GlobalObject shareObject].userModel.openid, nil] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
            
        } seq:1];
    }
    
     bFir = NO;
    [self updateEditUserInfor];
}

- (void)updateEditUserInfor
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
}

- (void)updateData:(NSArray *)array
{
    if (array.count == 0) {
        return;
    }
    //Business_hours
    [mutLocation removeAllObjects];
    
    [self.mapView clear];
    
    if (mutMarker.count) {
        
        for (GMSMarker * marker in mutMarker) {
            marker.map = nil;
            marker.position = CLLocationCoordinate2DMake(0, 0);//.latitude;//
        }
        [mutMarker removeAllObjects];
    }
    
    for (int i = 0; i < array.count; i ++) {
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
        NSDictionary *dic = array[i];
        for (NSString *dicKey in [dic allKeys]) {
            
            [mutDic setValue:dic[dicKey] forKey:dicKey];
        }
        
        
        [mutDic setValue:[NSNumber numberWithBool:NO] forKey:@"seleState"];
        //测试
        
        [mutDic setValue:[NSNumber numberWithInt:[dic[@"phangye"] intValue]] forKey:@"industry"];
        [mutLocation addObject:mutDic];
    }
    
    for (int i = 0 ; i < mutLocation.count; i ++) {
        NSDictionary *dic = mutLocation[i];
        GMSMarker * marker;
        
        if (i < mutMarker.count)
        {
            marker = mutMarker[i];
        }
        else
        {
            marker = [[GMSMarker alloc] init];
            [mutMarker addObject:marker];
        }
        //longitude
        marker.position = CLLocationCoordinate2DMake([dic[@"lat"] doubleValue], [dic[@"lng"] doubleValue]);
        
        int onlines = [dic[@"onlines"] intValue];
        
        int industryType = [dic[@"industry"] intValue];
        
        marker.icon = [UserModel getMapIcon:onlines bBig:NO number:industryType];
        
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.title = dic[@"shopName"];
        marker.snippet = dic[@"shopName"];
        marker.map = self.mapView;
    }
}

- (void)updateOtherMarker:(nonnull GMSMarker *)marker
{
    for (int i = 0; i < mutMarker.count; i ++) {
        GMSMarker * oldMarker = mutMarker[i];
        if (marker != oldMarker && i < mutLocation.count) {
            NSMutableDictionary *dic = mutLocation[i];
            
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"seleState"];
            
            int onlines = [dic[@"onlines"] intValue];
            int industryType = [dic[@"industry"] intValue];
            oldMarker.icon = [UserModel getMapIcon:onlines bBig:NO number:industryType];
        }
    }
}

- (void)updateMarkerIcon
{
    for (int i = 0; i < mutLocation.count; i ++) {
        NSMutableDictionary *mutDic = mutLocation[i];
        [mutDic setValue:[NSNumber numberWithBool:NO] forKey:@"seleState"];
    }
    
    for (int i = 0; i < mutLocation.count; i ++) {
        if (i < mutMarker.count) {
            GMSMarker * oldMarker = mutMarker[i];
            
            NSMutableDictionary *dic = mutLocation[i];
            
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"seleState"];
            int onlines = [dic[@"onlines"] intValue];
            int industryType = [dic[@"industry"] intValue];
            
            oldMarker.icon = [UserModel getMapIcon:onlines bBig:NO number:industryType];
            
        }
    }
}

- (void)updateMerchantsBackgrView:(NSDictionary *)dic bSele:(BOOL)bSele
{
    
    if([[dic allKeys]containsObject:@"logo"])
    {
      //  [merchantWindowView.imageIcon sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"]]];
        [merchantWindowView.imageIcon sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                         if (error) {
                             self->merchantWindowView.imageIcon.image = [UIImage imageNamed:@"merchantsDef"];
                         }
                     }];
        
        
        
    }
    else
    {
        merchantWindowView.imageIcon.image = [UIImage imageNamed:@"merchantsDef"];
      //  [merchantWindowView.imageIcon sd_setImageWithURL:[NSURL URLWithString:@"merchantsDef"]];
    }
    
    merchantWindowView.labName.text = dic[@"shopname"];
    
    merchantWindowView.labAddress.text = dic[@"address"];
    
    merchantWindowView.labBusinesshours.text = dic[@"serviceTime"];
    merchantWindowView.labAvailable.text = [NSString stringWithFormat:@"%@: %d",[GlobalObject getCurLanguage:@"Available"],[dic[@"batteryCount"] intValue]];
    
    merchantWindowView.labCanreturn.text = [NSString stringWithFormat:@"%@: %d",[GlobalObject getCurLanguage:@"Can return"],[dic[@"returnCount"] intValue]];
    
    merchantWindowView.labDistance.text = [NSString stringWithFormat:@"%@: %dm",[GlobalObject getCurLanguage:@"Distance"],[dic[@"distance"] intValue]];
    
    merchantWindowView.shopId = dic[@"shopId"];
    
    merchantWindowView.hidden = !bSele;
    
    viewSweepCode.hidden = bSele;
}

//
- (void)openUserView:(NSString *)user_Id
{//收费规则界面
    if (qqlBXScanViewController) {
        [qqlBXScanViewController.navigationController popViewControllerAnimated:NO];
        qqlBXScanViewController = nil;
    }
    if (![user_Id containsString:@"/"]) {
        NSString *strPro =CurLanguageCon(@"Please scan the correct QR code");
        [gAppDelegate showAlter:strPro bSucc:YES];
        return;
    }
    NSArray *array = [user_Id componentsSeparatedByString:@"/"];
    
    [self requestCheck:array.lastObject];
    
}

- (void)pushQQLBXScanViewController
{
    qqlBXScanViewController = [QrCodeScanningViewController new];
    qqlBXScanViewController.delegate = self;
    [self.navigationController pushViewController:qqlBXScanViewController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestUserInfor];
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //设置文字颜色 大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16]}];
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor clearColor] image:nil isOpaque:YES];//颜色
    [self.navigationController.navigationBar navBarAlpha:0 isOpaque:NO];//透明度 如果设置了透明度 所以导航栏会隐藏
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];//隐藏底线
    
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDarkContent;//黑色
        //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
    } else {
        //  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色
        // Fallback on earlier versions
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
