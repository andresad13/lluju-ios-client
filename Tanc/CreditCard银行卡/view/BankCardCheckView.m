//
//  BankCardCheckView.m
//  ChargeBuddy
//
//  Created by f on 2020/4/18.
//  Copyright © 2020 f. All rights reserved.
//

#import "BankCardCheckView.h"
#import "BankCardTableViewCell.h"

@implementation BankCardCheckView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        [self initUI];
        
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    CGRect rect = MY_RECT(9, 0, 349, 106.5 - 44.5 + 53.5);
    viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBackgr];
    viewBackgr.backgroundColor = [UIColor whiteColor];
    
    rect = MY_RECT(0, 30, 349, 18);
    UILabel *labTit = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labTit];
    labTit.textAlignment = NSTextAlignmentCenter;
    labTit.textColor = [UIColor colorWithRed:46/255.0 green:42/255.0 blue:39/255.0 alpha:1.0];
    labTit.text = CurLanguageCon(@"Please select mode of payment");
    labTit.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:16];
    
    rect = MY_RECT(0, 106.5 - 44.5, 349, 0);
    tabView = [[UITableView alloc]initWithFrame:rect];
    [viewBackgr addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    tabView.backgroundColor = [UIColor clearColor];
    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    rect = MY_RECT(0, 0, 349, 53.5);
    buttonOtherCar = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonOtherCar];
    [buttonOtherCar setTitle:[GlobalObject getCurLanguage:@"+ Other cards"] forState:UIControlStateNormal];
    [buttonOtherCar setTitleColor:[UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0] forState:UIControlStateNormal];
    buttonOtherCar.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
    [buttonOtherCar addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)updateBankList:(NSArray *)array strWall:(NSString *)strWall
{
    if (![array isKindOfClass:[NSArray class]]) {
        array = @[];
    }
    
    str_Wall = strWall;
    arrayBank = array;
    NSInteger number = array.count > 4 ? 4 : array.count ;
    
    number ++;
    
    CGFloat floHeiCell = 44.5 / IPHONE6SHEIGHT * HEIGHT;
    CGRect rect = tabView.frame;
    rect.size.height = floHeiCell * number;
    tabView.frame = rect;
    // //60 + 55.5
    rect = viewBackgr.frame;
    rect.size.height = floHeiCell * number + rect.size.height;
    viewBackgr.frame = rect;
    
    rect =  buttonOtherCar.frame;
    rect.origin.y = CGRectGetHeight(viewBackgr.frame) - rect.size.height;
    buttonOtherCar.frame = rect;
    [tabView reloadData];
    viewBackgr.center = CGPointMake(WIDTH / 2.0, HEIGHT / 2.0);
    [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:17];
}

#pragma mark ---tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"cell_id";
    BankCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[BankCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        
        cell.backgroundColor =[UIColor clearColor];
        //cell.selectionStyle = [
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
     
        [cell setImageIconType:0];
        cell.labNumber.text = [NSString stringWithFormat:@"%@（$%d）",[GlobalObject getCurLanguage:@"Purse"],[str_Wall intValue]];
    }
    else
    {
        NSDictionary *dic = arrayBank[indexPath.row - 1];
      NSString *bankName = dic[@"paymentMethod"][@"name"];
        NSInteger bankType = [bankName isEqualToString:@"Mastercard"] ? 1 : 2;
       //issuer
        [cell setImageIconType:bankType];
        cell.labNumber.text = [NSString stringWithFormat:@"**** **** **** %d",[dic[@"lastFourDigits"] intValue]];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arrayBank &&arrayBank.count > 0) {
        return arrayBank.count + 1;
      }
      return 1;
}

 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.5 / IPHONE6SHEIGHT * HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankCardTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.buttonCheck.selected = YES;
    if (indexPath.row == 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(seleBalancePay)]) {
            [_delegate seleBalancePay];
        }
    }
    else
    {
        NSDictionary *dic = arrayBank[indexPath.row - 1];
        if (_delegate && [_delegate respondsToSelector:@selector(seleBankPay:)]) {
            [_delegate seleBankPay:dic[@"id"]];
        }
    }
    
    
   
     [self removeView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != viewBackgr) {
        [self removeView];
    }
}

#pragma mark ---click
- (void)clickAdd
{//添加新的
    if (_delegate && [_delegate respondsToSelector:@selector(addOtherBank)]) {
        [_delegate addOtherBank];
    }
    [self removeView];
}

- (void)removeView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
