//
//  TailoringImageViewController.h
//  ChargingTreasure
//
//  Created by f on 2019/7/2.
//  Copyright © 2019 Mr.fang. All rights reserved.
//

 

NS_ASSUME_NONNULL_BEGIN
@protocol TailoringImageDelegate <NSObject>

- (void)setTailoringImage:(UIImage *)image;

- (void)removeTailoringView;

@end
@interface TailoringImageView : AllSupViewController
{
    UIImageView *viewRoundedFir;//左上 依次顺序到左下
    UIImageView *viewRoundedSec;//左上 依次顺序到左下
    UIImageView *viewRoundedThe;//左上 依次顺序到左下
    UIImageView *viewRoundedFour;//左上 依次顺序到左下
    
    UIView *viewTop;//上方
    UIView *viewRight;//右边
    UIView *viewFollowing;//下面
    UIView *viewLeft;//左边
    
    UIView *viewBackgr;//背景颜色
    
    UIImageView *imageView;//白净
    
    CGPoint oldPoint;//老得尺寸大小
    
    CGFloat floDifference;
    BOOL bMove;//是否允许 移动
    BOOL bFir;
    UIImage *tailoringImage;
    UIView *moveCurView;
}
@property (nonatomic,assign)id<TailoringImageDelegate>delegate;
@property (nonatomic,assign)BOOL bHeadIcon;//是否是头像

@property (nonatomic,strong)UIImage *headImagenew;
//- (void)setImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
