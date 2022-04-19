//
//  TransactionDetailsView.h
//  Tanc
//
//  Created by f on 2019/12/11.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TranRecordsTimercheackView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol TransactionDetailsViewDelegate <NSObject>

@optional

- (void)openTimeCheck:(int)curSeleType;

- (void)didTableTran:(int)curSeleType Bill_id:(NSString *)bill_id;
@end

@interface TransactionDetailsView : UIView<UITableViewDelegate,UITableViewDataSource,TranRecordsTimercheackDelegate>
{
    UITableView *tabView;
    NSMutableArray *mutArray;
    int pageNumber;
    
    NSString *curTime;
}



 
@property (nonatomic,assign)id<TransactionDetailsViewDelegate>delegate;

@property (nonatomic,assign)int curSeleType;

@end

NS_ASSUME_NONNULL_END
