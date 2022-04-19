//
//  ShufflingFigureView.m
//  PolitickingAdvertising
//
//  Created by f on 2019/11/27.
//  Copyright © 2019 f. All rights reserved.
//

#import "ShufflingFigureView.h"

// 定时器常量(间隔：秒)，也可以放在外面设置
static const double kTimerInterval = 2.0;

@implementation ShufflingFigureView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI:frame];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI:CGRectMake(0, 0, 0, 0 )];
    }
    return self;
}

/*初始化UI*/
- (void)initUI:(CGRect)frame
{
    mutImageView = [NSMutableArray array];
    
    CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    scrollView = [[UIScrollView alloc]initWithFrame:rect];
    [self addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;//分页效果
    // 水平滚动条隐藏
    scrollView.showsHorizontalScrollIndicator = NO;
    // 设置到边的弹性隐藏
    scrollView.bounces = NO;
    
    rect = CGRectMake(0,CGRectGetHeight(frame) - 45 , CGRectGetWidth(frame), 30);
    pageControl = [[UIPageControl alloc]initWithFrame:rect];
    [self addSubview:pageControl];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    // 设置被选中时小圆点颜色 #FF FCD839
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0xFC / 255.0 green:0xD8 / 255.0 blue:0x39 / 255.0 alpha:1];
    pageControl.currentPage = 0;
}

- (void)setScrollviewFrame:(CGRect)frame
{
    scrollView.frame = frame;
    CGRect rect = CGRectMake(0,CGRectGetHeight(frame) - 45 , CGRectGetWidth(frame), 30);
    pageControl.frame = rect;
}

#pragma mark ---setting 重新设置属性
/*重新设置PageControl 颜色*/
- (void)setPageControl:(UIColor *)pageIndicatorTintColor seleColor:(UIColor *)seleColor
{
    pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
    pageControl.currentPageIndicatorTintColor = seleColor;
}

- (void)setShufflingFigure:(NSArray *)array
{
    /*如果数据是空的 那么清空数据 */
    if (!array || array.count == 0) {
        [timer invalidate];
        timer = nil;
        
        for (int i = 0; i < mutImageView.count; i ++) {
            UIView *view = mutImageView[i];
            [view removeFromSuperview];
        }
        [mutImageView removeAllObjects];
        
        return;
    }
    /*创建或者重新设置 imageview rect和图片*/
    for (int i = 0; i < array.count + 2; i ++) {
        CGRect rect = CGRectMake(scrollView.frame.size.width * i, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        UIImageView *imageView;
        /*如果 图片数组数量 大于 当前图片就不需要再次创建 imageview*/
        if (mutImageView.count > i)
        {
            imageView = mutImageView[i];
            imageView.frame = rect;
            imageView.hidden = NO;
        }
        else
        {
            imageView = [[UIImageView alloc]initWithFrame:rect];
            [scrollView addSubview:imageView];
        }
        NSString *strImage = @"";
        
        if (i == 0) {
            strImage = array.lastObject;
//            if(_bDefImage)
//            {
//                imageView.image = [UIImage imageNamed:array.lastObject];
//            }
//            else
//                [imageView sd_setImageWithURL:[NSURL URLWithString:array.lastObject]];
        }
        else if(i == array.count + 2 - 1)
        {
             strImage = array.firstObject;
//            if(_bDefImage)
//            {
//                imageView.image = [UIImage imageNamed:array.firstObject];
//            }
//            else
//                [imageView sd_setImageWithURL:[NSURL URLWithString:array.firstObject]];
        }
        else
        {
             strImage = array[i - 1];
//            if(_bDefImage)
//            {
//                imageView.image = [UIImage imageNamed:array[i - 1]];
//            }
//            else
//                [imageView sd_setImageWithURL:[NSURL URLWithString:array[i - 1]]];
        }
                    if(_bDefImage)
                    {
                        imageView.image = [UIImage imageNamed:strImage];
                    }
                    else
                    {
                        [imageView sd_setImageWithURL:[NSURL URLWithString:strImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            if (error) {
                                imageView.image = [UIImage imageNamed:@"def_banner1"];
                            }
                        }];
                    }
                       // [imageView sd_setImageWithURL:[NSURL URLWithString:array[i - 1]]];
    }
    
    /*隐藏 多出来的imageView*/
    for (int i = (int)array.count; i < mutImageView.count; i ++) {
        UIImageView *imageView = mutImageView[i];
        imageView.hidden = YES;
    }
    
    pageCount = array.count;
    /*重新设置 分页数量*/
    pageControl.numberOfPages = array.count;
    pageControl.currentPage = 0;
    
    scrollView.contentSize = CGSizeMake( CGRectGetWidth(scrollView.frame)*  (array.count + 2), CGRectGetHeight(scrollView.frame));
    
    scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
    /*设置定时器*/
    timer = [NSTimer scheduledTimerWithTimeInterval:kTimerInterval target:self selector:@selector(changePageRight) userInfo:nil repeats:YES];
}

/*定时器*/
- (void)changePageRight
{
    // 设置当前需要偏移的量，每次递增一个page宽度
    CGFloat offsetX = scrollView.contentOffset.x + CGRectGetWidth(scrollView.frame);
    
    // 根据情况进行偏移
    CGFloat edgeOffsetX = scrollView.frame.size.width * (pageCount + 1);  // 最后一个多余页面右边缘偏移量
    
    // 从多余页往右边滑，赶紧先设置为第一页的位置
    if (offsetX > edgeOffsetX)
    {
        // 偏移量，不带动画，欺骗视觉
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
        // 这里提前改变下一个要滑动到的位置为第二页
        offsetX = scrollView.frame.size.width * 2;
    }
    
    // 带动画滑动到下一页面
    [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    if (offsetX < edgeOffsetX)
    {
        pageControl.currentPage = offsetX / scrollView.frame.size.width - 1;
    }
    else if (offsetX == edgeOffsetX)
    {
        // 最后的多余那一页滑过去之后设置小点为第一个
        pageControl.currentPage = 0;
    }
}

- (void)removeTimer
{
    [timer invalidate];
    timer = nil;
}

- (void)setPageContrRect:(CGRect)rect
{
    pageControl.frame = rect;
}


#pragma mark ---scrollview delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    printf("start drag\n");
    // 记录偏移量
    preOffsetX = scrollView.contentOffset.x;
    // 开始手动滑动时暂停定时器
    [timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    printf("end drag\n");
    // 左右边界
    CGFloat leftEdgeOffsetX = 0;
    CGFloat rightEdgeOffsetX = scrollView.frame.size.width * (pageCount + 1);
    
    if (scrollView.contentOffset.x < preOffsetX)
    {
        // 左滑
        if (scrollView.contentOffset.x > leftEdgeOffsetX)
        {
            pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width - 1;
        }
        else if (scrollView.contentOffset.x == leftEdgeOffsetX)
        {
            pageControl.currentPage = pageCount - 1;
        }
        
        if (scrollView.contentOffset.x == leftEdgeOffsetX)
        {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width * pageCount, 0);
        }
    }
    else
    {
        // 右滑 设置小点
        if (scrollView.contentOffset.x < rightEdgeOffsetX)
        {
            pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width - 1;
        }
        else if (scrollView.contentOffset.x == rightEdgeOffsetX)
        {
            pageControl.currentPage = 0;
        }
        
        // 滑动完了之后从最后多余页赶紧切换到第一页
        if (scrollView.contentOffset.x == rightEdgeOffsetX)
        {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
        }
        
    }
    // 结束后又开启定时器
    [timer setFireDate:[NSDate dateWithTimeInterval:kTimerInterval sinceDate:[NSDate date]]];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //    printf("end scroll\n");
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
