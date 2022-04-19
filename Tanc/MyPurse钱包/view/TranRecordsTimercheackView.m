//
//  TranRecordsTimercheackView.m
//  ChargingTreasure
//
//  Created by f on 2019/9/18.
//  Copyright © 2019 Mr.fang. All rights reserved.
//

#import "TranRecordsTimercheackView.h"


@implementation TranRecordsTimercheackView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.47];
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    CGRect rect = MY_RECT(0, 349, IPHONE6SWIDTH, 330);
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBackgr];
    viewBackgr.backgroundColor = [UIColor whiteColor];
    [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:6];
    
    rect = MY_RECT(0, 37, IPHONE6SWIDTH, 13);
    UILabel *labPro = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labPro];
    labPro.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
    labPro.textAlignment = NSTextAlignmentCenter;
    labPro.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    labPro.text = [GlobalObject getCurLanguage:@"Please select a time"];
    
    //TranRecordsDelete@3x
    rect = MY_RECT(343, 18, 15, 16);
    rect.size.width = rect.size.height;
    UIButton *buttonDelete = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonDelete];
    [buttonDelete setImage:[UIImage imageNamed:@"TranRecordsDelete"] forState:UIControlStateNormal];
    
    rect = MY_RECT(0, 0, 40, 40);
    UIButton *buttonBigDelete = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonBigDelete];
    [buttonBigDelete addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
    buttonBigDelete.center = buttonDelete.center;
    
    rect = MY_RECT(103, 252, 169, 37);
    UIButton *buttonOK = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonOK];
    buttonOK.backgroundColor =[UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:1.0];
    [buttonOK qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    [buttonOK setTitle:[GlobalObject getCurLanguage:@"determine"] forState:UIControlStateNormal];
    [buttonOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonOK.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    [buttonOK addTarget:self action:@selector(clickOK) forControlEvents:UIControlEventTouchUpInside];
    
    rect = MY_RECT(120, 100, IPHONE6SWIDTH - 120 * 2, 120);
    cusDayDatePicker = [[CustomDayDatePicker alloc]initWithFrame:rect];
    [viewBackgr addSubview:cusDayDatePicker];
    
    rect = MY_RECT(16, 76, 345, 1);
    UIView *viewLIne = [[UIView alloc]initWithFrame:rect];
    [viewBackgr addSubview:viewLIne];
    viewLIne.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    
}

- (void)clickOK
{
    if (_delegate && [_delegate respondsToSelector:@selector(setCurSeleTime:mon:)]) {
        [_delegate setCurSeleTime:cusDayDatePicker.year mon:cusDayDatePicker.month];
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickDelete
{
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
