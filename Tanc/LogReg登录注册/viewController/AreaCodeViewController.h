//
//  AreaCodeViewController.h
//  SpeedTime
//
//  Created by f on 2019/9/10.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AreaCodeViewDelegate <NSObject>

@optional

- (void)updateAreaCode:(NSString *)strNumb;

@end

@interface AreaCodeViewController : AllSupViewController

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,assign)id<AreaCodeViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
