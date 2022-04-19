//
//  TransactionDetailsView.m
//  Tanc
//
//  Created by f on 2019/12/11.
//  Copyright © 2019 f. All rights reserved.
//

#import "TransactionDetailsView.h"
#import "TransacHeaderView.h"
#import "TransacTableViewCell.h"


@implementation TransactionDetailsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        mutArray = [NSMutableArray array];
        
        [self initUI];
        
        pageNumber = 1;
        
        NSDate *date = [NSDate date];
        NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
        //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        [forMatter setDateFormat:@"yyyy-MM"];
        NSString *dateStr = [forMatter stringFromDate:date];
        NSLog(@"dateStr =  %@",dateStr);
        
        curTime = dateStr;
        [tabView headerBeginRefreshing];
        // [self requestAct:1 pageSize:5 bRefresh:YES];
    }
    return self;
}

- (void)initUI
{
    CGRect rect = MY_RECT(0, 0, IPHONE6SWIDTH, 46);
    UIImageView *imageBackgr = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:imageBackgr];
    imageBackgr.image = [UIImage imageNamed:@"transationBackgr"];
    
    
    rect = MY_RECT(0, 46, IPHONE6SWIDTH, 523 - 46);
    tabView = [[UITableView alloc]initWithFrame:rect];
    [self addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tabView addFooterWithTarget:self action:@selector(footerRereshing)];
    tabView.footerPullToRefreshText = CurLanguageCon(@"Load more data");
    tabView.footerReleaseToRefreshText = CurLanguageCon(@"Load more data");
    tabView.footerRefreshingText = CurLanguageCon(@"Loading data, please wait…");
    tabView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    [tabView addHeaderWithTarget:self action:@selector(headterRereshing)];
    
    tabView.headerPullToRefreshText =  CurLanguageCon(@"Load more data");
    tabView.headerReleaseToRefreshText =  CurLanguageCon(@"Load more data");
    tabView.headerRefreshingText = CurLanguageCon(@"Please wait while the data is being redrawn ...");
    tabView.estimatedRowHeight = 0;
    tabView.estimatedSectionFooterHeight = 0;
    tabView.estimatedSectionHeaderHeight = 0;
    
    rect = MY_RECT(329, 25, 19, 19);
    rect.size.width = rect.size.height;
    UIButton *button = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:button];
    [button setImage:[UIImage imageNamed:@"DateFiltering"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickDateFiltering) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark ---tablview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {CGFloat sectionHeaderHeight = 80;if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);} else if (scrollView.contentOffset.y>=sectionHeaderHeight) {scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    
}
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59 / IPHONE6SHEIGHT * HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 21 / IPHONE6SHEIGHT * HEIGHT;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *strHeadID = @"headID";
    TransacHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:strHeadID];
    if (!view) {
        
        view = [[TransacHeaderView alloc]initWithReuseIdentifier:strHeadID];
        
    }
    NSDictionary *dic = mutArray[section];
    NSString *strKey = _curSeleType == 0 ?  @"addTime" : @"add_time";
    NSArray *arra =[dic[strKey] componentsSeparatedByString:@"-"];
    NSString *str = [NSString stringWithFormat:@"%@-%@",arra[0],arra[1]];//[arra[0] stringByAppendingString:arra[1]];
    [view setLabTitiText:str];
    
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"cell_id";
    TransacTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell) {
        
        cell = [[TransacTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *dic = mutArray[indexPath.row];
    
    if (_curSeleType == 0) {
        cell.labMon.text = [NSString stringWithFormat:@"$ %0.2f",[dic[@"chongzhi"] floatValue]];
        cell.labType.text =  dic[@"status"];
        
    }
    else
    {
        NSInteger intStatus = [dic[@"sourceType"] intValue];
        cell.labType.text = [self getMonState:intStatus];
        NSString *account_yajin = [GlobalObject judgeStringNil:dic[@"account_yajin"]];
        if ([account_yajin intValue]  >= 0) {
            account_yajin = [GlobalObject judgeStringNil:dic[@"account_my"]];
        }
        BOOL bStr = [GlobalObject isStringNil:dic[@"account_yajin"]];
        account_yajin  = [GlobalObject judgeStringNil:dic[@"account_yajin"]];
        if (bStr && [account_yajin intValue] < 0) {
            account_yajin = [GlobalObject judgeStringNil:dic[@"account_yajin"]];
        }
        else
        {
            account_yajin = [GlobalObject judgeStringNil:dic[@"account_my"]];
        }
        
        cell.labMon.text = [NSString stringWithFormat:@"$ %0.2f",[account_yajin floatValue]];
    }
    
    NSString *strKey = _curSeleType == 0 ?  @"addTime" : @"add_time";
    cell.labTime.text =  dic[strKey];
    [cell setCurType:_curSeleType];
    return cell;
}

- (NSString *)getMonState:(NSInteger)intType
{
    NSString *str = @"consumption";
    switch (intType) {
        case 0 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Order consumption"];
        }
            break;
        case 1 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Merchant change"];
        }
            break;
        case 2 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Withdrawal balance"];
        }
            break;
        case 3 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Withdrawal balance"];
        }
            break;
        case 4 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Recharge balance"];
        }
            break;
        case 5 + 1:
        {
            str = [GlobalObject getCurLanguage:@"Recharge deposit"];
        }
            break;
        case 7:
        {
            str = [GlobalObject getCurLanguage:@"Deduction balance before withdrawal"];
        }
            break;
        case 8:
        {
            str = [GlobalObject getCurLanguage:@"Lost purchase, deduction of deposit"];
        }
            break;
        case  9:
        {
            str = [GlobalObject getCurLanguage:@"Overtime orders, minus deposit"];
        }
            break;
            
        default:
            break;
    }
    return str;
} 


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mutArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic= mutArray[indexPath.row];
    NSString * bill_id = [NSString stringWithFormat:@"%d",[dic[@"id"] intValue]];
    if (_delegate && [_delegate respondsToSelector:@selector(didTableTran:Bill_id:)]) {
        [_delegate didTableTran:_curSeleType Bill_id:bill_id];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!mutArray || mutArray.count == 0) {
        return 0;
    }
    //  return 3;
    return 1;
}



- (void)requestAct:(int)pageNum pageSize:(int)pageSize  bRefresh:(BOOL)bRefresh
{
    
    
    
    
    __weak typeof(self) weakSelf = self;
    [gAppDelegate createActivityView];
    //0。1
    NSString *str = _curSeleType == 0 ?  @"/UserApp/User/ChongzhiList" : @"/UserApp/User/expenses/list/";
    str = [ChargingApi stringByAppendingString:str];
    
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    [mutDic setValue:[NSNumber numberWithInt:pageNum] forKey:@"page"];
    [mutDic setValue:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    
    [mutDic setValue:curTime forKey:@"date"];
    
    [CLNetwork POST:str parameter:mutDic success:^(id responseObject) {
        
        [gAppDelegate  removeActivityView];
        
        [weakSelf updateTabViewState:bRefresh];
        
        if ([[responseObject allKeys] containsObject:@"code"] && [responseObject[@"code"] intValue] == 1) {
            //[weakSelf updateData:@[] bRefresh:bRefresh];
            [weakSelf updateData:responseObject[@"data"] bRefresh:bRefresh];
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
    
    if (array.count == 0 && mutArray.count == 0) {
        //  self.viewBackgrSear.hidden = NO;
        tabView.hidden = YES;
        return;
    }
    else
    {
        // self.viewBackgrSear.hidden = !NO;
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


- (void)clickDateFiltering
{
    [self   createTranRecordsTimercheackView];
    //    if(_delegate && [_delegate respondsToSelector:@selector(openTimeCheck:)])
    //    {
    //        [_delegate openTimeCheck:_curSeleType];
    //    }
}

- (void)createTranRecordsTimercheackView
{
    TranRecordsTimercheackView *view = [[TranRecordsTimercheackView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [gAppDelegate addTopView:view];
    view.delegate = self;
}

- (void)setCurSeleTime:(int )years mon:(int )mon
{
    curTime = [NSString stringWithFormat:@"%d-%02d",years,mon];
    [tabView headerBeginRefreshing];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
