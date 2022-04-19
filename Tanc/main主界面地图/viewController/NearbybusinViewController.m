//
//  NearbybusinViewController.m
//  Tanc
//
//  Created by f on 2019/12/12.
//  Copyright © 2019 f. All rights reserved.
//

#import "NearbybusinViewController.h"
#import "NearbybusineTableViewCell.h"
#import "BusinessDetailsViewController.h"

@interface NearbybusinViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tabView;
    NSMutableArray *mutArray;
    int pageNumber;
}

@property (nonatomic,strong)UIView *viewBackgrSear;
@end

@implementation NearbybusinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    mutArray = [NSMutableArray array];
    
    [self initUI];
    
    [self headterRereshing];
    
     [super setBtnGOHiddenNO];
    // Do any additional setup after loading the view.
}
 
- (void)initUI
{
    CGRect  rect = MY_RECT(0, 79 - PhoneHeight, IPHONE6SWIDTH, 523 - 46);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    rect.size.height = HEIGHT -  rect.origin.y;
    tabView = [[UITableView alloc]initWithFrame:rect];
    [self.view addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;

    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tabView addFooterWithTarget:self action:@selector(footerRereshing)];
    tabView.footerPullToRefreshText = CurLanguageCon(@"Release to load more data");
    tabView.footerReleaseToRefreshText = CurLanguageCon(@"Release to load more data");
    tabView.footerRefreshingText = CurLanguageCon(@"Loading data, please wait…");
    tabView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
  [tabView addHeaderWithTarget:self action:@selector(headterRereshing)];
    tabView.headerPullToRefreshText = CurLanguageCon(@"Free redraw data");
    tabView.headerReleaseToRefreshText = CurLanguageCon(@"Free redraw data");
    tabView.headerRefreshingText = CurLanguageCon(@"Please wait while the data is being redrawn ...");
    tabView.estimatedRowHeight = 0;
    tabView.estimatedSectionFooterHeight = 0;
    tabView.estimatedSectionHeaderHeight = 0;
     
}

- (UIView *)viewBackgrSear
{
    if (!_viewBackgrSear) {
        
        CGRect rect = MY_RECT(0, 223, IPHONE6SWIDTH, 240);
        _viewBackgrSear = [[UIView alloc]initWithFrame:rect];
        [self.view addSubview:_viewBackgrSear];
        
        UIImage *image  = [UIImage imageNamed:@"notData"];
        rect = MY_RECT(0, 0, 217, 131);
        rect.size.width = rect.size.height / image.size.height * image.size.width;
        rect.origin.x = (WIDTH - rect.size.width) / 2.0;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
        [_viewBackgrSear addSubview:imageView];
        imageView.image = image;
        
        rect = MY_RECT(93, 161, (IPHONE6SWIDTH - 93 * 2), 32);
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [_viewBackgrSear addSubview:lab];
        lab.text = CurLanguageCon(@"There are no businesses nearby, look at other places ~");
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0];
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
        
    }
    return _viewBackgrSear;
}

- (void)headterRereshing
{
    pageNumber = 1;
    [self requestAct:1 pageSize:5  bRefresh:YES];
}

- (void)footerRereshing
{
    pageNumber ++;;
    
    [self requestAct:pageNumber pageSize:5 bRefresh:NO];
}

- (void)requestAct:(int)pageNum pageSize:(int)pageSize  bRefresh:(BOOL)bRefresh
{
    
    __weak typeof(self) weakSelf = self;
    //longitude=113.88410&latitude=22.55329
    [gAppDelegate createActivityView];
 
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/UserApp/Shop/nearby2"];
//    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
//    [mutDic setValue:[NSNumber numberWithInt:pageNum] forKey:@"page"];
//    [mutDic setValue:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
//
//    [mutDic setValue:[GlobalObject shareObject].nearbyLatitude forKey:@"latitude"];
//    [mutDic setValue:[GlobalObject shareObject].nearbyLongitude forKey:@"longitude"];
    
    NSDictionary *dic = @{@"longitudeCenter":[GlobalObject shareObject].curLongitude,
                          @"latitudeCenter":[GlobalObject shareObject].curLatitude,
                          @"longitude":[GlobalObject shareObject].nearbyLongitude,
                          @"latitude":[GlobalObject shareObject].nearbyLatitude,
                          @"page":[NSNumber numberWithInt:pageNum],
                          @"pageSize":[NSNumber numberWithInt:pageSize]};
    
    
    [CLNetwork POST:str parameter:dic success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        [weakSelf updateTabViewState:bRefresh];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            //[weakSelf updateData:@[] bRefresh:bRefresh];
            [weakSelf updateData:responseObject[@"data"] bRefresh:bRefresh];
        }
        else
        {
            [gAppDelegate showAlter:responseObject[@"msg"] bSucc:NO];
              [weakSelf updateData:@[] bRefresh:bRefresh];
        }
    } failure:^(NSError *error) {
        
        [weakSelf updateTabViewState:bRefresh];
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
}

- (void)updateTabViewState:(BOOL)bRefresh
{
    if (bRefresh) {
        [tabView headerEndRefreshing];
    }
    else
    {
        [tabView footerEndRefreshing];
    }
}

- (void)updateData:(NSArray *)array bRefresh:(BOOL)bRefresh
{
    if (bRefresh) {
          [mutArray removeAllObjects];
      }
    if (array.count == 0 && mutArray.count == 0) {
        self.viewBackgrSear.hidden = NO;
        tabView.hidden = YES;
        return;
    }
    else
    {
        self.viewBackgrSear.hidden = !NO;
        tabView.hidden = !YES;
    }
      
  
    for (int i = 0; i < array.count; i ++) {
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
        NSDictionary *dic = array[i];
        for (NSString *dicKey in [dic allKeys]) {

            [mutDic setValue:dic[dicKey] forKey:dicKey];
        }

        [mutArray addObject:mutDic];
    }
   //
    [tabView reloadData];
    
}


#pragma mark ---tablview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {CGFloat sectionHeaderHeight = 80;if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);} else if (scrollView.contentOffset.y>=sectionHeaderHeight) {scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    
}
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 136 / IPHONE6SHEIGHT * HEIGHT;
}
  
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"cell_id";
    NearbybusineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell) {
        
        cell = [[NearbybusineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
          cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *dic = mutArray[indexPath.row];
  
    if ([dic[@"logo"] length] > 0) {
        //  [cell.imageIcon sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"] ]];
        
        [cell.imageIcon sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error) {
                cell.imageIcon.image = [UIImage imageNamed:@"merchantsDef"];
            }
        }];
        
    }
    else
    {
        cell.imageIcon.image = [UIImage imageNamed:@"merchantsDef"];
    }
    cell.labName.text = dic[@"shopname"];
    cell.labTimer.text = dic[@"serviceTime"];
    cell.labAddress.text = dic[@"address"];
    
    cell.labAvailable.text = [NSString stringWithFormat:@"%@: %@",[GlobalObject getCurLanguage:@"Available"],dic[@"batteryCount"]];
    
    cell.labCanreturn.text = [NSString stringWithFormat:@"%@: %@",[GlobalObject getCurLanguage:@"Can return"],dic[@"returnCount"]];
    
    cell.labDistance.text = [GlobalObject getDistanceTransformation:[dic[@"distance"] intValue]];;
 
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mutArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = mutArray[indexPath.row];
    
    BusinessDetailsViewController *viewController = [[BusinessDetailsViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.shopId = dic[@"shopId"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(void)viewWillAppear:(BOOL)animated
{
    self.title = CurLanguageCon(@"Nearby businesses");
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    //设置文字颜色 大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],NSFontAttributeName : [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16]}];
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


//-(id)getDataConversion:(id)resData
//{
////    if (resData isKindOfClass:[clase]) {
////        <#statements#>
////    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
