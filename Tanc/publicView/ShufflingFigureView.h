//
//  ShufflingFigureView.h
//  PolitickingAdvertising
//
//  Created by f on 2019/11/27.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShufflingFigureView : UIView<UIScrollViewDelegate>
{
    NSMutableArray *mutImageView;//存放需要放置的图片属性
    UIScrollView *scrollView;//轮播图的父类
    UIPageControl *pageControl;//分页控件
    NSTimer *timer;//定时器
    NSInteger pageCount;//总页数
 
    //手动退拽时保存前的偏移量，便于判断方向
    CGFloat preOffsetX;
    
}

@property (nonatomic,assign)BOOL bDefImage;//是否展示默认图片
 
/*重新设置PageControl 颜色*/
- (void)setPageControl:(UIColor *)pageIndicatorTintColor seleColor:(UIColor *)seleColor;
/*设置显示轮播图数组*/
- (void)setShufflingFigure:(NSArray *)array;

- (void)removeTimer;

- (void)setPageContrRect:(CGRect)rect;

- (void)setScrollviewFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
