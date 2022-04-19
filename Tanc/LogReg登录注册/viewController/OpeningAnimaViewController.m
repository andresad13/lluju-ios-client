//
//  OpeningAnimaViewController.m
//  ChargingTreasure
//
//  Created by f on 2019/12/19.
//  Copyright © 2019 Mr.fang. All rights reserved.
//

#import "OpeningAnimaViewController.h"
#import "UIImage+GIF.h"

@interface OpeningAnimaViewController ()

@end

@implementation OpeningAnimaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self endAnimation];
    
    //[self initUI];
   self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
//
//     [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(endAnimation) userInfo:nil repeats:NO];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    CGRect rect = CGRectMake(0, 0, 200, 200);
    UIImageView *imageIcn = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageIcn];//OpenAnimation
    imageIcn.center = CGPointMake(WIDTH / 2.0, HEIGHT / 2.0);
    imageIcn.image = [UIImage sd_animatedGIFNamed:@"OpenAnimation"];
}

- (void)endAnimation
{
    [gAppDelegate startinitView];
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
