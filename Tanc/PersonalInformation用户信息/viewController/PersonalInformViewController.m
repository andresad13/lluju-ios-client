//
//  PersonalInformViewController.m
//  Tanc
//
//  Created by f on 2019/12/6.
//  Copyright © 2019 f. All rights reserved.
//

#import "PersonalInformViewController.h"
#import "PYPhotoBrowser.h"
#import "TZImagePickerController.h"
#import "TailoringImageView.h"
#import "AFNetworking.h"
#import "UserInputBoxView.h"

#define PersonalTag 400

@interface PersonalInformViewController ()<UIImagePickerControllerDelegate,PYPhotosViewDelegate,TailoringImageDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,UserInputBoxViewDelegate>
{
    UIImageView *imageIcon;
    
    UIImage *imageNew;
    
    NSString *strImagePath;
    NSString *strUrlImage;
    
    NSString *userName;//d用户名称
    NSString *userEmail;//用户邮箱
    
    int curSeleEdit;//当前需要修改的类型 0 头像 1 名字 3 邮件
    
    NSMutableArray *mutLabText;//存储显示label
}

@property (nonatomic, weak) PYPhotosView *publishPhotosView;//属性 保存选择的图片
@property(nonatomic,strong)NSMutableArray *photos;
@property(nonatomic,assign)int repeatClickInt;

@end

@implementation PersonalInformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    mutLabText = [NSMutableArray array];
    
    [self initUI];
    
     [super setBtnGOHiddenNO];
    // Do any additional setup after loading the view.
}

-(NSMutableArray *)photos{
    if (_photos == nil) {
        _photos = [[NSMutableArray alloc]init];
        
    }
    return _photos;
}

- (void)initData
{
    imageNew = nil;
    strImagePath = @"";
}

- (void)initUI
{
    NSArray *array = @[@"Avatar",@"Nickname",@"Phone number",@"Email"];
    NSArray *arrayTit = @[@"",[GlobalObject shareObject].userModel.userName,[GlobalObject shareObject].userModel.tel,[GlobalObject shareObject].userModel.email];
    for (int i = 0; i < array.count; i ++) {
        
        CGRect rect = MY_RECT(13, 142 - 50 - PhoneHeight + 50 * i, 349, 50);
        rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
        UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
        [self.view addSubview:viewBackgr];
        
        rect = MY_RECT(0, 0, 190, 50);
        UILabel *labTitle = [[UILabel alloc]initWithFrame:rect];
        [viewBackgr addSubview:labTitle];
        labTitle.textColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        labTitle.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
        labTitle.textAlignment = NSTextAlignmentLeft;
        labTitle.text = CurLanguageCon(array[i]);
        
        rect = MY_RECT(0, 49, 349, 1);
        UIView *viewLine = [[UIView alloc]initWithFrame:rect];
        [viewBackgr addSubview:viewLine];
        viewLine.backgroundColor = [UIColor colorWithRed:0xcc / 255.0 green:0xcc / 255.0 blue:0xcc / 255.0 alpha:0.5];
        
        rect = MY_RECT(341, 19.5, 6, 11);
        rect.size.width = rect.size.height / 11.0 * 6;
        UIImageView *imageNext = [[UIImageView alloc]initWithFrame:rect];
        [viewBackgr addSubview:imageNext];
        imageNext.hidden = i == 2 ? YES :NO;
        imageNext.image = [UIImage imageNamed:@"userInfo_next"];
        
        
        if (i == 0) {
            
            rect = MY_RECT(19, 5, 45, 40);
            rect.size.width = rect.size.height;
            rect.origin.x = CGRectGetWidth(viewBackgr.frame) - rect.origin.x - rect.size.width;
            
            imageIcon = [[UIImageView alloc]initWithFrame:rect];
            [viewBackgr addSubview:imageIcon];
            [imageIcon qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
            
            if ([GlobalObject shareObject].userModel.avatar &&  [[GlobalObject shareObject].userModel.avatar length] > 0) {
              //  [imageIcon sd_setImageWithURL:[NSURL URLWithString:[GlobalObject shareObject].userModel.avatar]];
                [imageIcon sd_setImageWithURL:[NSURL URLWithString:[GlobalObject shareObject].userModel.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                          if (error) {
                             self->imageIcon.image = [UIImage imageNamed:@"merchantsDef"];
                          }
                      }];
                
            }
            else
                imageIcon.image = [UIImage imageNamed:@"merchantsDef"];
        }
        else
        {
            CGFloat floLabX = i == 2 ? 0 : 18.5;
            rect = MY_RECT(349 -170 - floLabX, 10, 170, 30);
            UILabel *lab = [[UILabel alloc]initWithFrame:rect];
            [viewBackgr addSubview:lab];
            lab.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
            lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:12];
            lab.textAlignment = NSTextAlignmentRight;
            lab.text = arrayTit[i];
            
            [mutLabText addObject:lab];
        }
        
        rect = MY_RECT(0, 0, 349, 50);
        UIButton *button = [[UIButton alloc]initWithFrame:rect];
        [viewBackgr addSubview:button];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = PersonalTag + i;
        
        
    }
}


- (void)click:(UIButton *)btn
{
    NSInteger tag = btn.tag - PersonalTag;
    curSeleEdit = (int)tag;
    
    
    switch (tag) {
        case 0:
        {
            [self createPhoneAler];
        }
            break;
        case 1:
        case 3:
        {
            CGRect rect = CGRectMake(0, 0, WIDTH, HEIGHT);
            UserInputBoxView *view = [[UserInputBoxView alloc]initWithFrame:rect];
            [gAppDelegate addTopView:view];
            view.delegate = self;
            InputBoxEnum inputBoxEnum = curSeleEdit == 1 ?  InputBox_Name : InputBox_Email;
            UILabel *lab =  mutLabText[curSeleEdit - 1];
            
            [view setInputBoxEnum:inputBoxEnum str:lab.text];
            
        }
            break;
        
        default:
            break;
    }
}

- (void)createPhoneAler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[GlobalObject getCurLanguage:@"Please select an album or take a photo"] preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"Take a photo"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.allowsEditing  = NO;
        imagePickerController.sourceType = sourceType;
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
        NSLog(@"拍照");
        
    }]];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:[GlobalObject getCurLanguage:@"Album"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
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
            publishPhotosView.imagesMaxCountWhenWillCompose = 1;//最多选择图片的个数
            // 4. 添加photosView
            [self.view addSubview:publishPhotosView];
            publishPhotosView.hidden = YES;
            
            self.publishPhotosView = publishPhotosView;
        }
        [self.publishPhotosView addImageDidClicked];
        
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images{
    // 在这里做当点击添加图片按钮时，你想做的事。
    [self getPhotos];
}
// 进入预览图片时调用, 可以在此获得预览控制器，实现对导航栏的自定义
- (void)photosView:(PYPhotosView *)photosView didPreviewImagesWithPreviewControlelr:(PYPhotosPreviewController *)previewControlelr{
    NSLog(@"进入预览图片");
}
//进入相册的方法:
-(void)getPhotos{
    
    __weak __typeof(self) weakSelf = self;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9-weakSelf.photos.count delegate:weakSelf];
    imagePickerVc.maxImagesCount = 1;//最小照片必选张数,默认是0
    imagePickerVc.sortAscendingByModificationDate = NO;// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        NSLog(@"选中图片photos === %@",photos);
        //        for (UIImage *image in photos) {
        //            [weakSelf requestData:image];//requestData:图片上传方法 在这里就不贴出来了
        //        }
        [weakSelf.photos addObjectsFromArray:photos];
        [weakSelf createTailoringImageView:photos.firstObject];
        // [self.publishPhotosView reloadDataWithImages:weakSelf.photos];
    }];
    [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)createTailoringImageView:(UIImage *)image
{
    TailoringImageView *view = [[TailoringImageView alloc]init];
    view.bHeadIcon = YES;
    view.delegate = self;
    view.headImagenew = image;
    [self.navigationController pushViewController:view animated:YES];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self createTailoringImageView:image];
    
    // [_btn setBackgroundImage:image forState:UIControlStateNormal];
}


- (void)setTailoringImage:(UIImage *)image
{
    [self.navigationController setNavigationBarHidden:NO];
    imageIcon.image = image;
    imageNew = image;
    [gAppDelegate createActivityView];
    [self requestUpImage:image number:1];
    //请求
    //[self setImageIcon:image];
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
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/api/upload"];
    
    [manager.requestSerializer setValue:[GlobalObject shareObject].toKenSear forHTTPHeaderField:@"token"];
    
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:str parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //        for (int i = 0; i < mutImage.count; i ++) {
        NSData *data;
        //        UIImage *image =  mutImage[i];
        UIImage * newImage = [GlobalObject setThumbnailFromImage:image];
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
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {//UpdateUserIcon
        NSDictionary *JSON =(NSDictionary *) responseObject; //[NSJSONSerialization
        
        if ([JSON isKindOfClass:[NSDictionary class]] && [[JSON allKeys] containsObject:@"code"] && [JSON[@"code"] intValue] != 1)  {
            [gAppDelegate removeActivityView];
            [gAppDelegate showAlter:responseObject[@"msg"] bSucc:NO];
            return ;
        }
        NSString *pathIma = JSON[@"data"][@"path"];
        [weakSelf overUpImage:pathIma urlImage:JSON[@"data"][@"url"]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [gAppDelegate removeActivityView];
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
    }];
}

- (void)overUpImage:(NSString *)strIma  urlImage:(NSString *)urlStr
{
    strUrlImage = urlStr;
    strImagePath = strIma;
    
    [self request:@"headImg" strEdit:strImagePath];
}

- (void)request:(NSString *)strKey strEdit:(NSString *)strEdit
{
    //strEdit 需要修改的值   strKey需要修改的
    __weak __typeof(self) weakSelf = self;
    
    if (![strKey isEqualToString:@"headImg"]) {
        [gAppDelegate createActivityView];
    }
    
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/UserApp/User/updInfo"];
    
    [mutDic setValue:strEdit forKey:strKey];
    [CLNetwork POST:str parameter:mutDic success:^(id responseObject) {
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            [gAppDelegate showAlter:responseObject[@"msg"] bSucc:YES];
            [weakSelf updateUserData:strEdit];
            
            [weakSelf initData];
        }
        else
        {
            [gAppDelegate showAlter:responseObject[@"msg"] bSucc:NO];
        }
    } failure:^(NSError *error) {
        
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
}


- (void)updateUserData:(NSString *)strEdit
{
    
    switch (curSeleEdit) {
        case 0:
        {//头像
            [GlobalObject shareObject].userModel.avatar = strUrlImage;
        }
            break;
        case 1:
        {//名字
            [GlobalObject shareObject].userModel.userName = strEdit;
            
            UILabel *lab = mutLabText[0];
            lab.text = strEdit;
        }
            break;
        case 3:
        {//邮箱
            [GlobalObject shareObject].userModel.email = strEdit;
            UILabel *lab = mutLabText[2];
            lab.text = strEdit;
        }
            break;
             
        
            
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UpdateUserInfor object:nil];
}


- (void)editTextEnd:(NSString *)str
{
    NSString *strKey = curSeleEdit == 1 ? @"nickName" : @"email";
    [self request:strKey strEdit:str];
}
//

-(void)viewWillAppear:(BOOL)animated
{
    self.title = [GlobalObject getCurLanguage:@"Personal information"];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
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
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色
             //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色
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
