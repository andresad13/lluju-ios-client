//
//  WTshuju.m
//  ShiXunJX
//
//  Created by NidhoogJX on 2019/12/30.
//  Copyright © 2019 NidhoogJX. All rights reserved.
//

#import "WTshuju.h"

@implementation WTshuju
- (instancetype)initDict:(NSDictionary *)dict
{
    if(self=[super init])
    {
        self.answer=dict[@"answer"];
        self.titlee=dict[@"title"];
        self.icon=dict[@"icon"];
        self.options=dict[@"options"];
    }
    return self;
}
+(instancetype)WtDict:(NSDictionary *)dict{
    return [[self alloc]initDict:dict];
}

@end
