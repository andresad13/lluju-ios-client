//
//  TransDetaiViewController.m
//  Tanc
//
//  Created by f on 2019/12/11.
//  Copyright © 2019 f. All rights reserved.
//

#import "TransDetaiViewController.h"
#import "TransactionDetailsView.h"
#import "BillingDetailsViewController.h"


@interface TransDetaiViewController ()<UIScrollViewDelegate,TransactionDetailsViewDelegate>
{
    NSMutableArray *mutArray;
    
}

@property (nonatomic,strong) UIScrollView *scrollview;

@property (nonatomic,strong) TransactionDetailsView *transactionDetailsView;

@property (nonatomic,strong) TransactionDetailsView *consumptionView;

@end

@implementation TransDetaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    mutArray = [NSMutableArray array];
    [self.view addSubview:self.scrollview];
    
    [self initUI];
    
    [super setBtnGOHiddenNO];
    self.title = CurLanguageCon(@"Transaction details");
    // Do any additional setup after loading the view.
}


- (void)initUI
{
    
    NSArray *array = @[@"Recharge",@"Expenses record"];
    for (int i = 0; i < 2; i ++)
    {
        
        CGRect rect = MY_RECT( (IPHONE6SWIDTH / 2.0 - 141) / 2.0 + IPHONE6SWIDTH / 2.0 * i, 79, 141, 39);
        UIButton *button = [[UIButton alloc]initWithFrame:rect];
        [self.view addSubview:button];
        [button setTitle:[GlobalObject getCurLanguage:array[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickRech:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithRed:134/255.0 green:134/255.0 blue:134/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.layer.cornerRadius = rect.size.height / 2.0;
        button.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
        button.layer.borderWidth = 1;
        button.layer.borderColor = i != 0 ? [UIColor colorWithRed:178 / 255.0 green:178 / 255.0 blue:178 / 255.0 alpha:1].CGColor : [UIColor clearColor].CGColor;
        
        button.backgroundColor = i == 0 ? [UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:1.0] : [UIColor clearColor];
        button.selected = i == 0 ? YES : NO;
        [mutArray addObject:button];
    }
}

- (void)createBillingDetailsViewController:(int)curSeleType Bill_id:(NSString *)bill_id
{
    BillingDetailsViewController *viewController = [[BillingDetailsViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.curSeleType = curSeleType;
    viewController.bill_id = bill_id;
}
 
-(UIScrollView *)scrollview
{
    if (!_scrollview) {
        
        CGRect rect = MY_RECT(0, 143, IPHONE6SWIDTH, IPHONE6SHEIGHT - 143);
        _scrollview = [[UIScrollView alloc]initWithFrame:rect];
        
        _scrollview.contentSize = CGSizeMake(WIDTH *2, 0);
        // 开启分页
        _scrollview.pagingEnabled = YES;
        // 关闭回弹
        _scrollview.bounces = NO;
        _scrollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //  _contentScrollView.backgroundColor = [UIColor blackColor];
        // 隐藏水平滚动条
        _scrollview.showsHorizontalScrollIndicator = NO;
        // 设置代理
        _scrollview.delegate = self;
        _scrollview.backgroundColor = [UIColor clearColor];
  
        self.transactionDetailsView.hidden = NO;
        self.consumptionView.hidden = NO;
 
    }
    return _scrollview;
}

-(TransactionDetailsView *)transactionDetailsView
{
    if (!_transactionDetailsView) {
        
        CGRect rect = MY_RECT(0, 0, IPHONE6SWIDTH, 523);
        _transactionDetailsView = [[TransactionDetailsView alloc]initWithFrame:rect];
           [self.scrollview addSubview:self.transactionDetailsView];
     //   _transactionDetailsView.shadowOpacity(0.7).shadowColor((UIColor *)[UIColor colorWithWhite:0 alpha:0.3]).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius( 40).conrnerCorner(UIRectCornerTopLeft | UIRectCornerTopRight).showVisual();
        _transactionDetailsView.curSeleType = 0;
        _transactionDetailsView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        _transactionDetailsView.delegate = self;
    }
    
    return _transactionDetailsView;
}

-(TransactionDetailsView *)consumptionView
{
    if (!_consumptionView) {
        
        CGRect rect = MY_RECT(IPHONE6SWIDTH, 0, IPHONE6SWIDTH, 523);
        _consumptionView = [[TransactionDetailsView alloc]initWithFrame:rect];
         [self.scrollview addSubview:_consumptionView];
        _consumptionView.delegate = self;
        _consumptionView.curSeleType = 1;
        _consumptionView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
     //   _consumptionView.shadowOpacity(0.7).shadowColor((UIColor *)[UIColor colorWithWhite:0 alpha:0.3]).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius( 40).conrnerCorner(UIRectCornerTopLeft | UIRectCornerTopRight).showVisual();
       
    }
    
    return _consumptionView;
}

#pragma mark ---click

-  (void)clickRech:(UIButton *)button
{
    int tag = [self updateBtn:button];
   
    [self.scrollview setContentOffset:CGPointMake(WIDTH * tag, 0) animated:YES];
}
 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  int tag = scrollView.contentOffset.x / WIDTH;
    
    [self updateBtn:mutArray[tag]];
}

- (int)updateBtn:(UIButton *)button
{
    int tag = 0;
    for (int i = 0; i < mutArray.count; i ++) {
        UIButton *btn = mutArray[i];
        if (button == mutArray[i]) {
            //当前选中的
            tag = i;
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            btn.selected = YES;
            btn.backgroundColor = [UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:1.0];
        }
        else
        {
            btn.layer.borderColor = [UIColor colorWithRed:178 / 255.0 green:178 / 255.0 blue:178 / 255.0 alpha:1].CGColor;
            btn.selected = NO;
            btn.backgroundColor = [UIColor clearColor];
            
        }
    }
    return tag;
}

- (void)didTableTran:(int)curSeleType Bill_id:(NSString *)bill_id
{
     [self createBillingDetailsViewController:curSeleType Bill_id:(NSString *)bill_id];
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
