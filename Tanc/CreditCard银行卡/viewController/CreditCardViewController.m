//
//  CreditCardViewController.m
//  Tanc
//
//  Created by f on 2019/12/25.
//  Copyright © 2019 f. All rights reserved.
//

#import "CreditCardViewController.h"
#import "CreditCardTableViewCell.h"
#import "AddCreditCardViewController.h"
#import "CreditCardDefViewController.h"

@interface CreditCardViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tabView;
    NSMutableArray *mutArray;
    int pageNumber;
    NSInteger removeBankRow;
}

@property (nonatomic,strong)UIView *viewBackgrSear;
@end

@implementation CreditCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    [self initTopRight];
    
    [self initData];
    
    [self initUI];
    
    [super setBtnGOHiddenNO];
    
    // Do any additional setup after loading the view.
}

- (void)initData
{
    mutArray = [NSMutableArray array];
    
    pageNumber = 1;
}

- (void)initTopRight
{
    UIButton *buttonRigh = [[UIButton alloc]init];
    [buttonRigh setImage:[UIImage imageNamed:@"addCreditCard"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:buttonRigh];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    [buttonRigh addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
     
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
        lab.text = CurLanguageCon(@"No credit cards yet ~");
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0];
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
        
    }
    return _viewBackgrSear;
}

- (void)initUI
{
    CGRect rect = MY_RECT(0, 79 - PhoneHeight, IPHONE6SWIDTH, 523 - 46);
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
}

#pragma mark ---tablview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {CGFloat sectionHeaderHeight = 80;if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);} else if (scrollView.contentOffset.y>=sectionHeaderHeight) {scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    
}
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129 / IPHONE6SHEIGHT * HEIGHT;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"cell_id";
    CreditCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell) {
        
        cell = [[CreditCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    NSDictionary *dic = mutArray[indexPath.row];
    
//    NSString *strBank = [NSString stringWithFormat:@"%@0000000000%@",dic[@"cardNumberBin"],dic[@"cardNumberLast4"]];
    //Visa MasterCard
//    return @"visa";
//         //return @"MasterCard";
//     }   if ([masterCardPredicate evaluateWithObject:cardTextField]) {
//        return @"masterCard";
    NSString *strImageBank = dic[@"paymentMethod"][@"name"];
    
    if ([strImageBank isEqualToString:@"Mastercard"]) {
        strImageBank = @"careditbank_mastercard";//[@"bank_" stringByAppendingString:@"masterCard"];
    }//
    else
    {//creditbank_visa
        strImageBank =@"creditbank_visa";  
    }
//    NSString *strBankType = [GlobalObject regexUsePredicateWithText:strBank];
//    strBankType = [@"bank_" stringByAppendingString:strBankType];
    cell.imageIcon.image = [UIImage imageNamed:strImageBank];
    cell.labMon.text = [NSString stringWithFormat:@"%@/%@",dic[@"expirationYear"],dic[@"expirationMonth"]];
    
    cell.labNumber.text = [@"**** **** **** " stringByAppendingString:dic[@"lastFourDigits"]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (mutArray.count == 0) {
        return 0;
    }
   
//    NSArray *array = mutArray[section];
//
//
     return mutArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CreditCardDefViewController *viewController = [CreditCardDefViewController new];
    viewController.dic = mutArray[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath {

    return YES;

}
 
- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {

    return UITableViewCellEditingStyleDelete;

}
 

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {

//在这里实现删除操作

}


- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
 // 添加一个'删除'按钮
 UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Eliminar" handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
 
    NSDictionary *dic = self->mutArray[indexPath.row];
    self->removeBankRow = indexPath.row;
     [self requestdeleteBank:dic[@"id"]];
  // 1. 更新数据
  // 2. 更新UI
//  [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
}];
//   deleteRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    deleteRowAction.backgroundColor = [UIColor clearColor];
 //将设置好的按钮放到数组中返回
 return @[deleteRowAction];
}
  

#pragma mark ---request
-(void)requestdeleteBank:(NSString *)deleteBankID
{
   
    [gAppDelegate createActivityView];
    __weak __typeof(self) weakSelf = self;
    NSString *str = [ChargingApi stringByAppendingString:[NSString stringWithFormat:@"/UserApp/User/DropCard/%@",deleteBankID]];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            
            [weakSelf removeBankSucc];
            
            [gAppDelegate showAlter:responseObject[@"msg"]  bSucc:YES];
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


- (void)requestAct:(int)pageNum pageSize:(int)pageSize  bRefresh:(BOOL)bRefresh
{
    __weak typeof(self) weakSelf = self;
    //longitude=113.88410&latitude=22.55329
 
     NSString *strType =  [NSString stringWithFormat:@"/pay/mercadopago/getCards/%@",[GlobalObject shareObject].userModel.openid];
    NSString *str = [NSString stringWithFormat:@"%@%@",ChargingApi,strType];
    
    [CLNetwork POST:str parameter:@{} success:^(id responseObject) {
        
      //  [gAppDelegate  removeActivityView];
        
        [weakSelf updateTabViewState:bRefresh];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            //[weakSelf updateData:@[] bRefresh:bRefresh];
            [weakSelf updateData:responseObject[@"data"][@"cards"]  bRefresh:bRefresh];
        }
        else
        {
            [gAppDelegate showAlter:responseObject[@"msg"] bSucc:NO];
        }
    } failure:^(NSError *error) {
        
        [weakSelf updateTabViewState:bRefresh];
        [gAppDelegate showAlter:[GlobalObject getCurLanguage:@"Please check if the network is connected"] bSucc:NO];
       //[gAppDelegate  removeActivityView];
    }];
}

- (void)removeBankSucc
{
    if (removeBankRow < mutArray.count) {
        [mutArray removeObjectAtIndex:removeBankRow];
        [tabView reloadData];
    }
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

- (void)clickAdd
{
     
    [self.navigationController pushViewController:[AddCreditCardViewController new] animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    //测试
   [tabView headerBeginRefreshing];
    
    self.title = [GlobalObject getCurLanguage:@"Credit card"];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //设置文字颜色 大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16]}];
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor clearColor] image:nil isOpaque:YES];//颜色
    [self.navigationController.navigationBar navBarAlpha:0 isOpaque:NO];//透明度 如果设置了透明度 所以导航栏会隐藏
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];//隐藏底线
    
    
    [self.navigationController setNavigationBarHidden:NO];
    
    
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
