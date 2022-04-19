//
//  HelpCenterViewController.m
//  Tanc
//
//  Created by f on 2019/12/10.
//  Copyright © 2019 f. All rights reserved.
//

#import "HelpCenterViewController.h"
#import "HelpCenterTableViewCell.h"
#import "HelpCenterHeadView.h"
#import "CustomerServiceView.h"

@interface HelpCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tabView;
    NSMutableArray *mutArray;
    
    UIButton *buttonCus;//客服
}
@end

@implementation HelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    mutArray = [NSMutableArray array];
    
    [self initTableView];
   
    [self request];
    
    [super setBtnGOHiddenNO];
    // Do any additional setup after loading the view.
}
 
- (void)initTableView
{
    CGRect rect = MY_RECT(0, 79 - PhoneHeight, IPHONE6SWIDTH, 0);
    rect.origin.y = rect.origin.y + GetRectNavAndStatusHight;
    rect.size.height = HEIGHT - rect.origin.y;
    tabView = [[UITableView alloc]initWithFrame:rect];
    [self.view addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabView.backgroundColor = [UIColor clearColor];
     
}
 
#pragma mark ---tabView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {CGFloat sectionHeaderHeight = 80;if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);} else if (scrollView.contentOffset.y>=sectionHeaderHeight) {scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    
}
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *commonProbHeader = @"commonProbHeaderID";
    HelpCenterHeadView *view = [tabView dequeueReusableHeaderFooterViewWithIdentifier:commonProbHeader];
    if (!view) {
        view = [[HelpCenterHeadView alloc]initWithReuseIdentifier:commonProbHeader];
    }
    
    NSDictionary *dic = mutArray[section];
    
    view.labTit.text = dic[@"title"];
    BOOL bShow = [dic[@"bShow"] boolValue];
    //[view updateUI:bShow floHei:headerHei problem:dic[@"title"]];
    view.section = section;
    view.imageNext.selected = bShow;
    [view.button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    view.viewLine.hidden = bShow;
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *commonProbStr = @"commonProbCellID";
    HelpCenterTableViewCell *cell = [tabView dequeueReusableCellWithIdentifier:commonProbStr];
    if (!cell) {
        cell = [[HelpCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commonProbStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *dic = mutArray[indexPath.section];
    BOOL bShow = [dic[@"bShow"] boolValue];
    CGFloat headerHei = [dic[@"cellHei"] floatValue];
    [cell setLabConText:dic[@"content"] floHei:headerHei];
    cell.viewLine.hidden = !bShow;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return mutArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = mutArray[section];
    BOOL bShow = [dic[@"bShow"] boolValue];
    if (bShow) {
        return 1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = mutArray[indexPath.section];
    BOOL bShow = [dic[@"bShow"] boolValue];
    if (bShow) {
        return [dic[@"cellHei"] floatValue];
    }
    return 0;
    // CGFloat floCellHei = [dic[@"cellHei"] floatValue];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = mutArray[section];
    
    return [dic[@"headerHei"] floatValue];
}


- (void)request
{
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,@"/UserApp/More/HelpList"];
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setValue:@"1" forKey:@"page"];
    [mutDic setValue:@"10" forKey:@"pageSize"];
     [mutDic setValue:@"APP" forKey:@"type"];
//    [mutDic setValue:@"" forKey:@""];

    [CLNetwork POST:str parameter:mutDic success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            [ weakSelf updateData:responseObject[@"data"]];
        }
        else
        {
            // [ weakSelf updateData:@[]];
            [gAppDelegate showAlter:responseObject[@"msg"] bSucc:NO];
            
        }
    } failure:^(NSError *error) {
        
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
        [gAppDelegate  removeActivityView];
    }];
}

- (void)updateData:(NSArray *)array
{
    if (0 == array.count) {
        
        return;
    }
    //array.count
    for (int i = 0; i < array.count; i ++) {
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
        NSDictionary *dic = array[i];
        for (NSString *dicKey in [dic allKeys]) {
            
            [mutDic setValue:dic[dicKey] forKey:dicKey];
        }
        [mutArray addObject:mutDic];
        BOOL bShow = i == 0 ? YES : NO;
        [mutDic setValue:[NSNumber numberWithBool:bShow] forKey:@"bShow"];
        
        CGFloat floHeaderHeight =  [GlobalObject getStringHeightWithText:mutDic[@"title"] font:[GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13] viewWidth:271.0 / IPHONE6SWIDTH * WIDTH];
        floHeaderHeight = floHeaderHeight + 20 * 2 / IPHONE6SHEIGHT * HEIGHT;
        [mutDic setValue:[NSNumber numberWithFloat:floHeaderHeight] forKey:@"headerHei"];
        
        CGFloat floCurHeight = [GlobalObject getStringHeightWithText:mutDic[@"content"] font:[GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:12] viewWidth:314.0 / IPHONE6SWIDTH * WIDTH];
        floCurHeight = floCurHeight + 16 / IPHONE6SHEIGHT * HEIGHT;
        [mutDic setValue:[NSNumber numberWithFloat:floCurHeight] forKey:@"cellHei"];
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self updateTabViewHei];
    }];
    
    
    [tabView reloadData];
}

- (void)updateTabViewHei
{
    CGRect rect = tabView.frame;
    
    CGFloat floCurHeight = 0.0;
    
    for (int i = 0; i < mutArray.count; i ++) {
        NSDictionary *dic = mutArray[i];
        
        floCurHeight = [dic[@"headerHei"] floatValue] + floCurHeight;
        
        BOOL bShow = [dic[@"bShow"] boolValue];
        if (bShow) {
            floCurHeight = [dic[@"cellHei"] floatValue] + floCurHeight;
        }
    }
    
    if (floCurHeight > (200 + 280) / IPHONE6SHEIGHT * HEIGHT) {
        rect.size.height = (200 + 280) / IPHONE6SHEIGHT * HEIGHT;
    }
    else
    {
        rect.size.height = floCurHeight;
    }
    
    tabView.frame = rect;
    
}

- (void)click:(UIButton *)btn
{
    HelpCenterHeadView *commonProbTabHeadFootView  = (HelpCenterHeadView *)btn.superview;
    
    for (int i = 0; i < mutArray.count; i ++) {
        NSMutableDictionary *mutDic = mutArray[i];
        BOOL bShow =  [mutDic[@"bShow"] boolValue];
        if (i == commonProbTabHeadFootView.section) {
            [mutDic setValue:[NSNumber numberWithBool:!bShow] forKey:@"bShow"];
        }
        else
        {
            [mutDic setValue:[NSNumber numberWithBool:NO] forKey:@"bShow"];
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self updateTabViewHei];
    }];
    [tabView reloadData];
    //  NSMutableDictionary *mutDic = mutArray[commonProbTabHeadFootView.section];
    
}

- (void)clickCus
{
    CustomerServiceView *customerServiceView = [[CustomerServiceView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    [gAppDelegate addTopView:customerServiceView];
   
}


-(void)viewWillAppear:(BOOL)animated
{
    self.title = CurLanguageCon(@"Help center");
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
