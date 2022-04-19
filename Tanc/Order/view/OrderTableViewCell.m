//
//  OrderTableViewCell.m
//  Tanc
//
//  Created by f on 2019/12/16.
//  Copyright © 2019 f. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

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
    CGRect rect = MY_RECT(30, 0, 332, 154);
    UIView *viewLine = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewLine];
    viewLine.layer.cornerRadius = 22;
    viewLine.layer.borderWidth = 0.5;
    viewLine.layer.borderColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0].CGColor;
    
    rect = MY_RECT(45, 15, 200, 11);
    UILabel *labOrderNum = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:labOrderNum];
    labOrderNum.text = [GlobalObject getCurLanguage:@"Order number:"];
    labOrderNum.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
    labOrderNum.textColor = [UIColor blackColor];
    labOrderNum.textAlignment = NSTextAlignmentLeft;
    
    rect = MY_RECT(45, 36.5, 200, 11);
    _labOrderNumer = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labOrderNumer];
    _labOrderNumer.text = [GlobalObject getCurLanguage:@"Order number:"];
    _labOrderNumer.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:11];
    _labOrderNumer.textColor = [UIColor blackColor];
    _labOrderNumer.textAlignment = NSTextAlignmentLeft;
    
    rect = MY_RECT(45, 60, 200, 11);
    UILabel *labRe = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:labRe];
    labRe.text = [GlobalObject getCurLanguage:@"Rental time:"];
    labRe.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
    labRe.textColor = [UIColor blackColor];
    labRe.textAlignment = NSTextAlignmentLeft;
    
    rect = MY_RECT(45, 82.5, 200, 11);
    _labTime = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labTime];
    _labTime.text = [GlobalObject getCurLanguage:@"Order number:"];
    _labTime.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:11];
    _labTime.textColor = [UIColor blackColor];
    _labTime.textAlignment = NSTextAlignmentLeft;
    
    rect = MY_RECT(45, 106, 200, 11);
    UILabel *labShenye = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:labShenye];
    labShenye.text = [GlobalObject getCurLanguage:@"Rental business:"];
    labShenye.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
    labShenye.textColor = [UIColor blackColor];
    labShenye.textAlignment = NSTextAlignmentLeft;
    
    
    rect = MY_RECT(45, 128.5, 200, 11);
    _labRental = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labRental];
    _labRental.text = [GlobalObject getCurLanguage:@"Order number:"];
    _labRental.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:11];
    _labRental.textColor = [UIColor blackColor];
    _labRental.textAlignment = NSTextAlignmentLeft;
    
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
