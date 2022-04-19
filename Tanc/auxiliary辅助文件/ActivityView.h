//
//  ActivityView.h
//  Cloris
//
//  Created by Mr.fang on 2018/3/21.
//  Copyright © 2018年 Mr.fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityView : UIView
{
    UIImageView *imageView;
}

@property (nonatomic,strong) UILabel *labTitle;
//- (void)stopAnimation;
- (void)createLabtitle:(NSString *)str;

@end
