//
//  USerProWindow.h
//  ChargingTreasure
//
//  Created by f on 2019/7/5.
//  Copyright © 2019 Mr.fang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface USerProWindow : UIView
{
    NSTimer *timer;
}

@property (nonatomic,strong)NSString *strPro;
@property (nonatomic,assign)BOOL bSucce;

- (void)initUI;
@end

NS_ASSUME_NONNULL_END
