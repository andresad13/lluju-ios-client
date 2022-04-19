//
//  AreaCodeViewController.m
//  SpeedTime
//
//  Created by f on 2019/9/10.
//  Copyright © 2019 f. All rights reserved.
//

#import "AreaCodeViewController.h"
#import "AreaCodeTableViewCell.h"
#import "AreaCodeHeadView.h"

#define  AreaCodeTag 300

@interface AreaCodeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *curAreaCodeArray;
    NSMutableArray *arrayLetter;
    
    UIView *viewRightBackgr;
    
    NSMutableArray *mutArrayLab;
    
    UILabel *labSele;
}


@end

@implementation AreaCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setGoBackBlackImage];
    
    mutArrayLab = [NSMutableArray array];
    curAreaCodeArray = [NSMutableArray array];
    NSArray *array = [self getLocation];
    arrayLetter = [NSMutableArray array];
    
    NSArray *letterArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
        
    for (int A = 0 ; A < letterArray.count; A++) {
        NSMutableArray *mutArray = [NSMutableArray array];
        
        for (int i = 0; i < array.count; i ++) {
            NSArray *arrayC = array[i];
                
            for (int j = 0; j < arrayC.count; j ++) {
                
                NSArray *arrayB = arrayC[j];
                NSString *str =  [arrayB[2] substringToIndex:1];
                if ([str isEqualToString:letterArray[A]]) {
                    [mutArray addObject:arrayB];
                }
            }
           }
        
        if (mutArray.count > 0) {
            [arrayLetter addObject:letterArray[A]];
            [curAreaCodeArray addObject:mutArray];
        }
    }
     
    
    [self initTableView];
 
    [self initViewRightBackgr];
    // Do any additional setup after loading the view.
}

- (void)initViewRightBackgr
{
    CGRect rect = MY_RECT(IPHONE6SWIDTH - 23, 100, 23, 8);
    viewRightBackgr = [[UIView alloc]initWithFrame:rect];
    viewRightBackgr.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewRightBackgr];
    
    CGFloat floY = 8 / IPHONE6SHEIGHT * HEIGHT;
    for (int i = 0; i < arrayLetter.count; i ++) {
        
        rect = MY_RECT(0, 0, 23, 15);
        rect.origin.y = floY;
        UIView *view = [[UIView alloc]initWithFrame:rect];
        [viewRightBackgr addSubview:view];
        view.tag = AreaCodeTag + i;
        
        rect = MY_RECT(0, 0, 0, 15);
        rect.size.width = rect.size.height;
        
        UILabel *lab = [[UILabel alloc]initWithFrame:rect];
        [view addSubview:lab];
        lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:14] ;
        lab.textColor = [UIColor colorWithRed:81/255.0 green:78/255.0 blue:78/255.0 alpha:1.0];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.center = CGPointMake(view.frame.size.width / 2.0, lab.center.y);
        [lab qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
        lab.backgroundColor = [UIColor clearColor];;
        lab.text = arrayLetter[i];
        [mutArrayLab addObject:lab];
        
        lab.tag = AreaCodeTag + 200 + i;
        
        floY = rect.size.height + floY;
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        [view addGestureRecognizer:tapGes];
        
        if (i == arrayLetter.count - 1) {
            labSele = [[UILabel alloc]initWithFrame:rect];
            [view addSubview:labSele];
            labSele.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:14] ;
            labSele.textColor = [UIColor whiteColor];
            labSele.textAlignment = NSTextAlignmentCenter;
            //labSele.center = CGPointMake(view.frame.size.width / 2.0, lab.center.y);
            [labSele qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
            labSele.backgroundColor = [UIColor colorWithRed:0x3C / 255.0 green:0xd5 / 255.0 blue:0x2e / 255.0 alpha:1];;
            labSele.alpha = 0;
        }
    }
    
    rect = viewRightBackgr.frame;
    rect.size.height =  rect.size.height + floY;
    viewRightBackgr.frame = rect;
    viewRightBackgr.center = CGPointMake(viewRightBackgr.center.x, HEIGHT / 2.0);
    
    viewRightBackgr.shadowOpacity(0.7).shadowColor(AllColorShadow).shadowRadius(7).shadowOffset(CGSizeMake(0, 7)).conrnerRadius(rect.size.width).conrnerCorner(UIRectCornerAllCorners).showVisual();
}

- (void)initTableView
{
    CGRect rect = MY_RECT(0, 0, IPHONE6SWIDTH - 5, 0);
    rect.origin.y = GetRectNavAndStatusHight;
    rect.size.height = HEIGHT - rect.origin.y;
    _tableView = [[UITableView alloc]initWithFrame:rect];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
}

- (NSArray *)getLocation
{
     NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AreaCodeList" ofType:@"plist"]];
    
  NSArray *array =  dataDict[@"areaCode"];
    
  
    return array;
}

#pragma mark ---Tap Ges

- (void)tapView:(UITapGestureRecognizer *)tapGes
{
    UIView *view = tapGes.view;
    NSInteger tag = view.tag - AreaCodeTag;
    
  // [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:tag];
  
    for (int i = 0; i < mutArrayLab.count; i ++) {
       UILabel * lab = mutArrayLab[i];
        if (tag == i) {
            labSele.alpha = 1;
            [lab.superview addSubview:labSele];
            
            labSele.text = lab.text;
            labSele.center = lab.center;
            
        }
    }
    [UIView animateWithDuration:1.3 animations:^{
       self->labSele.alpha = 0;
    } completion:^(BOOL finished) {
    }];
   
    
    if (tag != 0 && tag != mutArrayLab.count - 1) {
        tag = tag + 1;
    }
     NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:tag ];
    
    // 让table滚动到对应的indexPath位置
    [_tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
   
}


#pragma mark ---tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"cell_id";
    
    AreaCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell) {
        cell = [[AreaCodeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
    }
   NSArray *array = curAreaCodeArray[indexPath.section];
    NSArray *arraySub = array[indexPath.row];
    cell.labName.text = arraySub[2];
    cell.labCode.text = arraySub[1];
    if (indexPath.row < array.count - 1) {
        cell.viewLine.hidden = NO;
    }
    else
    {
        cell.viewLine.hidden = YES;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = curAreaCodeArray[section];
    return array.count;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {CGFloat sectionHeaderHeight = 80;if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);} else if (scrollView.contentOffset.y>=sectionHeaderHeight) {scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    
}
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *strHeadID = @"HeadID";
    AreaCodeHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:strHeadID];
    if (!headView) {
        headView = [[AreaCodeHeadView alloc]initWithReuseIdentifier:strHeadID];

    }
   headView.labTitle.text = arrayLetter[section];

    return headView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return curAreaCodeArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46 / IPHONE6SHEIGHT * HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 26 / IPHONE6SHEIGHT * HEIGHT;
}

//
 -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}

//-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return arrayLetter;
//}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
 
   return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}


-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    for (UIView *view in [tableView subviews]) {
        if ([view isKindOfClass:[NSClassFromString(@"UITableViewIndex") class]]) {
            // 设置字体大小
            [view setValue:[GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:14] forKey:@"_font"];
            //设置view的大小
             view.bounds = CGRectMake(10, 0, 25, 20);
            view.backgroundColor = [UIColor clearColor];
            //单单设置其中一个是无效的
        }
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = curAreaCodeArray[indexPath.section];
    NSArray *arraySub = array[indexPath.row];
  
  //  cell.labCode.text = arraySub[1];
    if (_delegate && [_delegate respondsToSelector:@selector(updateAreaCode:)]) {
        [_delegate updateAreaCode:arraySub[1]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = [GlobalObject getCurLanguage:@"Area code"];
    [self.navigationController setNavigationBarHidden:YES];
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
