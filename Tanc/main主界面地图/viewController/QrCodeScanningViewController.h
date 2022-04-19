//
//  QrCodeScanningViewController.h
//  ChargingTreasure
//
//  Created by f on 2019/11/9.
//  Copyright © 2019 Mr.fang. All rights reserved.
//

#import "AllSupViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QrCodeScanningViewControllerDelegate <NSObject>

@optional

- (void)openUserView:(NSString *)user_Id;
@end

@interface QrCodeScanningViewController : AllSupViewController

@property (nonatomic,assign)id<QrCodeScanningViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
