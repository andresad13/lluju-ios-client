//
//  QrCodeScanningViewController.m
//  ChargingTreasure
//
//  Created by f on 2019/11/9.
//  Copyright © 2019 Mr.fang. All rights reserved.
//

#import "QrCodeScanningViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QrCodeScanningViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *viewBackgr;
    
    NSTimer *timer;//时间 d
    BOOL upOrDown;
}
@property (strong, nonatomic) AVCaptureDevice * device; //捕获设备，默认后置摄像头
@property (strong, nonatomic) AVCaptureDeviceInput * input; //输入设备
@property (strong, nonatomic) AVCaptureMetadataOutput * output;//输出设备，需要指定他的输出类型及扫描范围
@property (strong, nonatomic) AVCaptureSession * session; //AVFoundation框架捕获类的中心枢纽，协调输入输出设备以获得数据
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;//展示捕获图像的图层，是CALayer的子类

@property (strong, nonatomic)UIImageView *imageLine;

@end

@implementation QrCodeScanningViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    upOrDown = YES;
    
    [self initUI];
    
    [self setOverView];
    
    [self addProUI];
    
    //  self.imageViewBackgrBlue.hidden = YES;
    
    if (self.device == nil) {
        [self showAlertViewWithMessage:[GlobalObject getCurLanguage:@"No camera detected"]];
        
        return;
    }
    
    [self initScanSetup];
    
    [self startTimerLine];
     
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)startTimerLine
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(statrAnimaView) userInfo:nil repeats:YES];
}

- (void)addProUI
{
    
    NSString *str = @"Please align the device QR code";
    for (int i = 0; i < 1; i ++) {
        CGRect rect = MY_RECT(20, 432, IPHONE6SWIDTH - 40, 17);
        
        UILabel *label = [[UILabel alloc]initWithFrame:rect];
        [self.view addSubview:label];
        label.text = CurLanguageCon(str);
        label.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
    }
    CGRect rect = MY_RECT(0, 503, 54, 54);
    rect.size.width = rect.size.height;
    rect.origin.x  = (WIDTH - rect.size.height) / 2.0;
    UIButton *buttonFlash = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:buttonFlash];
    [buttonFlash setImage:[UIImage imageNamed:@"openLight"] forState:UIControlStateNormal];
    [buttonFlash setImage:[UIImage imageNamed:@"closeLight"] forState:UIControlStateSelected];
    
    [buttonFlash addTarget:self action:@selector(clickFlash:) forControlEvents:UIControlEventTouchUpInside];
    
    
    rect = MY_RECT(20, 569, IPHONE6SWIDTH - 40, 13);
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    [self.view addSubview:label];
    label.text = CurLanguageCon(@"Turn on the flash");
    label.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    rect.size.height = [GlobalObject getStringHeightWithText:label.text font:label.font viewWidth:rect.size.width];
}

- (void)initUI
{
    CGRect rect = MY_RECT(0, 159, 250, 250);
    rect.size.height = rect.size.width;
    viewBackgr = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgr];
    viewBackgr.center = CGPointMake(WIDTH / 2.0, viewBackgr.center.y);
    viewBackgr.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    viewBackgr.image = [UIImage imageNamed:@"QrCodeBackgr"];
    
}

-(UIImageView *)imageLine
{
    if (!_imageLine) {
        CGRect rect = MY_RECT(8, 0, 0, 3);
        rect.size.width = viewBackgr.frame.size.width - rect.origin.x * 2;
        _imageLine = [[UIImageView alloc]initWithFrame:rect];
        [viewBackgr addSubview:_imageLine];
        _imageLine.image = [UIImage imageNamed:@"scanLine"];
    }
    return _imageLine;
}

//input
- (AVCaptureDeviceInput *)input
{
    if (_input == nil) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

- (AVCaptureDevice *)device
{
    if (_device == nil) {
        //AVMediaTypeVideo是打开相机
        //AVMediaTypeAudio是打开麦克风
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureVideoPreviewLayer *)preview
{
    if (_preview == nil) {
        _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    }
    return _preview;
}

- (AVCaptureMetadataOutput *)output
{
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //限制扫描区域(上下左右)
        
        [_output setRectOfInterest:[self rectOfInterestByScanViewRect:viewBackgr.frame]];
    }
    return _output;
}

//session
- (AVCaptureSession *)session
{
    if (_session == nil) {
        //session
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
        }
    }
    return _session;
}

- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
    CGFloat y = (width - CGRectGetWidth(rect)) / 2 / width;
    
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
    
     return   CGRectMake(0, 0, rect.size.width, rect.size.height);
}

//初始化扫描配置
- (void)initScanSetup
{
    //2 添加预览图层
    self.preview.frame = self.view.bounds;
    self.preview.videoGravity = AVLayerVideoGravityResize;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    //3 设置输出能够解析的数据类型
    //注意:设置数据类型一定要在输出对象添加到回话之后才能设置
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode]];
    
    //高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //4 开始扫描
    [self.session startRunning];
    
}


//得到扫描结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        if ([metadataObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            NSString *stringValue = [metadataObject stringValue];
            if (stringValue != nil) {
                [self.session stopRunning];
                [self stopAnimaView];
                //扫描结果
                if (_delegate && [_delegate respondsToSelector:@selector(openUserView:)]) {
                    [_delegate openUserView:stringValue];
                }
                // NSLog(@"1111-------%@",stringValue);
                
                
                
                // 结果的弹框
                // [self showAlertViewWithMessage:stringValue];
                
            }
        }
        
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.session startRunning];
//    [self startTimerLine];
//}


//提示框alert
- (void)showAlertViewWithMessage:(NSString *)message
{
    //弹出提示框后，关闭扫描
    [self.session stopRunning];
    //弹出alert，关闭定时器
    //[_timer setFireDate:[NSDate distantFuture]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:[NSString stringWithFormat:@"%@",message] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        //点击alert，开始扫描
        //  [self.session startRunning];
        //开启定时器
        /// [_timer setFireDate:[NSDate distantPast]];
    }]];
    [self presentViewController:alert animated:true completion:^{
        
    }];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self stopAnimaView];
    
    [self.session stopRunning];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    
    [super viewWillDisappear:animated];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = CurLanguageCon(@"Scan code rental");
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
        //  [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDarkContent;//黑色
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
        //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色
        // Fallback on earlier versions
    }
    
    [super viewWillAppear:animated];
}

#pragma mark ============添加模糊效果============
- (void)setOverView {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = CGRectGetMinX(viewBackgr.frame);
    CGFloat y = CGRectGetMinY(viewBackgr.frame);
    CGFloat w = CGRectGetWidth(viewBackgr.frame);
    CGFloat h = CGRectGetHeight(viewBackgr.frame);
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

- (void)creatView:(CGRect)rect {
    //CGFloat alpha = 0.8;//#3E465C
    UIColor *backColor = [UIColor colorWithWhite:0 alpha:0.7];//[UIColor colorWithRed:0x3E / 255.0 green:0x46 / 255.0 blue:0x5c / 255.0 alpha:1];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    // view.alpha = alpha;
    [self.view addSubview:view];
}

- (void)statrAnimaView
{
    
    CGFloat floMoveHei = 1.5;
    CGRect rect = self.imageLine.frame;
    if (upOrDown) {
        //
        
        if (rect.origin.y + rect.size.height + floMoveHei <= viewBackgr.frame.size.height - 6) {
            rect.origin.y = rect.origin.y + floMoveHei;
        }
        else
        {
            rect.origin.y = rect.origin.y - floMoveHei;
            upOrDown = NO;
            //rect.origin.y = 6;
        }
    }
    else
    {
        if (rect.origin.y - floMoveHei >= 6)
        {
            rect.origin.y = rect.origin.y - floMoveHei;
        }
        else
        {
            rect.origin.y = rect.origin.y + floMoveHei;
            upOrDown = YES;
        }
    }
    _imageLine.frame = rect;
    //NSLog(@"定时器----");
}

- (void)stopAnimaView
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
}

- (void)applicationBecomeActive
{
    [self.session startRunning];
    [self startTimerLine];
    
}
- (void)applicationEnterBackground
{
    [self.session stopRunning];
    [self stopAnimaView];
}

- (void)clickFlash:(UIButton *)button
{
    button.selected = !button.selected;
    [self changeTorch:YES];
}

- (void)changeTorch:(BOOL)bOpen
{
    AVCaptureTorchMode torch = self.input.device.torchMode;
    
    switch (_input.device.torchMode) {
        case AVCaptureTorchModeAuto:
            break;
        case AVCaptureTorchModeOff:
            torch = AVCaptureTorchModeOn;
            break;
        case AVCaptureTorchModeOn:
            torch = AVCaptureTorchModeOff;
            break;
        default:
            break;
    }
    
    [_input.device lockForConfiguration:nil];
    _input.device.torchMode = torch;
    [_input.device unlockForConfiguration];
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
