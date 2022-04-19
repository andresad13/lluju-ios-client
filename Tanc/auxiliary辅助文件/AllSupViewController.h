//
//  AllSupViewController.h
//  Tanc
//
//  Created by f on 2019/12/6.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllSupViewController : UIViewController

@property (nonatomic,strong)UIButton *buttonGo;

/*设置成黑色图片*/
- (void)setGoBackBlackImage;

/*设置成白色图片*/
- (void)setGoBackWhiteImage;

- (void)setBtnGOHiddenNO;

 
@end

NS_ASSUME_NONNULL_END
