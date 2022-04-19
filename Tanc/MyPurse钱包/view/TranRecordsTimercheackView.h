//
//  TranRecordsTimercheackView.h
//  ChargingTreasure
//
//  Created by f on 2019/9/18.
//  Copyright © 2019 Mr.fang. All rights reserved.
//时间选择器

#import <UIKit/UIKit.h>
#import "CustomDayDatePicker.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TranRecordsTimercheackDelegate <NSObject>

@optional
- (void)setCurSeleTime:(int )years mon:(int )mon;

@end

@interface TranRecordsTimercheackView : UIView
{
    CustomDayDatePicker *cusDayDatePicker;
}

@property (nonatomic,assign)id<TranRecordsTimercheackDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
