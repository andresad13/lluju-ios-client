
//
//  OrderViewController.m
//  Tanc
//
//  Created by f on 2019/12/16.
//  Copyright © 2019 f. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderHeaderFooterView.h"
#import "OrderTableViewCell.h"
#import "FSCalendarView.h"
#import "NSDate+FSCalendar.h"
#import "OrderDetailsViewController.h"

@interface OrderViewController ()<FSCalendarDelegate>
{
    NSString *startTime;
    UIButton *buttonOrder;
    UIView *viewBackgr;
    
    UIView *viewBackgrAllData;
    
    UIView *viewTransparency;//黑色透明度
    
    
    UIView *viewdropdown;//控件下拉
    
    UIView *viewOnthepull;//即将上拉
    
    UILabel *labNovember;//日期
    
    NSDate *curData;
    
    BOOL bDrop_down;//下拉
    
    BOOL bUpdateRequ;//是否刷新请求
    
}

@property (nonatomic, strong) FSCalendarView *calendarView;

@property (nonatomic,strong)UIView *viewBackgrSear;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    startTime =  [GlobalObject timestampCurSeconds:str];
    bDrop_down = NO;
    bUpdateRequ = NO;
    
    [super setGoBackBlackImage];
    
    [self initData];
    
    [self initUI];
    
    self.viewBackgrSear.hidden = YES;
    // 初始化日历
    [self initCalendarView];
    
    [self initOnthepull];
    
    [tabView headerBeginRefreshing];
    
    
     [super setBtnGOHiddenNO];
    
    // Do any additional setup after loading the view.
}

- (void)initData
{
    mutArray = [NSMutableArray array];
}

- (UIView *)viewBackgrSear
{
    if (!_viewBackgrSear) {
        
        CGRect rect = MY_RECT(0, 223 + 40, IPHONE6SWIDTH, 240);
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
        lab.text = CurLanguageCon(@"No order ~");
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0];
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
        
    }
    return _viewBackgrSear;
}

- (void)initCalendarView {
    //
    CGRect rect = MY_RECT(0, 0, IPHONE6SWIDTH, 0);
    rect.origin.y = GetRectNavAndStatusHight;
    rect.size.height = (163 - PhoneHeight) / IPHONE6SHEIGHT * HEIGHT;
    viewBackgrAllData  = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgrAllData];
    viewBackgrAllData.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    //kScreenWidth*6/7+kCalendarHeaderViewHeight + 25 / IPHONE6SHEIGHT * HEIGHT
    rect.origin.y = 0;
    rect.size.height =  81 / IPHONE6SHEIGHT * HEIGHT;
    viewBackgr = [[UIView alloc]initWithFrame:rect];
    [viewBackgrAllData addSubview:viewBackgr];
    viewBackgr.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    viewBackgr.clipsToBounds = YES;
    
    self.calendarView = [[FSCalendarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*6/7+kCalendarHeaderViewHeight) withCalendarHeight:kScreenWidth*6/7+kCalendarHeaderViewHeight withShowSingle:YES];
    //   self.calendarView = [[FSCalendarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*6/7+kCalendarHeaderViewHeight) withCalendarHeight:kScreenWidth*6/7+kCalendarHeaderViewHeight withShowSingle:YES];
    self.calendarView.fsDelegate = self;
    [viewBackgr addSubview:self.calendarView];
    
    //下拉刷新
    rect = MY_RECT(0, 81, IPHONE6SWIDTH, 18);
    // rect.size.width = rect.size.height / 7.0 * 13.5;
    viewdropdown = [[UIView alloc]initWithFrame: rect];
    [viewBackgrAllData addSubview:viewdropdown];
    viewdropdown.backgroundColor = [UIColor whiteColor];
    viewdropdown.hidden = NO;
    
    rect = MY_RECT(0, 0, 13.5, 7);
    rect.size.width = rect.size.height / 7.0 * 13.5;
    rect.origin.x = (WIDTH - rect.size.width) / 2.0;
    UIImageView *imagedropdown = [[UIImageView alloc]initWithFrame:rect];
    [viewdropdown addSubview:imagedropdown];
    imagedropdown.image = [UIImage imageNamed:@"helpCenterNext_sele"];
    
    rect = MY_RECT(0, 0, IPHONE6SWIDTH, 18);
    UIButton *buttondropdown = [[UIButton alloc]initWithFrame:rect];
    [viewdropdown addSubview:buttondropdown];
    [buttondropdown addTarget:self action:@selector(clickdropdown) forControlEvents:UIControlEventTouchUpInside];
}

//上拉控件
- (void)initOnthepull
{
    CGRect rect = MY_RECT(0, 0, IPHONE6SWIDTH, 0);
    rect.origin.y = kScreenWidth*6/7+ kCalendarHeaderViewHeight;
    rect.size.height = 86.5 / IPHONE6SHEIGHT  * HEIGHT;
    viewOnthepull = [[UIView alloc]initWithFrame:rect];
    [viewBackgrAllData addSubview:viewOnthepull];
    viewOnthepull.backgroundColor=  [UIColor whiteColor];
    [viewOnthepull qi_clipCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight radius:16];
    viewOnthepull.hidden = YES;
    
    rect = MY_RECT(30, 0, 316, 0.6);
    UIView *viewLine = [[UIView alloc]initWithFrame:rect];
    [viewOnthepull addSubview:viewLine];
    viewLine.backgroundColor = [UIColor colorWithRed:0xe2 / 255.0 green:0xe2 / 255.0 blue:0xe2 / 255.0 alpha:1];
    
    rect = MY_RECT(28, 22, 9.5, 16);
    rect.size.width =  rect.size.height / 16.0 * 9.5;
    UIImageView *viewLeft = [[UIImageView alloc]initWithFrame:rect];
    [viewOnthepull addSubview:viewLeft];
    viewLeft.image = [UIImage imageNamed:@"rental_leftNext"];
    
    rect = MY_RECT(15, 5, 50, 46);
    UIButton *buttonleftNext = [[UIButton alloc]initWithFrame:rect];
    [viewOnthepull addSubview:buttonleftNext];
    [buttonleftNext addTarget:self action:@selector(clickleftNext) forControlEvents:UIControlEventTouchUpInside];
    
    rect = MY_RECT(335, 22, 9.5, 16);
    rect.size.width =  rect.size.height / 16.0 * 9.5;
    UIImageView *imageRight = [[UIImageView alloc]initWithFrame:rect];
    [viewOnthepull addSubview:imageRight];
    imageRight.image = [UIImage imageNamed:@"rental_RightNext"];
    
    rect = MY_RECT(335 - 10, 5, 33, 46);
    UIButton *buttonRightNext = [[UIButton alloc]initWithFrame:rect];
    [viewOnthepull addSubview:buttonRightNext];
    [buttonRightNext addTarget:self action:@selector(clickRightNext) forControlEvents:UIControlEventTouchUpInside];
    
    
    rect = MY_RECT((IPHONE6SWIDTH - 150) / 2.0, 24, 150, 12);
    labNovember = [[UILabel alloc]initWithFrame:rect];
    [viewOnthepull addSubview:labNovember];
    labNovember.textAlignment = NSTextAlignmentCenter;
    labNovember.textColor = [UIColor blackColor];
    labNovember.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14.5];
    labNovember.text = startTime;
    rect = MY_RECT(0, 62, 13.5, 7);
    rect.size.width =  rect.size.height / 7.0 * 13.5;
    rect.origin.x = (WIDTH - rect.size.width) / 2.0;
    UIImageView *imagefollowing = [[UIImageView alloc]initWithFrame:rect];
    [viewOnthepull addSubview:imagefollowing];
    imagefollowing.image = [UIImage imageNamed:@"helpCenterNext"];
    
    rect = MY_RECT(170 - 10, 62 - 10, 60, 26);
    UIButton *buttonfollowing = [[UIButton alloc]initWithFrame:rect];
    [viewOnthepull addSubview:buttonfollowing];
    [buttonfollowing addTarget:self action:@selector(clickfollowing) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initUI
{
    CGRect rect = MY_RECT(0, 191 - 42 - PhoneHeight, IPHONE6SWIDTH, 523 - 46);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    rect.size.height = HEIGHT - rect.origin.y;
    tabView = [[UITableView alloc]initWithFrame:rect];
    [self.view addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tabView addFooterWithTarget:self action:@selector(footerRereshing)];
    tabView.footerPullToRefreshText = CurLanguageCon(@"Load more data");
    tabView.footerReleaseToRefreshText = CurLanguageCon(@"Load more data");
    tabView.footerRefreshingText = CurLanguageCon(@"Loading data, please wait…");
    tabView.backgroundColor = [UIColor clearColor];
    [tabView addHeaderWithTarget:self action:@selector(headterRereshing)];
    tabView.headerPullToRefreshText =  CurLanguageCon(@"Load more data");
    tabView.headerReleaseToRefreshText =  CurLanguageCon(@"Load more data");
    tabView.headerRefreshingText = CurLanguageCon(@"Please wait while the data is being redrawn ...");
    tabView.estimatedRowHeight = 0;
    tabView.estimatedSectionFooterHeight = 0;
    tabView.estimatedSectionHeaderHeight = 0;
    
    rect = MY_RECT(306, 599, 53, 53);
    rect.size.width = rect.size.height;
    UIButton *button = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:button];
    [button setImage:[UIImage imageNamed:@"TodaysOrder"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"AllOrders"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickDate:) forControlEvents:UIControlEventTouchUpInside];
    buttonOrder = button;
    button.selected = YES;
}


#pragma mark ---tablview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {CGFloat sectionHeaderHeight = 80;if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);} else if (scrollView.contentOffset.y>=sectionHeaderHeight) {scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    
}
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 154 / IPHONE6SHEIGHT * HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42.5 / IPHONE6SHEIGHT * HEIGHT;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *strHeadID = @"headID";
    OrderHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:strHeadID];
    if (!view) {
        
        view = [[OrderHeaderFooterView alloc]initWithReuseIdentifier:strHeadID];
        
    }
    NSDictionary *dic = mutArray[section];
    NSString *strOrState = [GlobalObject getOrderState:dic[@"orderState"]];
    view.labState.text = [GlobalObject getCurLanguage:strOrState];
    view.labState.textColor = [GlobalObject getOrderColor:dic[@"orderState"]];
    // [view setLabTitiText:@"水淀粉红色的光"];
    
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"cell_id";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell) {
        
        cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *dic = mutArray[indexPath.section];
    cell.labTime.text = dic[@"borrowTime"];
    cell.labOrderNumer.text = dic[@"orderNum"];
    cell.labRental.text = dic[@"shopName"];

    //  [cell setCurType:_curSeleType];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
  
    
    
    // return array.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailsViewController *viewController = [[OrderDetailsViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
       NSDictionary *dic = mutArray[indexPath.section];
    viewController.orderId = dic[@"orderNum"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return mutArray.count;
}

- (void)requestAct:(int)pageNum pageSize:(int)pageSize  bRefresh:(BOOL)bRefresh
{
    __weak typeof(self) weakSelf = self;
    //longitude=113.88410&latitude=22.55329
    if (!bRefresh) {//不是刷新的时候 创建这个
        [gAppDelegate createActivityView];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/UserApp/order/list"];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInt:pageNum],
                          @"pageSize":[NSNumber numberWithInt:pageSize]};
    
    if (startTime && [startTime length] > 0) {
        dic = @{@"createTime":startTime,
        @"page":[NSNumber numberWithInt:pageNum],
                @"pageSize":[NSNumber numberWithInt:pageSize]};
    }
    //
    [CLNetwork POST:str parameter:dic success:^(id responseObject) {
        
        if (!bRefresh)
            [gAppDelegate  removeActivityView];
        
        [weakSelf updateTabViewState:bRefresh];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            //[weakSelf updateData:@[] bRefresh:bRefresh];
            [weakSelf updateData:responseObject[@"data"]  bRefresh:bRefresh];
        }
        else
        {
            [gAppDelegate showAlter:responseObject[@"msg"] bSucc:NO];
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
    
    //[self addDummydata:bRefresh];
   // return;
    
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
    
    [tabView reloadData];
    
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

#pragma mark ---click
//下拉
- (void)clickdropdown
{
    bDrop_down = !NO;
   [self updateShowData:YES];
}

- (void)clickfollowing
{
    bDrop_down = !YES;
    [self updateShowData:NO];
}

- (void)clickleftNext
{
    [self.calendarView moveScrolAnima:YES];
}

- (void)clickRightNext
{
    [self.calendarView moveScrolAnima:NO];
}

- (void)updateShowData:(BOOL)bShow
{//bshow 展开 显示
    if (bShow) {
        viewOnthepull.hidden = NO;
        
        viewdropdown.hidden = YES;
        
        CGRect rect = viewBackgrAllData.frame;
        rect.size.height = HEIGHT - GetRectNavAndStatusHight ;//86 / IPHONE6SHEIGHT * HEIGHT + kScreenWidth*6/7+kCalendarHeaderViewHeight;
        viewBackgrAllData.frame = rect;
        
        rect = viewBackgr.frame;
        rect.size.height = kScreenWidth*6/7+kCalendarHeaderViewHeight;
        viewBackgr.frame = rect;
        [self.calendarView swipedownMove];
    }
    else
    {
        
        if ( [curData timeIntervalSince1970] > [[NSDate date] timeIntervalSince1970]) {
            //回到今天
            [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Can't choose future days"] bSucc:NO];
            [self.calendarView refreshToCurrentDate:YES];
        }
        
        [self.calendarView swipeUpMove];
        viewOnthepull.hidden = !NO;
        //所有的
        viewdropdown.hidden = !YES;
        CGRect rect = viewBackgrAllData.frame;
        rect.size.height = (163 - PhoneHeight) / IPHONE6SHEIGHT * HEIGHT;
        viewBackgrAllData.frame = rect;
        
        rect = viewBackgr.frame;
        rect.size.height = 81 / IPHONE6SHEIGHT * HEIGHT;
        viewBackgr.frame = rect;
    }
}


- (void)clickDate:(UIButton *)button
{
    buttonOrder.selected = !buttonOrder.selected;
    bUpdateRequ = YES;
    if (button.selected) {
        //单个
        [self.calendarView refreshToCurrentDate:YES];
    }
    else
    {//所有的
        [self.calendarView refreshToCurrentDate:!YES];
    }
    
}

- (void)swipeUp
{
    [self updateShowData:!YES];
    //     viewBackgr.frame = CGRectMake(0, GetRectNavAndStatusHight, WIDTH, 70 / IPHONE6SHEIGHT * HEIGHT);
    //    viewdropdown.hidden = NO;
}

- (void)swipedown
{
    [self updateShowData:YES];
    //    viewBackgr.frame = CGRectMake(0, GetRectNavAndStatusHight, WIDTH, HEIGHT - GetRectNavAndStatusHight);
    //    viewdropdown.hidden = YES;
}

- (void)calendarDidSelectedWithDate:(NSDate *)date {
    
        curData = date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    labNovember.text = [dateFormatter stringFromDate:date];
    
//    if (!bDrop_down && [curData timeIntervalSince1970] > [[NSDate date] timeIntervalSince1970]) {
//        //回到今天
//        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Can't choose future days"] bSucc:NO];
//        [self.calendarView refreshToCurrentDate:YES];
//    }
//    else
//    {
//        startTime = labNovember.text;
//    }
//    if(bUpdateRequ)
//    {
//        bUpdateRequ = NO;
//        [tabView headerBeginRefreshing];
//    }

    if (!bDrop_down && [curData timeIntervalSince1970] > [[NSDate date] timeIntervalSince1970]) {
        //回到今天
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Can't choose future days"] bSucc:NO];
        [self.calendarView refreshToCurrentDate:YES];
        bUpdateRequ = NO;
        return;
    }
    else
    {
        
        if (bUpdateRequ || ![startTime isEqualToString:labNovember.text]) {
            bUpdateRequ = NO;
            startTime = labNovember.text;
            [tabView headerBeginRefreshing];
        }
        else
            startTime = labNovember.text;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = CurLanguageCon(@"Rental records");
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
