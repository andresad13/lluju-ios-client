//
//  GlobalObject.h
//  Tanc
//
//  Created by f on 2019/12/4.
//  Copyright © 2019 f. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GlobalObject : NSObject


@property (nonatomic,strong)NSString *seleLanguage;//当前选中的语言

@property (nonatomic,strong)NSString *curLatitude;//經緯度 我当前位置
@property (nonatomic,strong)NSString *curLongitude;

@property (nonatomic,strong)NSString *nearbyLatitude;//地图中心附近的經緯度
@property (nonatomic,strong)NSString *nearbyLongitude;

@property (nonatomic,strong)NSString *toKenSear;
@property (nonatomic,strong)NSString *openid;

@property (nonatomic,strong)UserModel *userModel;

@property (nonatomic,strong)NSDictionary *languageType;//获取当前语言json

@property (nonatomic,strong)NSDictionary *serviceCus;//客服
 
/*获取当前语言*/
- (NSDictionary *)getLanguageJson;
  
/*单例*/
+ (GlobalObject *) shareObject;

/*尺寸转换*/
+ (CGRect)ConvertScreen:(CGRect)srcRect;

/*过滤空格*/
+ (NSString *)getTRIMStr:(NSString *)str;

/*获取语言*/
+ (NSString *)getCurLanguage:(NSString *)str;

/*通过宽度 获取高度*/
+ (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width;

/*获得tableview  indexpath*/
+ (NSIndexPath*)getIndexPathOfCellEvent:(id)event view:(UICollectionView *)colView tabView:(UITableView *)tabView;

/*获取文字宽度*/
+ (CGFloat)widthOfString:(NSString *)string font:(UIFont *)font;

/*获得不同类型字体*/
+ (UIFont *)getAvenirFontEnumType:(AvenirFontEnumType)curType fontSize:(int)fontSize;

/*动画*/
+ (void)moveAnimation:(UIView *)view  Rect:(CGRect)rect  AnimaTime:(CGFloat)animaTime  AnimationStr:(NSString *)animationID  AnimationCurve:(int)animaCurve ;

/*去掉多余的+*/
+ (NSString *)isHaveAdd:(NSString *)str;

//判断数据是否是 nil 画或者 “《NUL》”
+ (NSString *)judgeStringNil:(NSString *)result;

+ (UIImage *)setThumbnailFromImage:(UIImage *)image;

/*距离 优化*/
+ (NSString *)getDistanceTransformation:(int )str;

/*时间戳转日期*/
+ (NSString *)timestampCurSeconds:(NSString *)timeStr;

- (NSDictionary *)getUserAccountShare;

- (void)addUserAccountShare:(NSString *)token;

- (void)deleteUserFile;

/*viss mas*/
+ (NSString *)regexUsePredicateWithText:(NSString *)cardTextField;

//是否是字符串
+ (BOOL)isStringNil:(NSString *)result;

+ (NSString *)getOrderState:(NSString *)strState;

+ (UIColor *)getOrderColor:(NSString *)strState;
@end

NS_ASSUME_NONNULL_END
