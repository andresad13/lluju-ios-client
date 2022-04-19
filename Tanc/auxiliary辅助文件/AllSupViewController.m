//
//  AllSupViewController.m
//  Tanc
//
//  Created by f on 2019/12/6.
//  Copyright © 2019 f. All rights reserved.
//

#import "AllSupViewController.h"
#import "MainViewController.h"

@interface AllSupViewController ()
{
    CGPoint oldPoint;
}
@end

@implementation AllSupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"go_Back_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [UINavigationBar appearance].backIndicatorImage = backButtonImage;
    
    [UINavigationBar appearance].backIndicatorTransitionMaskImage =backButtonImage;
    
    [self initUIGoMain];
    // Do any additional setup after loading the view.
}

- (void)initUIGoMain
{
    CGRect rect = MY_RECT(321, 590, 54, 50);
    rect.size.width = rect.size.height ;
    rect.origin.x = WIDTH - rect.size.width;
    _buttonGo = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:_buttonGo];
    [_buttonGo setBackgroundImage:[UIImage imageNamed:@"goMainIcon"] forState:UIControlStateNormal];
    [_buttonGo addTarget:self action:@selector(clickGO) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveSiri:)];
    [_buttonGo addGestureRecognizer:panGes];
    
    
    _buttonGo.hidden =  YES;
}

- (void)clickGO
{
    
        UINavigationController *navVC = self.navigationController;
        NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
        
        for (UIViewController *vc in [navVC viewControllers]) {
            
            [viewControllers addObject:vc];
            
            if ([vc isKindOfClass:[MainViewController class]]) {
                
                break;
            }
        }
    //    [viewControllers addObject:[NearbybusinViewController new]];
        [navVC setViewControllers:viewControllers animated:YES];
    
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:GoMainNotification object:Nil];
    
}


/*设置成白色图片*/
- (void)setGoBackWhiteImage
{
    //    UIImage *backButtonImage = [[UIImage imageNamed:@"go_Back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //
    //    [UINavigationBar appearance].backIndicatorImage = backButtonImage;
    //
    //    [UINavigationBar appearance].backIndicatorTransitionMaskImage =backButtonImage;
}

- (void)setGoBackBlackImage
{
    //    UIImage *backButtonImage = [[UIImage imageNamed:@"go_Back_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //
    //    [UINavigationBar appearance].backIndicatorImage = backButtonImage;
    //
    //    [UINavigationBar appearance].backIndicatorTransitionMaskImage =backButtonImage;
}


- (void)moveSiri:(UIPanGestureRecognizer *)panGes
{
    CGPoint point = [panGes locationInView:panGes.view.superview];
    if (panGes.state == UIGestureRecognizerStateBegan)
    {
        // _buttonGo.alpha = 1;
        oldPoint = [panGes locationInView:self.view];
    }
    else if(panGes.state == UIGestureRecognizerStateEnded)
    {
        // _buttonGo.alpha = 0.5;
        CGPoint siriCent =  panGes.view.center;
        CGFloat floTop = siriCent.y /*/ (HEIGHT / 2.0)*/;
        CGFloat floDown = (HEIGHT - siriCent.y) /*/ (HEIGHT / 2.0)*/;
        CGFloat floRig = siriCent.x /*/ (WIDTH / 2.0)*/;
        CGFloat floLeft = (WIDTH - siriCent.x)/*/ (WIDTH / 2.0)*/;
        
        
        NSMutableArray * dataArr = [NSMutableArray array];
        [dataArr addObject:@{@"sirFlo":[NSNumber numberWithFloat:floTop],@"direction":[NSNumber numberWithInt:0]}];
        [dataArr addObject:@{@"sirFlo":[NSNumber numberWithFloat:floDown],@"direction":[NSNumber numberWithInt:1]}];
        [dataArr addObject:@{@"sirFlo":[NSNumber numberWithFloat:floRig],@"direction":[NSNumber numberWithInt:2]}];
        [dataArr addObject:@{@"sirFlo":[NSNumber numberWithFloat:floLeft],@"direction":[NSNumber numberWithInt:3]}];
        
        for (int i = 0; i < dataArr.count; ++i) {
            //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
            for (int j = 0; j < dataArr.count-1; ++j) {
                NSDictionary *dicF = dataArr[j];
                NSDictionary *dicS = dataArr[j + 1];
                
                if ([dicF[@"sirFlo"] floatValue]> [dicS[@"sirFlo"] floatValue]) {
                    [dataArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
        CGRect siriRect = panGes.view.frame;
        NSDictionary *newDic = dataArr.firstObject;
        if ([newDic[@"direction"] intValue] == 0) {
            siriRect.origin.y = GetRectNavAndStatusHight;
        }
        else  if ([newDic[@"direction"] intValue] == 1) {
            siriRect.origin.y = HEIGHT - siriRect.size.height;
        }
        else  if ([newDic[@"direction"] intValue] == 3) {
            siriRect.origin.x = WIDTH - siriRect.size.width;
        }
        else  if ([newDic[@"direction"] intValue] == 2) {
            siriRect.origin.x =  0;
        }
        [UIView animateWithDuration:0.3 animations:^{
            panGes.view.frame = siriRect;
        }];
    }
    
    oldPoint.x =  point.x - oldPoint.x;
    oldPoint.y =  point.y - oldPoint.y;
    // CGRect rect = panGes.view.frame;
    CGPoint centerPoint = panGes.view.center ;
    centerPoint.x += oldPoint.x;
    centerPoint.y += oldPoint.y;
    
    if(centerPoint.x <= 0 || centerPoint.x >= WIDTH)
    {
        centerPoint.x = panGes.view.center.x;
    }
    if (centerPoint.y <= GetRectNavAndStatusHight || centerPoint.y >= HEIGHT) {
        centerPoint.y = panGes.view.center.y;
    }
    
    
    panGes.view.center = centerPoint;
    
    oldPoint = point;
    //rect = panGes.view.frame;
}


- (void)setBtnGOHiddenNO
{
    self.buttonGo.hidden = NO;
    ///  [self.buttonGo bringSubviewToFront:self.view];
    
    [self.view bringSubviewToFront:self.buttonGo];
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
