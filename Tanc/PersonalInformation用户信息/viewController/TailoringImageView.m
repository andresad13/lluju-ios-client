//
//  TailoringImageViewController.m
//  ChargingTreasure
//
//  Created by f on 2019/7/2.
//  Copyright © 2019 Mr.fang. All rights reserved.
//

#import "TailoringImageView.h"
#define GreenColor  [UIColor colorWithRed:0/255.0 green:188/255.0 blue:155/255.0 alpha:1.0]
@interface TailoringImageView ()

@end

@implementation TailoringImageView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self delayMethod];
    
    // Do any additional setup after loading the view.
}

- (void)delayMethod
{
    [self setImage:_headImagenew];
}

- (void)initUI
{
   // self.imageViewBackgrBlue.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    //先画框
    CGRect rect = MY_RECT(30, 78, IPHONE6SWIDTH - 30 * 2,  591 - 78);
    imageView = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:imageView];
    
    imageView.backgroundColor = [UIColor clearColor];
    
    
    viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:viewBackgr];
    viewBackgr.layer.borderWidth = 2;
    viewBackgr.layer.borderColor = GreenColor.CGColor;
    
    //    viewBackgr.layer
    
    
    rect = MY_RECT(80 - 10, 100 - 10, 30, 30);
    rect.size.width = rect.size.height ;
    viewRoundedFir = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:viewRoundedFir];
    //    viewRoundedFir.backgroundColor = [UIColor redColor];
    //    [viewRoundedFir addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(rect.size.width, rect.size.width)];
    viewRoundedFir.image = [UIImage imageNamed:@"viewRoundedFir.png"];
    viewRoundedFir.userInteractionEnabled = YES;
    
    rect = MY_RECT(280 - 10, 100 - 10, 30, 30);
    rect.size.width = rect.size.height ;
    viewRoundedSec = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:viewRoundedSec];
    //    viewRoundedSec.backgroundColor = [UIColor redColor];
    //    [viewRoundedSec addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(rect.size.width, rect.size.width)];
    viewRoundedSec.image = [UIImage imageNamed:@"viewRoundedSec.png"];
    viewRoundedSec.userInteractionEnabled = YES;
    
    
    rect = MY_RECT(280 - 10, 300 - 10, 30, 30);
    rect.size.width = rect.size.height ;
    viewRoundedThe = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:viewRoundedThe];
    //    viewRoundedThe.backgroundColor = [UIColor redColor];
    //    [viewRoundedThe addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(rect.size.width, rect.size.width)];
    viewRoundedThe.image = [UIImage imageNamed:@"viewRoundedThe.png"];
    viewRoundedThe.userInteractionEnabled = YES;
    
    rect = MY_RECT(80 - 10, 300 - 10, 30, 30);
    rect.size.width = rect.size.height ;
    viewRoundedFour = [[UIImageView alloc]initWithFrame:rect];
    [self.view addSubview:viewRoundedFour];
    //    viewRoundedFour.backgroundColor = [UIColor redColor];
    //    [viewRoundedFour addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(rect.size.width, rect.size.width)];
    viewRoundedFour.image = [UIImage imageNamed:@"viewRoundedFour.png"];
    viewRoundedFour.userInteractionEnabled = YES;
    
//    rect = MY_RECT(0, 20, 100, 58);
//    ButtonGoBack *btnBark = [[ButtonGoBack alloc]initWithFrame:rect];
//    [self addSubview:btnBark];
//    [btnBark setImage:[UIImage imageNamed:@"goBackWhite.png"] forState:UIControlStateNormal];
//    [btnBark addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    
    
    rect = MY_RECT(262, 611, 40, 40);
    rect.size.width = rect.size.height;
    UIButton *btnOk = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:btnOk];
    [btnOk addTarget:self action:@selector(clickOK) forControlEvents:UIControlEventTouchUpInside];
    //    btnOk.backgroundColor = [UIColor redColor];
    [btnOk setImage:[UIImage imageNamed:@"editPhOk.png"] forState:UIControlStateNormal];
    
    
    rect = MY_RECT(73, 611, 40, 40);
    rect.size.width = rect.size.height;
    UIButton *btnCancel = [[UIButton alloc]initWithFrame:rect];
    [self.view addSubview:btnCancel];
    [btnCancel addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    //    btnCancel.backgroundColor = [UIColor redColor];
    [btnCancel setImage:[UIImage imageNamed:@"editPhCancel.png"] forState:UIControlStateNormal];
    
    
    
    
    //add ges
    UIPanGestureRecognizer *panGesView = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveViewRounded:)];
    [viewBackgr addGestureRecognizer:panGesView];
    
    UIPanGestureRecognizer *panViewRoundedFir = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveViewRounded:)];
    [viewRoundedFir addGestureRecognizer:panViewRoundedFir];
    
    UIPanGestureRecognizer *panSecGesView = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveViewRounded:)];
    [viewRoundedSec addGestureRecognizer:panSecGesView];
    
    UIPanGestureRecognizer *panGesViewThe = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveViewRounded:)];
    [viewRoundedThe addGestureRecognizer:panGesViewThe];
    
    UIPanGestureRecognizer *panRoundedFour = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveViewRounded:)];
    [viewRoundedFour addGestureRecognizer:panRoundedFour];
    
}



- (void)moveViewRounded:(UIPanGestureRecognizer *)panGes
{
    UIView *view = panGes.view;
    
    //
    //    if (panGes.state == UIGestureRecognizerStateBegan) {
    //
    //        oldPoint = [panGes locationInView:self];
    //    }
    if (panGes.state == UIGestureRecognizerStateBegan) {
        if (!moveCurView) {
            moveCurView = panGes.view;
        }
        oldPoint = [panGes locationInView:self.view];
    }
    else if(panGes.state == UIGestureRecognizerStateEnded)
    {
        moveCurView = nil;
    }
    if (moveCurView != panGes.view) {
        return;
    }
    
    
    CGPoint point = [panGes locationInView:self.view];
    oldPoint.x =  point.x - oldPoint.x;
    oldPoint.y =  point.y - oldPoint.y;
    
    CGPoint centerPoint = panGes.view.center ;
    centerPoint.x += oldPoint.x;
    centerPoint.y += oldPoint.y;
    //
    
    CGRect rectImage = imageView.frame;
    
    CGPoint curPoint = panGes.view.center;
    
    BOOL bEdit = NO;
    if (view == viewBackgr) {
        
        if (centerPoint.x - panGes.view.frame.size.width / 2.0 >= rectImage.origin.x &&
            centerPoint.x + panGes.view.frame.size.width / 2.0 <= rectImage.origin.x + rectImage.size.width &&
            centerPoint.y - panGes.view.frame.size.height / 2.0 >= rectImage.origin.y &&
            centerPoint.y + panGes.view.frame.size.height / 2.0 <= rectImage.origin.y + rectImage.size.height) {
            curPoint = CGPointMake(centerPoint.x, centerPoint.y);
            bEdit = YES;
        }
        
        if (bEdit) {
            panGes.view.center = curPoint;
        }
       
    }
    else if (view == viewRoundedFir) {
        if (centerPoint.x >= rectImage.origin.x &&
            centerPoint.x <= rectImage.origin.x + rectImage.size.width &&
            viewRoundedSec.center.x - centerPoint.x >= floDifference) {
            curPoint = CGPointMake(centerPoint.x, curPoint.y);
            bEdit = YES;
        }
        if(centerPoint.y >= rectImage.origin.y &&
           centerPoint.y <= rectImage.origin.y + rectImage.size.height &&
           viewRoundedFour.center.y - centerPoint.y >= floDifference)
        {
            curPoint = CGPointMake(curPoint.x, centerPoint.y);
            bEdit = YES;
        }
        
        if (bEdit) {
            panGes.view.center = curPoint;
            viewBackgr.frame = CGRectMake(viewRoundedFir.center.x, viewRoundedFir.center.y,viewRoundedSec.center.x - viewRoundedFir.center.x, viewRoundedFour.center.y - viewRoundedFir.center.y);
        }
       
    }
    else  if (view == viewRoundedSec) {
        if (centerPoint.x >= rectImage.origin.x  &&
            centerPoint.x <= rectImage.origin.x + rectImage.size.width &&
            centerPoint.x - viewRoundedFir.center.x >= floDifference) {
            curPoint = CGPointMake(centerPoint.x, curPoint.y);
            bEdit = YES;
        }
        if(centerPoint.y >= rectImage.origin.y &&
           centerPoint.y <= rectImage.origin.y + rectImage.size.height &&
           viewRoundedFour.center.y - centerPoint.y >= floDifference)
        {
            curPoint = CGPointMake(curPoint.x, centerPoint.y);
            bEdit = YES;
        }
        
        if (bEdit) {
            panGes.view.center = curPoint;
            viewBackgr.frame = CGRectMake(viewRoundedFir.center.x, viewRoundedSec.center.y,viewRoundedSec.center.x - viewRoundedFir.center.x, viewRoundedFour.center.y - viewRoundedSec.center.y);
        }
        
        
    } else  if (view == viewRoundedThe) {
        
        if (centerPoint.x >= rectImage.origin.x  &&
            centerPoint.x <= rectImage.origin.x + rectImage.size.width &&
            centerPoint.x - viewRoundedFour.center.x>= floDifference) {
            curPoint = CGPointMake(centerPoint.x, curPoint.y);
            bEdit = YES;
        }
        if(centerPoint.y >= rectImage.origin.y + floDifference &&
           centerPoint.y <= rectImage.origin.y + rectImage.size.height &&
           centerPoint.y - viewRoundedSec.center.y >= floDifference)
        {
            curPoint = CGPointMake(curPoint.x, centerPoint.y);
            bEdit = YES;
        }
        
        if (bEdit) {
            panGes.view.center = curPoint;
            viewBackgr.frame = CGRectMake(viewRoundedFir.center.x, viewRoundedFir.center.y,viewRoundedThe.center.x - viewRoundedFir.center.x, viewRoundedThe.center.y - viewRoundedFir.center.y);
        }
       
    } else  if (view == viewRoundedFour) {
        if (centerPoint.x >= rectImage.origin.x &&
            centerPoint.x <= rectImage.origin.x + rectImage.size.width &&
            viewRoundedThe.center.x - centerPoint.x >= floDifference ) {
            curPoint = CGPointMake(centerPoint.x, curPoint.y);
            bEdit = YES;
        }
        if(centerPoint.y >= rectImage.origin.y  &&
           centerPoint.y <= rectImage.origin.y + rectImage.size.height &&
           centerPoint.y - viewRoundedFir.center.y >= floDifference)
        {
            curPoint = CGPointMake(curPoint.x, centerPoint.y);
            bEdit = YES;
        }
        if (bEdit) {
            panGes.view.center = curPoint;
            viewBackgr.frame = CGRectMake(viewRoundedFour.center.x, viewRoundedFir.center.y,viewRoundedSec.center.x - viewRoundedFour.center.x, viewRoundedFour.center.y - viewRoundedFir.center.y);
        }
        
    }
    
    if (bEdit) {
        [self updateRoundedRect];
    }
    oldPoint = point;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
}

- (void)clickBack
{
   // [UIApplication sharedApplication].statusBarStyle =   UIStatusBarStyleDefault;//黑色
    if (_delegate && [_delegate respondsToSelector:@selector(removeTailoringView)]) {
        [_delegate removeTailoringView];
    }
    [self.navigationController popViewControllerAnimated:YES];
   // [self removeFromSuperview];
}

- (void)clickCancel
{
    //[UIApplication sharedApplication].statusBarStyle =   UIStatusBarStyleDefault;//黑色
    if (_delegate && [_delegate respondsToSelector:@selector(removeTailoringView)]) {
        [_delegate removeTailoringView];
    }
    [self.navigationController popViewControllerAnimated:YES];
   // [self removeFromSuperview];
}

- (void)clickOK
{
    CGSize size = tailoringImage.size;
    CGRect rect = imageView.frame;
    CGRect myImageRect ;
    myImageRect.size.width = size.width / rect.size.width * viewBackgr.frame.size.width;
    
    myImageRect.size.height = size.height / rect.size.height * viewBackgr.frame.size.height;
    
    //    myImageRect.origin.x = myImageRect.size.width;
    //    myImageRect.origin.y =  myImageRect.size.height;
    
    myImageRect.origin.x = size.width / rect.size.width * (viewBackgr.frame.origin.x - imageView.frame.origin.x);
    myImageRect.origin.y = size.height / rect.size.height * (viewBackgr.frame.origin.y - imageView.frame.origin.y);
    //第一种方法
    //
    //    UIGraphicsBeginImageContext(tailoringImage.size);
    //    // 2.绘制到图形上下文中
    //    [tailoringImage drawInRect:CGRectMake(0, 0, 400, 400)];
    //    // 3.从上下文中获取图片
    UIImage *subImage ;//= UIGraphicsGetImageFromCurrentImageContext();
    //    // 4.关闭图形上下文
    //    UIGraphicsEndImageContext();
    //    imageView.image = subImage;
    //    return;
    //
    //
    //    //第二种
    //
    //    CGImageRef imageRef = tailoringImage.CGImage;
    //    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    //    UIGraphicsBeginImageContext(myImageRect.size);
    ////    UIGraphicsBeginImageContextWithOptions(myImageRect.size, YES, 0);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextDrawImage(context, CGRectMake(0, 0, myImageRect.size.width, myImageRect.size.height), subImageRef);
    //    UIImage *subImage = [UIImage imageWithCGImage:subImageRef];
    //    CGImageRelease(subImageRef);
    //    UIGraphicsEndImageContext();
    
    CGImageRef sourceImageRef = tailoringImage.CGImage;//将UIImage转换成CGImageRef
    
    //    CGFloat _imageWidth = image.size.width * image.scale;
    //    CGFloat _imageHeight = image.size.height * image.scale;
    //    CGFloat _width = _imageWidth > _imageHeight ? _imageHeight : _imageWidth;
    //    CGFloat _offsetX = (_imageWidth - _width) / 2;
    //    CGFloat _offsetY = (_imageHeight - _width) / 2;
    
    //    CGRect rect = CGRectMake(_offsetX, _offsetY, _width, _width);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, myImageRect);//按照给定的矩形区域进行剪裁
    subImage = [UIImage imageWithCGImage:newImageRef];
    
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(setTailoringImage:)]) {
        [_delegate setTailoringImage:subImage];
    }
   // [UIApplication sharedApplication].statusBarStyle =   UIStatusBarStyleDefault;//黑色
    [self.navigationController popViewControllerAnimated:YES];
    //[self removeFromSuperview];
    
    // [self setImage:subImage];
}

- (void)setImage:(UIImage *)image
{
    CGSize size = image.size;
    tailoringImage = image;
    imageView.image = image;
    
    //CGSize size = CGSizeMake(100, 500);
    CGRect rect = imageView.frame;
    CGRect viewBackgrRect = viewBackgr.frame;
    
    if (!_bHeadIcon) {
        CGFloat floWid = rect.size.width;
        CGFloat floHei = rect.size.width /  size.width  * size.height;
        if (floHei <= rect.size.height) {
            rect.size.width = floWid;
            rect.size.height = floHei;
            
            viewBackgrRect.size.height = floHei;
            //viewBackgrRect.size.width = rect.size.height / HEIGHT * WIDTH;
            viewBackgrRect.size.width = WIDTH / ( HEIGHT / floHei );
        }
        else
        {//高出头了
            floHei = rect.size.height;
            floWid = floHei / size.height * size.width;
            rect.size.width = floWid;
            rect.size.height = floHei;
            
            viewBackgrRect.size.width = floWid;
            viewBackgrRect.size.height =HEIGHT / ( WIDTH / floWid );//  floHei;
        }
    }
    else
    {
        
        //rect.size.height / size.height;
        CGFloat floWid = rect.size.width;
        CGFloat floHei = rect.size.width / size.width * size.height;
        
        if(floHei <= rect.size.height)
        {
            rect.size.height = floHei;
        }//
        else //if()
        {
            rect.size.width = rect.size.height / size.height * size.width;
        }
        
        if (rect.size.width >=  rect.size.height) {
            viewBackgrRect.size.width = rect.size.height;
        }
        else
        {
            viewBackgrRect.size.width = rect.size.width;
        }
        viewBackgrRect.size.height = viewBackgrRect.size.width;
    
    }
    
    imageView.frame = rect;
    imageView.backgroundColor = [UIColor redColor];
    imageView.center = CGPointMake(WIDTH / 2.0, HEIGHT / 2.0);
    viewBackgr.frame =  viewBackgrRect;//imageView.frame;
    viewBackgr.center = CGPointMake( WIDTH / 2.0, HEIGHT / 2.0);
    
    [self updateRoundedRect];
}

- (void)updateRoundedRect
{
    CGRect  rectImage = viewBackgr.frame;
    
    viewRoundedFir.center = CGPointMake(rectImage.origin.x, rectImage.origin.y);
    
    viewRoundedSec.center = CGPointMake(rectImage.origin.x + rectImage.size.width, rectImage.origin.y);
    
    viewRoundedThe.center = CGPointMake(rectImage.origin.x + rectImage.size.width, rectImage.origin.y + rectImage.size.height);
    
    viewRoundedFour.center = CGPointMake(rectImage.origin.x, rectImage.origin.y + rectImage.size.height);
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
