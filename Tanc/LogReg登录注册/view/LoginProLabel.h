//
//  LoginProLabel.h
//  Tanc
//
//  Created by f on 2019/12/5.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginProLabel : UIView

@property (nonatomic,strong)UILabel *labFir;//
@property (nonatomic,strong)UILabel *labSec;//

- (void)setLabText:(NSString *)str strSec:(NSString *)strSec font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
