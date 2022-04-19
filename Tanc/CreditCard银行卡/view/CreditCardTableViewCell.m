//
//  CreditCardTableViewCell.m
//  Tanc
//
//  Created by f on 2019/12/25.
//  Copyright © 2019 f. All rights reserved.
//银行卡cell

#import "CreditCardTableViewCell.h"

@implementation CreditCardTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    CGRect rect = MY_RECT(14.5, 0, 345.5, 116.5);
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBackgr];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:147/255.0 green:193/255.0 blue:95/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    
    [viewBackgr.layer addSublayer:gl];
    [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:5];
    
//    viewBackgr.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
//    viewBackgr.shadowOpacity(0.7).shadowColor([UIColor colorWithRed:253/255.0 green:89/255.0 blue:148/255.0 alpha:0.38]).shadowRadius(7).shadowOffset(CGSizeMake(0, 7)).conrnerRadius(5).conrnerCorner(UIRectCornerAllCorners).showVisual();
    
    rect = MY_RECT(19, 20, 100, 8);
    UILabel *labCar = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labCar];
    labCar.textColor = [UIColor whiteColor];
    labCar.textAlignment = NSTextAlignmentLeft;
    labCar.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10];
    labCar.text = CurLanguageCon(@"Card number");
    
    rect = MY_RECT(19, 36, 180, 13);
    _labNumber = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:_labNumber];
    _labNumber.text = @"**** **** **** 4364";
    _labNumber.textColor = [UIColor whiteColor];
    _labNumber.textAlignment = NSTextAlignmentLeft;
    _labNumber.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    
    rect = MY_RECT(281, 20, 44, 44);
    rect.size.width = rect.size.height;
    _imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgr addSubview:_imageIcon];
    [_imageIcon qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
  
    
    rect = MY_RECT(19, 67, 160, 12);
    UILabel *labExp = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labExp];
    labExp.text = CurLanguageCon(@"Expiration date");
    labExp.textColor = [UIColor whiteColor];
    labExp.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:10];
    
    //
    rect = MY_RECT(19, 82, 160, 15);
    _labMon = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:_labMon];
    _labMon.text = @"11/2021";
    _labMon.textColor = [UIColor whiteColor];
    _labMon.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    
    
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
