//
//  BanksChooseListTableViewCell.m
//  SpeedTime
//
//  Created by f on 2019/7/16.
//  Copyright © 2019 f. All rights reserved.
//

#import "BanksChooseListTableViewCell.h"

@implementation BanksChooseListTableViewCell

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
    CGRect rect  = MY_RECT(25, (43 - 17) / 2.0, 29, 17);
  
    rect.size.width = rect.size.height ;/// 17.0 * 29;
    _imageIconMaster =  [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:_imageIconMaster];
    //_imageIconMaster.hidden = YES;
    _imageIconMaster.image = [UIImage imageNamed:@"master"];
  
    //77 - 20 57
    rect = MY_RECT(16, 10, 200, 43 - 20);
       rect.origin.x = _imageIconMaster.frame.origin.x + _imageIconMaster.frame.size.width + rect.origin.x;
    _labNumber = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labNumber];
    _labNumber.textColor = [UIColor blackColor];
    _labNumber.font = [UIFont systemFontOfSize:17];
    _labNumber.textAlignment = NSTextAlignmentLeft;
    
    rect = MY_RECT(15, 0, 315, 1);
    UIView *viewLIne = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewLIne];
    viewLIne.backgroundColor =[UIColor colorWithRed:0xe3 / 255.0 green:0xe3 / 255.0 blue:0xe3 / 255.0 alpha:1];
    
    
    rect = MY_RECT(311 - 10, (43 - 20) / 2.0, 20, 20);
    rect.size.width = rect.size.height;
    _buttonCheck = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:_buttonCheck];
    [_buttonCheck setImage:[UIImage imageNamed:@"noselect"] forState:UIControlStateNormal];
    [_buttonCheck setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    _buttonCheck.userInteractionEnabled = NO;
    
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
