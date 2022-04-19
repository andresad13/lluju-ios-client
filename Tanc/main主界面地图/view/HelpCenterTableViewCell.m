//
//  HelpCenterTableViewCell.m
//  Tanc
//
//  Created by f on 2019/12/10.
//  Copyright © 2019 f. All rights reserved.
//

#import "HelpCenterTableViewCell.h"

@implementation HelpCenterTableViewCell


-(UILabel *)labCon
{
    if (!_labCon) {
        CGRect rect = MY_RECT(38, 2, 314, 0);
        _labCon = [[UILabel alloc]initWithFrame:rect];
        [self addSubview:_labCon];
        _labCon.numberOfLines = 0;
        _labCon.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:12];
        _labCon.textColor = [UIColor colorWithRed:95/255.0 green:95/255.0 blue:95/255.0 alpha:1.0];
        _labCon.textAlignment = NSTextAlignmentLeft;
    }
    return _labCon;
}

-(UIView *)viewLine
{
    if (!_viewLine) {
        CGRect rect = MY_RECT(0, 0, IPHONE6SWIDTH, 0.7);
        _viewLine = [[UIView alloc]initWithFrame:rect];
        [self addSubview:_viewLine];
        _viewLine.backgroundColor = [UIColor colorWithRed:229 /255.0 green:229 /255.0 blue:229 /255.0 alpha:1];
          
    }
    return _viewLine;
}


- (void)setLabConText:(NSString *)str  floHei:(CGFloat)floHei
{
    self.labCon.text = str;
   CGRect rect = self.labCon.frame;
    CGFloat floLabHei = [GlobalObject getStringHeightWithText:str font:self.labCon.font viewWidth:CGRectGetWidth(self.labCon.frame)];
    rect.size.height = floLabHei;
    self.labCon.frame = rect;
  
  rect = self.viewLine.frame;
    rect.origin.y = floHei - rect.size.height;
    _viewLine.frame = rect;
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
