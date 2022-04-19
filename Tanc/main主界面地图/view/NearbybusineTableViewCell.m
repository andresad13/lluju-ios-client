//
//  NearbybusineTableViewCell.m
//  Tanc
//
//  Created by f on 2019/12/12.
//  Copyright © 2019 f. All rights reserved.
//

#import "NearbybusineTableViewCell.h"

@implementation NearbybusineTableViewCell

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
    CGRect rect = MY_RECT(39, 0, 322, 121);
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBackgr];
    viewBackgr.backgroundColor = [UIColor whiteColor];
    viewBackgr.shadowOpacity(0.7).shadowColor([UIColor colorWithWhite:0 alpha:0.1]).shadowRadius(7).shadowOffset(CGSizeMake(0, 7)).conrnerRadius(8).conrnerCorner(UIRectCornerAllCorners).showVisual();
     
    rect = MY_RECT(13, 21, 79, 79);
    rect.size.width = rect.size.height;
    _imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:_imageIcon];
    //_imageIcon.backgroundColor = [UIColor redColor];
    
    rect = MY_RECT(10, 15, 190, 17);
    rect.origin.x = rect.origin.x + CGRectGetWidth(_imageIcon.frame) + _imageIcon.frame.origin.x;
    _labName = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labName];
    _labName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    _labName.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
    _labName.textAlignment = NSTextAlignmentLeft;
    
    rect = MY_RECT(310, 15, 60, 12);
    _labDistance = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labDistance];
    _labDistance.textColor = [UIColor colorWithRed:97/255.0 green:97/255.0 blue:97/255.0 alpha:1.0];
    _labDistance.text = @"343m";
    _labDistance.textAlignment = NSTextAlignmentLeft;
    _labDistance.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13.4];
    
    rect = MY_RECT(10, 41, 10, 13);
    rect.origin.x = rect.origin.x + CGRectGetWidth(_imageIcon.frame) + _imageIcon.frame.origin.x;
    rect.size.width = rect.size.height / 13.0 * 11;
    UIImageView *imageDis = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:imageDis];
    imageDis.image = [UIImage imageNamed:@"Positioning"];
    
    rect = MY_RECT(4, 41, 224, 12);
     rect.origin.x = rect.origin.x + CGRectGetWidth(imageDis.frame) + imageDis.frame.origin.x;
    _labAddress = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labAddress];
    _labAddress.textColor = [UIColor colorWithRed:97/255.0 green:97/255.0 blue:97/255.0 alpha:1.0];
    _labAddress.text = @"343m";
    _labAddress.textAlignment = NSTextAlignmentLeft;
    _labAddress.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:12];
    
    rect = MY_RECT(10, 63, 10, 12);
      rect.origin.x = rect.origin.x + CGRectGetWidth(_imageIcon.frame) + _imageIcon.frame.origin.x;
    rect.size.width = rect.size.height / 39.0 * 32;
    UIImageView *imageTime = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:imageTime];
    imageTime.image = [UIImage imageNamed:@"Business hours"];
    
    rect = MY_RECT(4, 63, 224, 12);
    rect.origin.x = rect.origin.x + CGRectGetWidth(imageTime.frame) + imageTime.frame.origin.x;
    _labTimer = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labTimer];
    _labTimer.textColor = [UIColor colorWithRed:97/255.0 green:97/255.0 blue:97/255.0 alpha:1.0];
    _labTimer.text = @"343m";
    _labTimer.textAlignment = NSTextAlignmentLeft;
    _labTimer.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:12];
    
    rect = MY_RECT(10, 84, 245, 0.5);
      rect.origin.x = rect.origin.x + CGRectGetWidth(_imageIcon.frame) + _imageIcon.frame.origin.x;
    UIView *viewLine = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewLine];
    viewLine.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:229 / 255.0 blue:229 / 255.0 alpha:1];
    
    rect = MY_RECT(10, 95, 85, 11);
    rect.origin.x = rect.origin.x + CGRectGetWidth(_imageIcon.frame) + _imageIcon.frame.origin.x;
    _labAvailable = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labAvailable];
    _labAvailable.textColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0];
    _labAvailable.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:12];
    _labAvailable.textAlignment = NSTextAlignmentLeft;
    
    rect = MY_RECT(105 - 9, 95, 85 + 9 + 4, 11);
      rect.origin.x = rect.origin.x + CGRectGetWidth(_imageIcon.frame) + _imageIcon.frame.origin.x;
    _labCanreturn = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labCanreturn];
    _labCanreturn.textColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0];
    _labCanreturn.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:12];
    _labCanreturn.textAlignment = NSTextAlignmentLeft;
    
    rect = MY_RECT(207 - 6, 95, 60, 11);
      rect.origin.x = rect.origin.x + CGRectGetWidth(_imageIcon.frame) + _imageIcon.frame.origin.x;
    UILabel *lab = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:lab];
    lab.textColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0];
    lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:12];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = CurLanguageCon(@"Go here");
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
