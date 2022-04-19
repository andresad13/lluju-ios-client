//
//  TransacTableViewCell.m
//  Tanc
//
//  Created by f on 2019/12/11.
//  Copyright © 2019 f. All rights reserved.
//

#import "TransacTableViewCell.h"

@implementation TransacTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labMon.hidden = NO;
        self.labTime.hidden = NO;
        self.labType.hidden = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(UILabel *)labType
{
    if (!_labType) {
        
        CGRect rect = MY_RECT(60, 17, 200, 15);
        _labType = [[UILabel alloc]initWithFrame:rect];
        [self addSubview:_labType];
        _labType.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _labType.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14];
        _labType.textAlignment = NSTextAlignmentLeft;
       _labType.text = @"充钱";
    }
    return _labType;
}

-(UILabel *)labTime
{
    if (!_labTime) {
        
        CGRect rect = MY_RECT(60, 42, 150, 13);
        _labTime = [[UILabel alloc]initWithFrame:rect];
        [self addSubview:_labTime];
        _labTime.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
        _labTime.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
        _labTime.textAlignment = NSTextAlignmentLeft;
       _labTime.text = @"20352";
    }
    return _labTime;
}

-(UILabel *)labMon
{
    if (!_labMon) {
        CGRect rect = MY_RECT(305 - 100, 28, 57 + 100, 13);
        _labMon = [[UILabel alloc]initWithFrame:rect];
        [self addSubview:_labMon];
        _labMon.textColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
        _labMon.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
        _labMon.textAlignment = NSTextAlignmentRight;
        _labMon.text = @"+3432";
    }
    return _labMon;
}

-(UIImageView *)imageIcon
{
    if (!_imageIcon) {
        CGRect rect = MY_RECT(19, 23, 22, 22);
        rect.size.width = rect.size.height;
        _imageIcon = [[UIImageView alloc]initWithFrame:rect];
        [self addSubview:_imageIcon];
    }
    return _imageIcon;
}

- (void)setCurType:(int)intType
{
    self.imageIcon.image = intType == 0 ?  [UIImage imageNamed:@"transaConsumption"] : [UIImage imageNamed:@"transaConsumptionSec"]  ;
 
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
