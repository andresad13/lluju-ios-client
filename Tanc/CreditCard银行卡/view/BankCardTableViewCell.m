//
//  BankCardTableViewCell.m
//  ChargeBuddy
//
//  Created by f on 2020/4/18.
//  Copyright © 2020 f. All rights reserved.
//

#import "BankCardTableViewCell.h"

@implementation BankCardTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.labNumber.hidden = NO;
        self.buttonCheck.hidden = NO;
         self.imageIcon.hidden = NO;
        CGRect rect = MY_RECT(18, 41, 273, 0.7);
        UIView *viewLIne= [[UIView alloc]initWithFrame:rect];
        [self addSubview:viewLIne];
        viewLIne.backgroundColor = [UIColor colorWithRed:0xe8 / 255.0 green:0xe8 / 255.0 blue:0xe8 / 255.0 alpha:1];
    }
    return self;
}

- (UIImageView *)imageIcon
{
    if (!_imageIcon) {
        CGRect rect = MY_RECT(27, (44.5 - 16) /2.0, 0, 16);
        _imageIcon = [[UIImageView alloc]initWithFrame:rect];
        [self addSubview:_imageIcon];
        
    }
    return _imageIcon;
}

-(UILabel *)labNumber
{
    if (!_labNumber) {
        CGRect rect = MY_RECT(78.5, 0, 200, 44.5);
        _labNumber = [[UILabel alloc]initWithFrame:rect];
        [self addSubview:_labNumber];
        _labNumber.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0];
        _labNumber.textAlignment = NSTextAlignmentLeft;
        _labNumber.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
        
    }
    return _labNumber;
}
 

-(UIButton *)buttonCheck
{
    if (!_buttonCheck) {
        CGRect rect = MY_RECT(298, (44.5 - 18) /2.0, 200, 18);
        rect.size.width = rect.size.height;
        _buttonCheck = [[UIButton alloc]initWithFrame:rect];
        [self addSubview:_buttonCheck];
        [_buttonCheck setImage:[UIImage imageNamed:@"bankcheck"] forState:UIControlStateNormal];
        [_buttonCheck setImage:[UIImage imageNamed:@"bankcheck_sele"] forState:UIControlStateSelected];
        _buttonCheck.enabled = NO;
    }
    return _buttonCheck;
}

- (void)setImageIconType:(NSInteger)intType
{
    NSString *str = @"bank_visa";
    if (intType == 0) {
        str = @"BalancePayment";
    }
    else if(intType == 1)
    {
       str = @"bank_master";
    }
    
    UIImage *image = [UIImage imageNamed:str];
    
    CGRect rect = self.imageIcon.frame;
    rect.size.width = rect.size.height / image.size.height * image.size.width;
    self.imageIcon.frame = rect;
    self.imageIcon.image = image;
    
}

//BalancePayment 余额支付 bank_visa 

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
