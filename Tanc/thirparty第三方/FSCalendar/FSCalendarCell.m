//
//  FSCalendarCell.m
//  Test
//
//  Created by 樊盛 on 2019/4/29.
//  Copyright © 2019年 樊盛. All rights reserved.
//

#import "FSCalendarCell.h"
#import "FSCalendarDayModel.h"
#import "CalendarMacroHeader.h"

@implementation FSCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = Color_collectionView_Bg;
        [self drawView];
    }
    return self;
}

- (void)drawView {
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat rate = 0.13;
    CGFloat gap = selfWidth*rate;
    CGFloat width = selfWidth*(1-2*rate);
    self.currentSelectView = [[UILabel alloc] initWithFrame:CGRectMake(gap, gap/5, width, width)];
    self.currentSelectView.layer.cornerRadius = width/2;
    self.currentSelectView.layer.masksToBounds = YES;
    [self addSubview:self.currentSelectView];
    
    self.solarDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    self.solarDateLabel.textAlignment = NSTextAlignmentCenter;
    self.solarDateLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14.8];
    [self.currentSelectView addSubview:self.solarDateLabel];
  
}

- (void)setDayModel:(FSCalendarDayModel *)dayModel {
    
    self.solarDateLabel.text = dayModel.solarDateString;
    self.solarDateLabel.textColor = Color_Text_CurrentMonth_UnSelected;
    self.lunarDateLabel.text = dayModel.lunarDateString;
    self.lunarDateLabel.textColor = Color_Text_CurrentMonth_UnSelected;
    self.currentSelectView.backgroundColor = [UIColor clearColor];
    self.currentSelectView.layer.borderWidth = 0;
}




@end
