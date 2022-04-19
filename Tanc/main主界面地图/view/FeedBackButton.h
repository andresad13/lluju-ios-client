//
//  FeedBackButton.h
//  Tanc
//
//  Created by f on 2019/12/9.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedBackButton : UIView
{
    UIView *viewBtnBackgr;
}

@property (nonatomic,strong)UIButton *buttonImage;

@property (nonatomic,strong)UILabel *labTitle;

@property (nonatomic,strong)UIButton *button;

/*设置文字*/
- (void)setButtonText:(NSString *)str;
/*设置当前z选中的状态*/
- (void)setCurSele:(BOOL)bSele;

- (void)createViewBtn:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
