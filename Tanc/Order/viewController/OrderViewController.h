//
//  OrderViewController.h
//  Tanc
//
//  Created by f on 2019/12/16.
//  Copyright © 2019 f. All rights reserved.
//

#import "AllSupViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderViewController : AllSupViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tabView;
       NSMutableArray *mutArray;
       int pageNumber;
}
@end

NS_ASSUME_NONNULL_END
