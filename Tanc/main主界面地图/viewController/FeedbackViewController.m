//
//  FeedbackViewController.m
//  ChargingTreasure
//
//  Created by f on 2019/6/27.
//  Copyright © 2019 Mr.fang. All rights reserved.
//

#import "FeedbackViewController.h"
#import "WSPlaceholderTextView.h"
#import "PYPhotoBrowser.h"
#import "TZImagePickerController.h"
#import "FeedBackButton.h"
 
#import "QrCodeScanningViewController.h"

#import "AFNetworking.h"
#define PublishedViewTag 500

#define CCWeakSelf __weak typeof(self) weakSelf = self

@interface FeedbackViewController ()<QrCodeScanningViewControllerDelegate,PYPhotosViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UIScrollView *scrollView;//
    UITextField *textFieldCode;
    
    UITextField *textFieldPhone;
    WSPlaceholderTextView *textViewHelp;
    QrCodeScanningViewController *qqlBXScanViewController;
    BOOL bAnimation;
    NSString *seleButId;
    CGFloat floY;
    
    NSMutableArray *mutButton;
    NSMutableArray *mutButData;
    
    
    NSMutableArray *mutImage;
    NSMutableArray *mutImageView;
    NSMutableArray *mutButArray;
    UIButton *buttonAdd;
    
    UIView *viewBackgr;
    
    NSInteger seleUpNumber;
    
    NSMutableArray *imageStrArray;
    
    UILabel *labNumber;//记录当前个数
}
@property (nonatomic, weak) PYPhotosView *publishPhotosView;//属性 保存选择的图片
@property(nonatomic,strong)NSMutableArray *photos;
@property(nonatomic,assign)int repeatClickInt;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [super setGoBackBlackImage];
    
    [self initData];
    
    [self initUI];
    
    [self requestButtonData];
    
    
     [super setBtnGOHiddenNO];
    // Do any additional setup after loading the view.
}


- (void)initData
{
    mutButton = [NSMutableArray array];
    mutButData = [NSMutableArray array];
    
    mutImage = [NSMutableArray array];
    mutImageView = [NSMutableArray array];
    mutButArray = [NSMutableArray array];
    
    imageStrArray = [NSMutableArray array];
    
    self.title = CurLanguageCon(@"Question or feedback");
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initUI
{
    CGRect rect = MY_RECT(0, 82 - PhoneHeight, IPHONE6SWIDTH, IPHONE6SHEIGHT - 77);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    rect.size.height = HEIGHT - rect.origin.y;
    scrollView = [[UIScrollView alloc]initWithFrame:rect];
    [self.view addSubview:scrollView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScroll)];
    [scrollView addGestureRecognizer:tapGes];
    
    
    rect = MY_RECT(19, 0, 337, 32);
    UIView *viewTop = [[UIView alloc]initWithFrame:rect];
    [scrollView addSubview:viewTop];
    viewTop.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:250/255.0 alpha:1.0];
    viewTop.layer.cornerRadius = 3;
    
    
    
    rect = MY_RECT(16, 0 , 260, 32);
    textFieldCode = [[UITextField alloc]initWithFrame:rect];
    [viewTop addSubview:textFieldCode];
    textFieldCode.textAlignment = NSTextAlignmentLeft;
    textFieldCode.placeholder = CurLanguageCon(@"device ID");
    textFieldCode.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14];
    textFieldCode.textColor = [UIColor blackColor];
    textFieldCode.textAlignment = NSTextAlignmentLeft;
    textFieldCode.keyboardType = UIKeyboardTypeAlphabet;
    textFieldCode.delegate = self;
    
    rect = MY_RECT(303, (32 - 22) / 2.0, 22, 22);
    rect.size.width = rect.size.height;
    UIButton *buttonOrCode = [[UIButton alloc]initWithFrame:rect];
    [viewTop addSubview:buttonOrCode];
    [buttonOrCode setImage:[UIImage imageNamed:@"feedbackQrCode"] forState:UIControlStateNormal];
    
    [buttonOrCode addTarget:self action:@selector(clickOrCode) forControlEvents:UIControlEventTouchUpInside];
    //40
    rect = MY_RECT(20, 47, 333, 17);
    UILabel *labPro = [[UILabel alloc]initWithFrame:rect];
    [scrollView addSubview:labPro];
    labPro.text = CurLanguageCon(@"Please select feedback type");
    labPro.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
    labPro.textColor = [UIColor colorWithRed:14/255.0 green:14/255.0 blue:16/255.0 alpha:1.0];
    labPro.textAlignment = NSTextAlignmentLeft;
    
}

- (void)createButton
{//mutButArray
    int number = (int)mutButArray.count;
    for (int i = number; i < mutImage.count; i ++) {
        CGRect rect = MY_RECT((104 + 7 - 19) * i, 0, 60 + 7.5,60 +7.5);
        rect.size.width = rect.size.height ;
        UIView *viewImageBackg = [[UIView alloc]initWithFrame:rect];
        [viewBackgr addSubview:viewImageBackg];
        
        rect = MY_RECT( 0, 7.5, 75 , 60 );
        rect.size.width = rect.size.height;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
        [viewImageBackg addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = mutImage[i];
        imageView.clipsToBounds = YES;
        // imageView.backgroundColor = [UIColor redColor];
        [mutButArray addObject:viewImageBackg];
        [mutImageView addObject:imageView];
        imageView.userInteractionEnabled = YES;
        
        rect = MY_RECT(0, 0, 14, 14);
        rect.size.height = rect.size.width;
        rect.origin.x = viewImageBackg.frame.size.width - rect.size.width;
         
        UIButton *btnDelegate = [[UIButton alloc]initWithFrame:rect];
        [btnDelegate setImage:[UIImage imageNamed:@"feedbackClose"] forState:UIControlStateNormal];
        //        btnDelegate.backgroundColor = [UIColor yellowColor];
        [viewImageBackg addSubview:btnDelegate];
        [btnDelegate addTarget:self action:@selector(clickDelete:) forControlEvents:UIControlEventTouchUpInside];
        btnDelegate.tag = PublishedViewTag + i;
    }
    number = (int)mutButArray.count;
    CGRect rect = buttonAdd.frame;
    rect.origin.x = (104 + 7 - 19) * number / IPHONE6SWIDTH * WIDTH;
    buttonAdd.frame = rect;
    buttonAdd.hidden = mutImageView.count == 3 ? YES : NO;
    labNumber.text = [NSString stringWithFormat:@"%ld/%d",mutButArray.count,3];
}

- (void)initButtonUI
{
    floY = (164 - 82) / IPHONE6SHEIGHT * HEIGHT;
    CGFloat floX = 19 / IPHONE6SWIDTH * WIDTH;
    for (int i = 0; i < mutButData.count; i ++) {
        NSDictionary *dic =mutButData[i];
        NSString *btnText = dic[@"name"];
        seleButId = i == 0 ? dic[@"id"] : seleButId;
        CGRect rect = MY_RECT(0, 0, 0, 30);
        
        
        
        
        FeedBackButton *button = [[FeedBackButton alloc]initWithFrame:rect];
        [scrollView addSubview:button];
        [button setButtonText:btnText];
        
        BOOL bSele = i == 0 ? YES : NO;
    
        
        CGFloat  floWid = button.frame.size.width;
        floWid = floWid + 30 / IPHONE6SWIDTH * WIDTH;
        if (floWid + floX < IPHONE6SWIDTH - 19 / IPHONE6SWIDTH * WIDTH) {
            
        }
        else
        {
            floX = 19 / IPHONE6SWIDTH * WIDTH;
            floY = floY + 45 / IPHONE6SHEIGHT * HEIGHT;
        }
        
        rect = button.frame;
        rect.origin.x = floX;
        rect.origin.y = floY;
        button.frame = rect;
        [button createViewBtn:rect];
        [button setCurSele:bSele];
        
        [button.button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [mutButton addObject:button];
        
        floX = floX + floWid + 15 / IPHONE6SWIDTH * WIDTH;
    }
    
    floY = floY + 57 / IPHONE6SHEIGHT * HEIGHT;
    
    CGRect rect = MY_RECT(20, 47, 333, 17);
    rect.origin.y = floY;
    UILabel *labPro = [[UILabel alloc]initWithFrame:rect];
    [scrollView addSubview:labPro];
    labPro.text = CurLanguageCon(@"Please enter the phone number");
    labPro.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
    labPro.textColor = [UIColor colorWithRed:14/255.0 green:14/255.0 blue:16/255.0 alpha:1.0];
    labPro.textAlignment = NSTextAlignmentLeft;
    
    
    floY = floY + 17 * 2 / IPHONE6SHEIGHT * HEIGHT;
    
    rect = MY_RECT(19, 0, 300, 44);
    rect.origin.y = floY;
    
    UIView *viewPhone = [[UIView alloc]initWithFrame:rect];
    [scrollView addSubview:viewPhone];
    viewPhone.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:250/255.0 alpha:1.0];
    [viewPhone qi_clipCorners:UIRectCornerAllCorners radius:3];
    
    rect.origin.x = 32 / IPHONE6SWIDTH * WIDTH;
    textFieldPhone = [[UITextField alloc]initWithFrame:rect];
    [scrollView addSubview:textFieldPhone];
    textFieldPhone.delegate = self;
    textFieldPhone.keyboardType = UIKeyboardTypeNumberPad;
    textFieldPhone.textColor = [UIColor blackColor];
     textFieldPhone.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14];
    textFieldPhone.placeholder = CurLanguageCon(@"Please enter the phone number");
  
    floY = floY + (44 + 13) / IPHONE6SHEIGHT * HEIGHT;
    
    rect = MY_RECT(19, 0, 335, 119);
    rect.origin.y = floY;
    textViewHelp = [[WSPlaceholderTextView alloc]initWithFrame:rect];
    textViewHelp.placeholder = CurLanguageCon(@"Enter your question here, sorry for the bad experience, we will contact you as soon as possible");
    textViewHelp.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14];
    textViewHelp.textAlignment = NSTextAlignmentLeft;
    textViewHelp.delegate = self;
    [scrollView addSubview:textViewHelp];
    [textViewHelp qi_clipCorners:UIRectCornerAllCorners radius:3];
    textViewHelp.keyboardType = UIKeyboardTypeDefault;
    textViewHelp.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:250/255.0 alpha:1.0];
    floY = floY + (19 + 119) / IPHONE6SHEIGHT * HEIGHT;
    
    
    rect = MY_RECT(19, 0, IPHONE6SWIDTH, 90);
    rect.origin.y = floY;
    viewBackgr = [[UIView alloc]initWithFrame:rect];
    [scrollView addSubview:viewBackgr];
    viewBackgr.clipsToBounds = YES;
    
    rect = MY_RECT(342 - 20 - 19, 27, 14 + 20, 9);
    labNumber = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labNumber];
    labNumber.textAlignment = NSTextAlignmentRight;
    labNumber.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:11];
    labNumber.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    labNumber.text = [NSString stringWithFormat:@"%d/%d",0,3];
    
    
    rect = MY_RECT(00, 7.5, 60, 60 );
    rect.size.width = rect.size.height;
    buttonAdd = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonAdd];
    [buttonAdd setBackgroundImage:[UIImage imageNamed:@"phoneAdd"] forState:UIControlStateNormal];
    [buttonAdd addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
    
    
    floY = floY + 102 / IPHONE6SHEIGHT * HEIGHT;
    rect = MY_RECT((IPHONE6SWIDTH - 286) / 2.0, 522, 286, 44);
    rect.origin.y = floY;
    
    UIView *viewBtnBackgr = [[UIView alloc]initWithFrame:rect];
      [scrollView addSubview:viewBtnBackgr];
      
      CAGradientLayer *gl = [CAGradientLayer layer];
      gl.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
      gl.startPoint = CGPointMake(0, 0);
      gl.endPoint = CGPointMake(1, 1);
      gl.colors = @[(__bridge id)[UIColor colorWithRed:0x93/255.0 green:0xc1/255.0 blue:0x5f/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0x63/255.0 green:0xb1/255.0 blue:0x5e/255.0 alpha:1.0].CGColor];
      gl.locations = @[@(0.0),@(1.0)];
      
      [viewBtnBackgr.layer addSublayer:gl];
      viewBtnBackgr.shadowOpacity(0.7).shadowColor((UIColor *)[UIColor colorWithRed:99/255.0 green:177/255.0 blue:94/255.0 alpha:1.0]).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    
    
    UIButton *buttonOK = [[UIButton alloc]initWithFrame:rect];
    [scrollView addSubview:buttonOK];
    [buttonOK setTitle:[GlobalObject getCurLanguage:@"submit"] forState:UIControlStateNormal];
    [buttonOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonOK addTarget:self action:@selector(clickOver) forControlEvents:UIControlEventTouchUpInside];
    
//    buttonOK.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
//    buttonOK.shadowOpacity(0.7).shadowColor((UIColor *)AllColorShadow).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    scrollView.contentSize = CGSizeMake(WIDTH, rect.origin.y + rect.size.height + 15);
}


- (void)requestButtonData
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/UserApp/More/repair_reason"];
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            [ weakSelf updateData:responseObject[@"data"]];
        }
        else
        {
            [gAppDelegate showAlter:responseObject[@"msg"] bSucc:NO];
            // [ weakSelf updateData:@[]];
            
        }
    } failure:^(NSError *error) {
        
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
    
}

- (void)updateData:(NSArray *)array
{
    for (int i = 0; i < array.count; i ++) {
        [mutButData addObject:array[i]];
    }
    [self initButtonUI];
}


#pragma mark ---clickOrCode

- (void)clickOver
{
    if ([textViewHelp.text length] <= 0) {
        [gAppDelegate showAlter:@"Please write down questions and comments"  bSucc:NO];
    }
    else if ([textFieldCode.text length] <= 0)
    {
        [gAppDelegate showAlter:@"Please enter the correct device number"  bSucc:NO];
    }
    
    else if ([textFieldPhone.text length] <= 0)
    {
        [gAppDelegate showAlter:@"Please enter the correct phone number"  bSucc:NO];
    }
    else
    {
        [gAppDelegate createActivityView];
        if (mutImage.count > 0) {
            seleUpNumber = 0;
            [imageStrArray removeAllObjects];
            [self requestUpImage:mutImage[seleUpNumber] number:(int)seleUpNumber];
        }
        else
        {
            [self requestFeed];
        }
    }
    
    
    
}

- (void)clickOrCode
{
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
        [self pushQQLBXScanViewController];
    }
    
}

- (void)click:(UIButton *)btn
{
    for (int i = 0; i < mutButton.count; i ++) {
        FeedBackButton *button = mutButton[i];
        if (button.button == btn) {
            [button setCurSele:YES];
            NSDictionary *dic = mutButData[i];
            seleButId =  dic[@"id"]  ;
        }
        else
        {
            [button setCurSele:NO];
        }
    }
}


- (void)clickAdd
{
    if (self.repeatClickInt !=2) {
        self.repeatClickInt = 2;
        // 1. 常见一个发布图片时的photosView
        PYPhotosView *publishPhotosView = [PYPhotosView photosView];
        publishPhotosView.py_x = 5;
        publishPhotosView.py_y = 100;
        // 2.1 设置本地图片
        publishPhotosView.images = nil;
        // 3. 设置代理
        publishPhotosView.delegate = self;
        publishPhotosView.photosMaxCol = 5;//每行显示最大图片个数
        publishPhotosView.imagesMaxCountWhenWillCompose = 9;//最多选择图片的个数
        // 4. 添加photosView
        [self.view addSubview:publishPhotosView];
        self.publishPhotosView = publishPhotosView;
        
        
        publishPhotosView.hidden = YES;
        
    }
    [self.publishPhotosView addImageDidClicked];
}


- (void)setTailoringImage:(UIImage *)image
{
    [self.navigationController setNavigationBarHidden:NO];
    
    [mutImage addObject:image];
    
    [self createButton];
    //刷新位置啦
}

- (void)clickDelete:(UIButton *)btn
{
    int tag = (int)btn.tag - PublishedViewTag;
    
    UIImageView * imageView = mutButArray[tag];
    [imageView removeFromSuperview];
    [mutButArray removeObjectAtIndex:tag];
    [mutImageView removeObjectAtIndex:tag];
    
    [mutImage removeObjectAtIndex:tag];
    
    [self updateBtnRect];
}

- (void)updateBtnRect
{
    for (int i = 0; i < mutButArray.count; i ++) {
        
        UIImageView *imageView = mutButArray[i];
        
        
        CGRect  rect =  imageView.frame;
        rect.origin.x = (104 + 7 - 19) * i / IPHONE6SWIDTH * WIDTH;
        imageView.frame = rect;
        
        for (id view in [imageView subviews]) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btnDelete =(UIButton *) view;
                btnDelete.tag = PublishedViewTag + i;
            }
        }
        
        // btnDelegate.tag = PublishedViewTag + i;
    }
    CGRect rect = buttonAdd.frame;
    rect.origin.x = (104 + 7 - 19) * mutButArray.count / IPHONE6SWIDTH * WIDTH;
    buttonAdd.frame = rect;
    buttonAdd.hidden = mutImageView.count == 3 ? YES : NO;
    labNumber.text = [NSString stringWithFormat:@"%ld/%d",mutButArray.count,3];
}

- (void)tapScroll
{
    [textFieldCode resignFirstResponder];
    [textViewHelp resignFirstResponder];
    [textFieldPhone resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != textFieldCode || touch.view != textViewHelp ||  touch.view != textFieldPhone) {
        [textFieldCode resignFirstResponder];
        [textViewHelp resignFirstResponder];
        [textFieldPhone resignFirstResponder];
    }
}

#pragma mark - PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images{
    // 在这里做当点击添加图片按钮时，你想做的事。
    [self getPhotos];
}
// 进入预览图片时调用, 可以在此获得预览控制器，实现对导航栏的自定义
- (void)photosView:(PYPhotosView *)photosView didPreviewImagesWithPreviewControlelr:(PYPhotosPreviewController *)previewControlelr{
}
//进入相册的方法:
-(void)getPhotos{
    CCWeakSelf;
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9-weakSelf.photos.count delegate:weakSelf];
    imagePickerVc.maxImagesCount = 3 - weakSelf.photos.count;//最小照片必选张数,默认是0
    imagePickerVc.sortAscendingByModificationDate = NO;// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        
        //        for (UIImage *image in photos) {
        //            [weakSelf requestData:image];//requestData:图片上传方法 在这里就不贴出来了
        //        }
        for (int i = 0; i < photos.count; i ++) {
            [weakSelf.photos addObject:photos[i]];
        }
        [self createButton];
        // [self.publishPhotosView reloadDataWithImages:weakSelf.photos];
    }];
    [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
}

-(NSMutableArray *)photos{
    if (_photos == nil) {
        _photos = mutImage;//[[NSMutableArray alloc]init];
        
    }
    return _photos;
}


#pragma mark --- textField delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == textFieldCode) {
        bAnimation = NO;
    }
    else
    {
        bAnimation = YES;
    }
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    bAnimation = NO;
    return YES;
}



- (void)keyboardShow:(NSNotification *)aNotification
{
    CGRect keyBoardRect=[[[aNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue];
    NSTimeInterval animalInterval=[[[aNotification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (bAnimation) {
        [UIView beginAnimations:@"keyboardshow" context:nil];
        [UIView setAnimationDuration:animalInterval];
        self.view.frame=CGRectMake(0, -keyBoardRect.size.height + 100, WIDTH, HEIGHT);
        [UIView commitAnimations];
    }
    
}

-(void)keyboardHide:(NSNotification *)aNotification
{
    NSTimeInterval animalInterval=[[[aNotification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView beginAnimations:@"keyboardshow" context:nil];
    [UIView setAnimationDuration:animalInterval];
    self.view.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    [UIView commitAnimations];
}



- (void)requestUpImage:(UIImage *)image number:(int)numb
{
    __weak __typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30; // 设置超时
    
    
    AFJSONResponseSerializer *serializer = [[AFJSONResponseSerializer alloc] init];
    serializer.removesKeysWithNullValues = YES; // 去掉Null
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"multipart/form-data",@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    manager.responseSerializer = serializer;
    [manager.requestSerializer setValue:[GlobalObject shareObject].toKenSear forHTTPHeaderField:@"token"];
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/api/upload"];
    
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:str parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //        for (int i = 0; i < mutImage.count; i ++) {
        NSData *data;
        //        UIImage *image =  mutImage[i];
        UIImage * newImage = [self setThumbnailFromImage:image];
        NSString *imageType = @"png";
        data = UIImagePNGRepresentation(newImage);
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@%d.%@", str,numb,imageType];
        
        //上传
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:[NSString stringWithFormat:@"image/%@",imageType]];
        // }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {//UpdateUserIcon
        NSDictionary *JSON =(NSDictionary *) responseObject; //[NSJSONSerialization
        // NSLog(@"上传成功 %@", responseObject);
        
        if ([JSON isKindOfClass:[NSDictionary class]] && [[JSON allKeys] containsObject:@"code"] && [JSON[@"code"] intValue] != 1)  {
            [gAppDelegate removeActivityView];
            [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:NO];
            return ;
        }
        NSString *pathIma = JSON[@"data"][@"path"];
        [weakSelf overUpImage:pathIma];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [gAppDelegate removeActivityView];
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
    }];
}

- (void)overUpImage:(NSString *)strIma
{
    [imageStrArray addObject:strIma];
    
    seleUpNumber ++ ;
    if (seleUpNumber < mutImage.count) {
        
        [self requestUpImage:mutImage[seleUpNumber] number:(int)seleUpNumber];
    }
    else
    {//开始请求
        [self requestFeed];
    }
}

- (void)requestFeed
{
    __weak __typeof(self) weakSelf = self;
    
    NSMutableDictionary *dic = [self getRequDic];
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/UserApp/More/repair"];
    [CLNetwork POST:str parameter:dic success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:YES];
            [weakSelf.navigationController popViewControllerAnimated:YES];
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


- (UIImage *)setThumbnailFromImage:(UIImage *)image
{
    UIImage *newimage;
    CGSize oldsize = image.size;
    // CGFloat imageWid = oldsize.height / (oldsize.width / (1000 / IPHONE6SWIDTH * WIDTH));//
    // 1334
    CGSize asize;
    if(image.size.height > 1000)
    {
        asize = CGSizeMake(oldsize.width / (oldsize.height / 1000.0 ) , 1000 );
    }
    else
    {
        asize = oldsize;
    }
    
    
    if (nil == image)
    {
        
        newimage = nil;
    }
    else
    {
        
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            
            rect.size.height = asize.height;
            
            rect.origin.x = (asize.width - rect.size.width)/2;
            
            rect.origin.y = 0;
            
        }
        
        else{
            
            rect.size.width = asize.width;
            
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            rect.origin.x = 0;
            
            rect.origin.y = (asize.height - rect.size.height)/2;
            
        }
        
        
        UIGraphicsBeginImageContext(asize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    
    return newimage;
    
}

- (void)pushQQLBXScanViewController
{
    qqlBXScanViewController = [QrCodeScanningViewController new];
     qqlBXScanViewController.delegate = self;
      [self.navigationController pushViewController:qqlBXScanViewController animated:YES];
}

- (void)openUserView:(NSString *)user_Id
{
    if (qqlBXScanViewController) {
        [qqlBXScanViewController.navigationController popViewControllerAnimated:NO];
        qqlBXScanViewController = nil;
    }
    if (![user_Id containsString:@"/"]) {
        NSString *strPro =CurLanguageCon(@"Please scan the correct QR code");
        [gAppDelegate showAlter:strPro bSucc:NO];
        //        [qqlBXScanViewController drawBottomItems];
        //        [qqlBXScanViewController drawTitle];
        return;
    }
    NSArray *array = [user_Id componentsSeparatedByString:@"/"];
    textFieldCode.text = array.lastObject;
    //    [self.navigationController pushViewController: [ChargingRulesViewController new] animated:YES];
}


- (NSMutableDictionary *)getRequDic
{
    NSString *strImage = @"";
    for (int i = 0; i < imageStrArray.count; i ++) {
        if (i == 0) {
            strImage = imageStrArray[i];
        }
        else
        {
            strImage = [NSString stringWithFormat:@"%@,%@",strImage,imageStrArray[i]];
        }
    }
    
    
    
    NSMutableDictionary *mutDic =[NSMutableDictionary dictionary];
    
    [mutDic setValue:seleButId forKey:@"reason"];
    
    [mutDic setValue:textViewHelp.text forKey:@"mask"];
    
    [mutDic setValue:textFieldCode.text forKey:@"deviceID"];
    
    [mutDic setValue:textFieldPhone.text forKey:@"mobile"];
    if ([strImage length] > 0) {
        [mutDic setValue:strImage forKey:@"pic"];
    }
    return mutDic;
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    //设置文字颜色 大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16]}];
    
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
