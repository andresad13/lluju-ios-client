//
//  GlobalObject.m
//  Tanc
//
//  Created by f on 2019/12/4.
//  Copyright © 2019 f. All rights reserved.
//

#import "GlobalObject.h"

static GlobalObject *sharedInstance = nil;

@implementation GlobalObject

+ (GlobalObject *)shareObject
{
    @synchronized (self) {
        if (sharedInstance == nil)
        {
            sharedInstance = [[self alloc] init];
            //sharedInstance.seleLanguage = @"tw";
        }
    }
    
    return sharedInstance;
}

/*尺寸转换*/
+ (CGRect)ConvertScreen:(CGRect)srcRect
{
    CGRect rcScreen = [[UIScreen mainScreen] bounds];
    int sw = rcScreen.size.width;
    int sh = rcScreen.size.height;
    
    float scaleX = sw / IPHONE6SWIDTH;
    float scaleY = sh / IPHONE6SHEIGHT;
    
    CGRect desRect = srcRect;
    if (desRect.origin.x != 0)
        desRect.origin.x = (float)(srcRect.origin.x * scaleX);
    if (desRect.origin.y != 0)
        desRect.origin.y = (float)(srcRect.origin.y * scaleY);
    desRect.size.width = (float)(srcRect.size.width * scaleX);
    desRect.size.height = (float)(srcRect.size.height * scaleY);
    return desRect;
}

+ (NSString *)getCurLanguage:(NSString *)str
{
   // return str;
//    if ([[GlobalObject shareObject].seleLanguage isEqualToString:@""]) {
//        return str;
//    }
    

    if (![GlobalObject shareObject].languageType || [[GlobalObject shareObject].languageType allKeys].count <= 0) {
        [GlobalObject shareObject].languageType = [[GlobalObject shareObject] getLanguageJson];
    }
   // NSDictionary *dic = [GlobalObject shareObject].languageType;
    if ([GlobalObject shareObject].languageType && [[GlobalObject shareObject].languageType allKeys].count > 0 &&  [[[GlobalObject shareObject].languageType allKeys] containsObject:str]) {
       return [GlobalObject shareObject].languageType[str];
    }
    
    return str;
}

- (NSDictionary *)getLanguageJson
{
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"LanguageType"
                                                          ofType:@"json"];
    NSError  * error;
    NSString * str22 = [NSString stringWithContentsOfFile:filePath
                                                 encoding:NSUTF8StringEncoding
                                                    error:&error];
    if (error) { return @{}; }
    
    NSDictionary *dic = [self dictionaryWithJsonString:str22];
    return dic;
    
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData  * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



+ (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
    
    // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}

+ (NSIndexPath*)getIndexPathOfCellEvent:(id)event view:(UICollectionView *)colView tabView:(UITableView *)tabView
{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    
    if (colView)
    {
        CGPoint Position = [touch locationInView:colView];
        return [colView indexPathForItemAtPoint:Position];
    }
    else
    {
        CGPoint Position = [touch locationInView:tabView];
        return  [tabView indexPathForRowAtPoint:Position];
    }
    
}

+ (CGFloat)widthOfString:(NSString *)string font:(UIFont *)font
{
    
    NSDictionary *attributes = @{NSFontAttributeName : font};     //字体属性，设置字体的font
    
    CGSize maxSize = CGSizeMake(MAXFLOAT, 20);     //设置字符串的宽高  MAXFLOAT为最大宽度极限值  JPSlideBarHeight为固定高度
    
    CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size; return ceil(size.width);     //此方法结合  预编译字符串  字体font  字符串宽高  三个参数计算文本  返回字符串宽度
    
}

/*获得不同类型字体*/
+ (UIFont *)getAvenirFontEnumType:(AvenirFontEnumType)curType fontSize:(int)fontSize
{
    NSString *str = @"Avenir-Light";
       switch (curType) {
           case Avenir_Light:
               str = @"AvenirNext-Medium";
               break;
           case Avenir_Roman:
               str = @"AvenirNext-DemiBold";
               break;
           case Avenir_Black:
               str = @"AvenirNext-Bold";
               break;

           default:
               break;
       }
 
    return [UIFont fontWithName:str size:fontSize];
}

/*开始动画*/
+ (void)moveAnimation:(UIView *)view  Rect:(CGRect)rect  AnimaTime:(CGFloat)animaTime  AnimationStr:(NSString *)animationID  AnimationCurve:(int)animaCurve  // Delegate:(id)delegate
{
    [UIView beginAnimations:animationID context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:animaTime];
    view.frame = rect;
    // [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}



+ (UIImage *)setThumbnailFromImage:(UIImage *)image
{
    UIImage *newimage;
    CGSize oldsize = image.size;
    // CGFloat imageWid = oldsize.height / (oldsize.width / (1000 / IPHONE6SWIDTH * WIDTH));//
    // 1334
    CGSize asize;
    if(image.size.height > 500)
    {
        asize = CGSizeMake(oldsize.width / (oldsize.height / 500.0 ) , 500 );
    }
    else
    {
        asize = oldsize;
    }
    
    
    if (nil == image)
    {
        
        newimage = nil;
    }
    else
    {
        
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            
            rect.size.height = asize.height;
            
            rect.origin.x = (asize.width - rect.size.width)/2;
            
            rect.origin.y = 0;
            
        }
        
        else{
            
            rect.size.width = asize.width;
            
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            rect.origin.x = 0;
            
            rect.origin.y = (asize.height - rect.size.height)/2;
            
        }
        
        
        UIGraphicsBeginImageContext(asize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    
    return newimage;
    
}

+ (NSString *)getDistanceTransformation:(int )str
{
    if ( str  > 999) {
        CGFloat floNum = str / 1000.0;
        if (floNum > 100) {
            return [NSString stringWithFormat:@"%0.0fkm", floNum];
        }
        return [NSString stringWithFormat:@"%0.1fkm", floNum];
    }
    return [NSString stringWithFormat:@"%dm",str];
}

/*去掉多余的+*/
+ (NSString *)isHaveAdd:(NSString *)str
{
    if ([str containsString:@"+"] && [str length] > 1) {
      return  [str substringFromIndex:1];//截取掉下标3之后的字符串
    }
    return str;
}

+ (NSString *)judgeStringNil:(NSString *)result
{
    if(result == nil) return @"";
    // <null>判断方法
    if([result isEqual:[NSNull null]]) return @"";
    return result;
}

/*去掉多余的空格*/
+ (NSString *)getTRIMStr:(NSString *)str
{
    NSString *theString = str;
    
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts = [theString componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    theString = [filteredArray componentsJoinedByString:@" "];
    return theString;
}


+ (NSString *)timestampCurSeconds:(NSString *)timeStr
{
    NSInteger num = [timeStr integerValue];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * confromTime = [NSDate dateWithTimeIntervalSince1970:num];
    NSString * comfromTimeStr = [formatter stringFromDate:confromTime];
    
    return comfromTimeStr;
}


- (NSDictionary *)getUserAccountShare
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"MoKeHomeUser"];
    //反归档
    //1:读取文件,生成NSData类型
    NSData *unarchiverData = [NSData dataWithContentsOfFile:filePath];
    //2:创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
    //3:反归档.根据可以访问
    NSDictionary *dicc = [unarchiver decodeObjectForKey:@"userArrayShare"];
    if(dicc == nil)
    {
        return  @{};
    }
    
    
    
    return dicc;
}

- (void)addUserAccountShare:(NSString *)token
{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
      [dic setValue:token forKey:@"token"];
      
      
      NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
      
      //在document文件夹下,创建新的文件
      NSString *filePath = [documentPath stringByAppendingPathComponent:@"MoKeHomeUser"];
      
      NSMutableData *archiverData =[NSMutableData data] ;
      //2:创建归档对象
      NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverData];
      
      [archiver encodeObject:dic forKey:@"userArrayShare"];
      //4:完成归档
      [archiver finishEncoding];
      //5:写入
      BOOL result = [archiverData writeToFile:filePath atomically:YES];
      
      if (result) {
          //  NSLog(@"归档成功:%@",filePath);
      }
}

- (void)deleteUserFile
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //在document文件夹下,创建新的文件
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"MoKeHomeUser"];
    
    NSMutableData *archiverData =[NSMutableData data] ;
    //2:创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverData];
    
    [archiver encodeObject:@{} forKey:@"userArrayShare"];
    //4:完成归档
    [archiver finishEncoding];
    //5:写入
    BOOL result = [archiverData writeToFile:filePath atomically:YES];
    
    if (result) {
        //  NSLog(@"归档成功:%@",filePath);
    }
}

/*viss mas*/
+ (NSString *)regexUsePredicateWithText:(NSString *)cardTextField {
    /** Visa */
    NSString *visaRegex = @"^4[0-9]{6,}$";
    NSPredicate *visaPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", visaRegex];
    
    
    /** Maestro */
    NSString *maestroRegex = @"^(50|(5[6-9])|(6[\\d]))\\d{10,17}$";
    NSPredicate *maestroPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", maestroRegex];
    
    
    /** MasterCard */
    NSString *masterCardRegex = @"^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$";
    NSPredicate *masterCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", masterCardRegex];
    
//    /** American Express */
//    NSString *americanExpRegex = @"^(3(4|7))\\d{10,16}$";
//    NSPredicate *americanExpPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", americanExpRegex];
    
    
    /** Jcb */
    NSString *dinersRegex = @"^(?:2131|1800|35[0-9]{3})[0-9]{3,}$";
    NSPredicate *dinersPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", dinersRegex];
    
    
    if ([visaPredicate evaluateWithObject:cardTextField]) {
        return @"visa";
        // return @"Visa";
    }   if ([maestroPredicate evaluateWithObject:cardTextField]) {
         return @"visa";
        //return @"MasterCard";
    }   if ([masterCardPredicate evaluateWithObject:cardTextField]) {
       return @"masterCard";
        // return @"MasterCard";
    }
//    if ([americanExpPredicate evaluateWithObject:cardTextField]) {
//        NSLog(@"已经匹配到American Express卡");
//    }
    if ([dinersPredicate evaluateWithObject:cardTextField]) {
        return @"jCB";
       // NSLog(@"已经匹配到JCB卡");
    }
    //    else {
    //        NSLog(@"没有匹配到信用卡");
    //    }
    NSLog(@"=-----------");
    return @"masterCard";
}


+ (BOOL)isStringNil:(NSString *)result
{
    if(result == nil) return NO;
    // <null>判断方法
    if([result isEqual:[NSNull null]]) return NO;
    
    return YES;
}

+ (NSString *)getOrderState:(NSString *)strState
{
    if ([strState isEqualToString:@"租借中"]) {
        return @"On loan";
    }
    else if([strState isEqualToString:@"已归还"])
    {
        return @"Returned";
    }
    else if([strState isEqualToString:@"请求中"])
    {
        return @"Request";
    }
    else if([strState isEqualToString:@"已撤销"] || [strState isEqualToString:@"撤销单"] )
    {
        return @"Cancellation order";;//return @"Revoked";
    }
//    else if([strState isEqualToString:@"撤销单"])
//    {
//       return @"Cancellation order";
//    }
    else if([strState isEqualToString:@"存疑"])
    {
         return @"In doubt";
    }
    else if([strState isEqualToString:@"购买单"] || [strState isEqualToString:@"购买订单"])
    {
         return @"Purchase order";
    }
    else if([strState isEqualToString:@"故障单"])
    {
        return @"Ticket";
    }
    else if([strState isEqualToString:@"超时单"])
    {
        return @"Time out";
    }
    else if( [strState isEqualToString:@"已支付"])
    {
        return @"Paid";
    }
    
    return strState;
}


+ (UIColor *)getOrderColor:(NSString *)strState
{
    if ([strState isEqualToString:@"租借中"]) {
        //f45344
        return [UIColor colorWithRed:0x63 / 255.0 green:0xb1 / 255.0 blue:0x5e / 255.0 alpha:1];
    }
    else if([strState isEqualToString:@"已归还"])
    {
         //000000
        return [UIColor colorWithRed:00 / 255.0 green:00 / 255.0 blue:00 / 255.0 alpha:1];
    }
    else if([strState isEqualToString:@"请求中"]|| [strState isEqualToString:@"已支付"])
    {
         return [UIColor colorWithRed:0x63 / 255.0 green:0xb1 / 255.0 blue:0x5e / 255.0 alpha:1];
    }
    else if([strState isEqualToString:@"已撤销"]  || [strState isEqualToString:@"撤销单"])
    {
          return [UIColor colorWithRed:00 / 255.0 green:00 / 255.0 blue:00 / 255.0 alpha:1];
    }
//    else if([strState isEqualToString:@"撤销单"])
//    {
//       return @"撤銷單";
//    }
    else if([strState isEqualToString:@"存疑"])
    {//#f45344；

           return [UIColor colorWithRed:0xf4 / 255.0 green:53 / 255.0 blue:44 / 255.0 alpha:1];
    }
    else if([strState isEqualToString:@"购买单"] || [strState isEqualToString:@"购买订单"])
    {
         return [UIColor colorWithRed:00 / 255.0 green:00 / 255.0 blue:00 / 255.0 alpha:1];
    }
    else if([strState isEqualToString:@"故障单"])
    {//f45344
       return [UIColor colorWithRed:0xf4 / 255.0 green:53 / 255.0 blue:44 / 255.0 alpha:1];
    }
    else if([strState isEqualToString:@"超时单"] )
    {//#f45344；
       return [UIColor colorWithRed:0xf4 / 255.0 green:53 / 255.0 blue:44 / 255.0 alpha:1];
    }
   return [UIColor colorWithRed:00 / 255.0 green:00 / 255.0 blue:00 / 255.0 alpha:1];;
}

@end
