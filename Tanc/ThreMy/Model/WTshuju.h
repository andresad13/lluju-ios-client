//
//  WTshuju.h
//  ShiXunJX
//
//  Created by NidhoogJX on 2019/12/30.
//  Copyright © 2019 NidhoogJX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WTshuju : NSObject

@property(nonatomic,copy)NSString *answer;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *titlee;
@property(nonatomic,strong)NSArray *options;
-(instancetype)initDict:(NSDictionary *)dict;
+(instancetype)WtDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
