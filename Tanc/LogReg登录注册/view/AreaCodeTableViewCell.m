//
//  AreaCodeTableViewCell.m
//  SpeedTime
//
//  Created by f on 2019/9/10.
//  Copyright © 2019 f. All rights reserved.
//

#import "AreaCodeTableViewCell.h"

@implementation AreaCodeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    CGRect rect = MY_RECT(15, 0, 200, 46);
    _labName = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labName];
    _labName.textAlignment = NSTextAlignmentLeft;
    _labName.textColor = [UIColor blackColor];
    _labName.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
    
    rect = MY_RECT(IPHONE6SWIDTH - 40 - 100, 0, 100, 46);
    _labCode = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labCode];
    _labCode.textAlignment = NSTextAlignmentRight;
    _labCode.textColor = [UIColor colorWithRed:95/255.0 green:95/255.0 blue:95/255.0 alpha:1.0];
    _labCode.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
    
    self.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:0xfa / 255.0 green:0xfa / 255.0 blue:0xfa / 255.0 alpha:1];
    
    rect = MY_RECT(0, 45 - 0.6, IPHONE6SWIDTH, 0.7);
    _viewLine = [[UIView alloc]initWithFrame:rect];
    [self addSubview:_viewLine];
    _viewLine.backgroundColor = [UIColor colorWithRed:0xf1 / 255.0 green:0xf1 / 255.0 blue:0xf1 / 255.0 alpha:1];;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
