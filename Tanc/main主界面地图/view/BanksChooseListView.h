//
//  BanksChooseListView.h
//  SpeedTime
//
//  Created by f on 2019/7/16.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BanksChooseListViewDelegate <NSObject>

@optional
- (void)seleBanksChooseListView:(NSInteger)seleType;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BanksChooseListView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *mutArray;
    UITableView *tabView;
    
    NSInteger seleType;
    
    UIView *viewBackgr;
}

@property (nonatomic,assign)id<BanksChooseListViewDelegate>delegate;

@property (nonatomic,strong)NSArray *arraybank;

@property (nonatomic,assign)BOOL bOpen;

- (void)updateBankUI:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
