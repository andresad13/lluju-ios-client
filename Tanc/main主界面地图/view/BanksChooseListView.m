

//
//  BanksChooseListView.m
//  SpeedTime
//
//  Created by f on 2019/7/16.
//  Copyright © 2019 f. All rights reserved.
//银行选择列表

#import "BanksChooseListView.h"
#import "BanksChooseListTableViewCell.h"
@implementation BanksChooseListView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initData];
        
        [self initUI];
    }
    return self;
}

- (void)initData
{
    mutArray = [NSMutableArray array];
//    [mutArray addObject:@{@"name":@"Visa/Master信用卡",@"imageType":@"visa.png"}];
//    [mutArray addObject:@{@"name":@"街口支付",@"imageType":@"Street_pay"}];
   
    seleType = -1;
    _bOpen = YES;
}

- (void)initUI
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    CGRect rect = MY_RECT(0, 66, 345, 43);
  
    viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBackgr];
    viewBackgr.center = CGPointMake(WIDTH / 2.0, HEIGHT / 2.0);
    viewBackgr.backgroundColor = [UIColor whiteColor];
 
    
    //107 - 43 * 2 = 21 51 + 15 = 66
    rect = MY_RECT(0, 30, 345, 15);
    UILabel *lab = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:lab];
    lab.text = CurLanguageCon(@"Please select a payment method");
    lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentCenter;
 
    rect = MY_RECT(0, 66, 345, 43);
   
    tabView = [[UITableView alloc]initWithFrame:rect];
    [viewBackgr addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)updateBankUI:(NSArray *)array
{
    _arraybank = array;
    
  CGRect rect = viewBackgr.frame;
    rect.size.height = rect.size.height * _arraybank.count + 66 / IPHONE6SHEIGHT * HEIGHT + 20;
    rect.origin.y = (HEIGHT - rect.size.height) / 2.0;
    viewBackgr.frame = rect;
       [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:15];
    
    rect = tabView.frame;
     rect.size.height = rect.size.height * _arraybank.count;
    tabView.frame= rect;
}


//- (void)click
//{
//    if (seleType == -1) {
//        [GlobalObject showAlter:@"請選擇支付類型"  bSucc:NO];
//        return;
//    }
//
//    if (_delegate && [_delegate respondsToSelector:@selector(seleBanksChooseListView:)]) {
//        [_delegate seleBanksChooseListView:seleType];
//    }
//
//    [self removeFromSuperview];
//}


#pragma mark tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strcellId = @"cellid";
    
    BanksChooseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strcellId];
    if (!cell) {
        cell = [[BanksChooseListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strcellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dic = _arraybank[indexPath.row];
    NSString *strBank = [NSString stringWithFormat:@"%@0000000000%@",dic[@"cardNumberBin"],dic[@"cardNumberLast4"]];
    //Visa MasterCard
    NSString *strBankType = [GlobalObject regexUsePredicateWithText:strBank];
    strBankType = [@"bank_" stringByAppendingString:strBankType];
    cell.imageIconMaster.image = [UIImage imageNamed:strBankType];
  
    cell.labNumber.text = [@"**** **** **** " stringByAppendingString:dic[@"cardNumberLast4"]];
    if (seleType == indexPath.row) {
        cell.buttonCheck.selected = YES;
    }
    else
    {
       cell.buttonCheck.selected = NO;
    }
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_arraybank && _arraybank.count > 0) {
         return _arraybank.count;
    }
   
     return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43 / IPHONE6SHEIGHT * HEIGHT;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_bOpen) {
        _bOpen = NO;
           seleType = indexPath.row;
         [tabView reloadData];
          [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.2];
        
       
    }
   
}

- (void)delayMethod
{
   if (_delegate && [_delegate respondsToSelector:@selector(seleBanksChooseListView:)]) {
        [_delegate seleBanksChooseListView:seleType];
    }
    [self removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != viewBackgr) {
        [self removeFromSuperview];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
