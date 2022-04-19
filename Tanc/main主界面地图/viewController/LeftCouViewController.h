//
//  LeftCouViewController.h
//  Tanc
//
//  Created by f on 2019/12/6.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeftCouViewController : UIViewController


@property (nonatomic,strong)UINavigationController *naviga;

- (void)updateScroll;

- (void)updateUserData;

@end

NS_ASSUME_NONNULL_END
