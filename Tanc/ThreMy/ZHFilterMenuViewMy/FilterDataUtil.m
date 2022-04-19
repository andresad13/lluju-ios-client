//
//  FilterDataUtil.m
//  ZHFilterMenuView
//
//  Created by 周亚楠 on 2019/12/19.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "FilterDataUtil.h"
#import "ZHFilterModel.h"

@interface FilterDataUtil ()
@property (nonatomic, strong) NSArray *dictArr;
@end

@implementation FilterDataUtil

- (NSMutableArray *)getTabDataByType:(FilterType)type
{
    NSMutableArray *dataArr = [NSMutableArray array];
    if (type == FilterTypeIsNewHouse) {
        NSMutableArray *areaArr = [NSMutableArray array];
        NSMutableArray *priceArr = [NSMutableArray array];
        NSMutableArray *roomTypeArr = [NSMutableArray array];
        NSMutableArray *moreArr = [NSMutableArray array];
        NSMutableArray *sortArr = [NSMutableArray array];
        ZHFilterModel *areaModel = [ZHFilterModel createFilterModelWithHeadTitle:@"城区" modelArr:[self getDataByType:FilterDataType_GG_QY] selectFirst:YES multiple:NO];
        areaModel.selected = YES;
        [areaArr addObject:areaModel];
        [areaArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"附近" modelArr:[self getDataByType:FilterDataType_GG_FJ] selectFirst:YES multiple:NO]];
        
        [priceArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"总价(万/套)" modelArr:[self getDataByType:FilterDataType_GG_ZJ] selectFirst:NO multiple:YES]];
        [priceArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"单价(万/㎡)" modelArr:[self getDataByType:FilterDataType_XF_DJ] selectFirst:NO multiple:YES]];
        
        [roomTypeArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"户型区间" modelArr:[self getDataByType:FilterDataType_GG_HX] selectFirst:NO multiple:YES]];
        
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"面积(㎡)" modelArr:[self getDataByType:FilterDataType_XF_MJ] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"类型" modelArr:[self getDataByType:FilterDataType_GG_LX] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"售卖状态" modelArr:[self getDataByType:FilterDataType_GG_ZT] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"开盘时间" modelArr:[self getDataByType:FilterDataType_XF_SJ] selectFirst:NO multiple:YES]];
        
        [sortArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"" modelArr:[self getDataByType:FilterDataType_XF_PX] selectFirst:YES multiple:NO]];
        
        [dataArr addObject:areaArr];
        [dataArr addObject:priceArr];
        [dataArr addObject:roomTypeArr];
        [dataArr addObject:moreArr];
        [dataArr addObject:sortArr];
        
    } else if (type == FilterTypeSecondHandHouse) {
        NSMutableArray *areaArr = [NSMutableArray array];
        NSMutableArray *priceArr = [NSMutableArray array];
        NSMutableArray *roomTypeArr = [NSMutableArray array];
        NSMutableArray *moreArr = [NSMutableArray array];
        NSMutableArray *sortArr = [NSMutableArray array];
        
        ZHFilterModel *areaModel = [ZHFilterModel createFilterModelWithHeadTitle:@"城区" modelArr:[self getDataByType:FilterDataType_GG_QY] selectFirst:YES multiple:NO];
        areaModel.selected = YES;
        [areaArr addObject:areaModel];
        [areaArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"附近" modelArr:[self getDataByType:FilterDataType_GG_FJ] selectFirst:YES multiple:NO]];
        
        [priceArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"价格区间(万)" modelArr:[self getDataByType:FilterDataType_GG_ZJ] selectFirst:NO multiple:YES]];
        
        [roomTypeArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"房型选择" modelArr:[self getDataByType:FilterDataType_GG_HX] selectFirst:NO multiple:YES]];
        
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"面积(㎡)" modelArr:[self getDataByType:FilterDataType_ESF_MJ] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"朝向" modelArr:[self getDataByType:FilterDataType_GG_CX] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"楼层" modelArr:[self getDataByType:FilterDataType_GG_LC] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"楼龄" modelArr:[self getDataByType:FilterDataType_ESF_LL] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"装修" modelArr:[self getDataByType:FilterDataType_GG_ZX] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"电梯" modelArr:[self getDataByType:FilterDataType_GG_DT] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"用途" modelArr:[self getDataByType:FilterDataType_GG_YT] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"权属" modelArr:[self getDataByType:FilterDataType_GG_QS] selectFirst:NO multiple:YES]];
        
        [sortArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"" modelArr:[self getDataByType:FilterDataType_ESF_PX] selectFirst:YES multiple:NO]];
        
        [dataArr addObject:areaArr];
        [dataArr addObject:priceArr];
        [dataArr addObject:roomTypeArr];
        [dataArr addObject:moreArr];
        [dataArr addObject:sortArr];
        
    } else if (type == FilterTypeISRent) {
        NSMutableArray *areaArr = [NSMutableArray array];
        NSMutableArray *roomTypeArr = [NSMutableArray array];
        NSMutableArray *priceArr = [NSMutableArray array];
        NSMutableArray *moreArr = [NSMutableArray array];
        NSMutableArray *sortArr = [NSMutableArray array];
        
        ZHFilterModel *areaModel = [ZHFilterModel createFilterModelWithHeadTitle:@"城区" modelArr:[self getDataByType:FilterDataType_GG_QY] selectFirst:YES multiple:NO];
        areaModel.selected = YES;
        [areaArr addObject:areaModel];
        [areaArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"附近" modelArr:[self getDataByType:FilterDataType_GG_FJ] selectFirst:YES multiple:NO]];
        
        [roomTypeArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"整租" modelArr:[self getDataByType:FilterDataType_ZF_ZZ] selectFirst:NO multiple:YES]];
        [roomTypeArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"合租" modelArr:[self getDataByType:FilterDataType_ZF_HZ] selectFirst:NO multiple:YES]];
        
        [priceArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"租金" modelArr:[self getDataByType:FilterDataType_ZF_ZJ] selectFirst:NO multiple:NO]];
        
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"朝向" modelArr:[self getDataByType:FilterDataType_GG_CX] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"租期" modelArr:[self getDataByType:FilterDataType_ZF_ZQ] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"电梯" modelArr:[self getDataByType:FilterDataType_GG_DT] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"楼层" modelArr:[self getDataByType:FilterDataType_GG_LC] selectFirst:NO multiple:YES]];
        [moreArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"装修" modelArr:[self getDataByType:FilterDataType_GG_ZX] selectFirst:NO multiple:YES]];
        
        [sortArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"" modelArr:[self getDataByType:FilterDataType_ZF_PX] selectFirst:YES multiple:NO]];
        
        [dataArr addObject:areaArr];
        [dataArr addObject:roomTypeArr];
        [dataArr addObject:priceArr];
        [dataArr addObject:moreArr];
        [dataArr addObject:sortArr];
    } else if (type == FilterTypeISQuery) {
        NSMutableArray *typeArr = [NSMutableArray array];
        NSMutableArray *statusArr = [NSMutableArray array];
        NSMutableArray *sortArr = [NSMutableArray array];
        
        NSArray *itemArr = [self getDataByType:FilterDataType_CX_LX];
        for (int i = 0; i < itemArr.count; i ++) {
            ZHFilterItemModel *model = itemArr[i];
            if ([model.name containsString:@"不限"]) {
                ZHFilterModel *typeModel = [ZHFilterModel createFilterModelWithHeadTitle:model.name code:model.code modelArr:@[] selectFirst:YES multiple:NO];
                typeModel.selected = YES;
                [typeArr addObject:typeModel];
            } else if ([model.name containsString:@"住房租赁"]) {
                [typeArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:model.name code:model.code modelArr:[self getDataByType:FilterDataType_ZL_LX] selectFirst:YES multiple:NO]];
            } else {
                [typeArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:model.name code:model.code modelArr:@[] selectFirst:NO multiple:NO]];
            }
        }
        
        NSArray *staIitemArr = [self getDataByType:FilterDataType_ZT_LX];
        for (int i = 0; i < staIitemArr.count; i ++) {
            ZHFilterItemModel *model = staIitemArr[i];
            if ([model.name containsString:@"不限"]) {
                ZHFilterModel *typeModel = [ZHFilterModel createFilterModelWithHeadTitle:model.name code:model.code modelArr:@[] selectFirst:YES multiple:NO];
                typeModel.selected = YES;
                [statusArr addObject:typeModel];
            } else if ([model.name containsString:@"合同状态"]) {
                [statusArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:model.name code:model.code modelArr:[self getDataByType:FilterDataType_ZT_HT] selectFirst:YES multiple:NO]];
            } else if ([model.name containsString:@"协议状态"]) {
                [statusArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:model.name code:model.code modelArr:[self getDataByType:FilterDataType_ZT_XY] selectFirst:YES multiple:NO]];
            } else if ([model.name containsString:@"备案状态"]) {
                [statusArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:model.name code:model.code modelArr:[self getDataByType:FilterDataType_ZT_BA] selectFirst:YES multiple:NO]];
            } else if ([model.name containsString:@"异动状态"]) {
                [statusArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:model.name code:model.code modelArr:[self getDataByType:FilterDataType_ZT_YD] selectFirst:YES multiple:NO]];
            }
        }
        
        [sortArr addObject:[ZHFilterModel createFilterModelWithHeadTitle:@"" modelArr:[self getDataByType:FilterDataType_CX_PX] selectFirst:YES multiple:NO]];
        
        [dataArr addObject:typeArr];
        [dataArr addObject:statusArr];
        [dataArr addObject:sortArr];
    }
    
    return dataArr;
}


- (NSArray *)getDataByType:(FilterDataType)type
{
    NSMutableArray *infoArr = [NSMutableArray array];
    NSString *key = [NSString string];
    if (type == FilterDataType_GG_QY) {
        key = @"001";
    }else if (type == FilterDataType_GG_FJ){
        key = @"002";
    }else if (type == FilterDataType_GG_ZJ){
        key = @"003";
    }else if (type == FilterDataType_XF_DJ){
        key = @"004";
    }else if (type == FilterDataType_GG_HX){
        key = @"005";
    }else if (type == FilterDataType_XF_MJ){
        key = @"006";
    }else if (type == FilterDataType_GG_LX){
        key = @"007";
    }else if (type == FilterDataType_GG_ZT){
        key = @"008";
    }else if (type == FilterDataType_XF_SJ){
        key = @"009";
    }else if (type == FilterDataType_XF_PX){
        key = @"010";
    }else if (type == FilterDataType_ESF_MJ){
        key = @"011";
    }else if (type == FilterDataType_GG_LC){
        key = @"012";
    }else if (type == FilterDataType_ESF_LL){
        key = @"013";
    }else if (type == FilterDataType_GG_ZX){
        key = @"014";
    }else if (type == FilterDataType_GG_DT){
        key = @"015";
    }else if (type == FilterDataType_GG_YT){
        key = @"016";
    }else if (type == FilterDataType_GG_QS){
        key = @"017";
    }else if (type == FilterDataType_ESF_PX){
        key = @"018";
    }else if (type == FilterDataType_ZF_ZJ){
        key = @"019";
    }else if (type == FilterDataType_ZF_ZZ){
        key = @"020";
    }else if (type == FilterDataType_ZF_HZ){
        key = @"021";
    }else if (type == FilterDataType_ZF_ZQ){
        key = @"022";
    }else if (type == FilterDataType_ZF_PX){
        key = @"023";
    }else if (type == FilterDataType_GG_CX){
        key = @"024";
    }else if (type == FilterDataType_CX_LX){
        key = @"025";
    }else if (type == FilterDataType_ZL_LX){
        key = @"026";
    }else if (type == FilterDataType_CX_PX){
        key = @"027";
    }else if (type == FilterDataType_ZT_LX){
        key = @"028";
    }else if (type == FilterDataType_ZT_HT){
        key = @"028002";
    }else if (type == FilterDataType_ZT_XY){
        key = @"028003";
    }else if (type == FilterDataType_ZT_BA){
        key = @"028004";
    }else if (type == FilterDataType_ZT_YD){
        key = @"028005";
    }
    for (ZHFilterItemModel *model in self.dictArr) {
        if ([model.parentCode isEqualToString:key]) {
            [infoArr addObject:model];
        }
    }
    return infoArr;
}


- (NSArray *)dictArr
{
    if (!_dictArr) {
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"FilterData" ofType:@"geojson"];
        NSString *dataJson = [[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
//        _dictArr = [ZHFilterItemModel mj_objectArrayWithKeyValuesArray:dataJson];
    }
    return _dictArr;
}


@end
