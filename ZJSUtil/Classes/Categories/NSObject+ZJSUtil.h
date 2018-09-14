//
//  NSObject+ZJSUtil.h
//  Pods-ZJSUtil_Example
//
//  Created by 查俊松 on 2018/9/13.
//

#import <UIKit/UIKit.h>

@interface NSObject (ZJSUtil)

// 获取当前的时间戳（以毫秒为单位）
+ (NSTimeInterval)zjs_currentTimeInterval;
// 获取当天的@"yyyy-MM-dd HH:mm:ss"格式的字符串（timeString为HH:mm:ss格式）
+ (NSString *)zjs_todaySomeTimeDateStringWithTimeString:(NSString *)timeString;
// 将时间转化成指定格式
+ (NSString *)zjs_transformToSpecificDateStringWithFormat:(NSString *)format date:(NSDate *)date;
// 将时间戳转化成指定格式（以毫秒为单位）
+ (NSString *)zjs_transformToSpecificDateStringWithFormat:(NSString *)format timeInterval:(NSTimeInterval)timeInterval;
// 将指定格式时间字符串转化成时间
+ (NSDate *)zjs_transformToDateWithFormat:(NSString *)format specificTimeString:(NSString *)specificTimeString;
// 将指定格式时间字符串转化成时间戳（以毫秒为单位）
+ (NSTimeInterval)zjs_transformToTimeIntervalWithFormat:(NSString *)format specificTimeString:(NSString *)specificTimeString;
// 将时间转化成@"yyyy-MM-dd"的格式
+ (NSString *)zjs_transformToBlurryDateStringWithDate:(NSDate *)date;
// 将时间戳转化成@"yyyy-MM-dd"的格式（以毫秒为单位）
+ (NSString *)zjs_transformToBlurryDateStringWithTimeInterval:(NSTimeInterval)timeInterval;
// 将时间转化成@"yyyy-MM-dd HH:mm:ss"的格式
+ (NSString *)zjs_transformToDateStringWithDate:(NSDate *)date;
// 将时间戳转化成@"yyyy-MM-dd HH:mm:ss"的格式（以毫秒为单位）
+ (NSString *)zjs_transformToDateStringWithTimeInterval:(NSTimeInterval)timeInterval;
// 将@"yyyy-MM-dd HH:mm:ss"格式的字符串转化成时间
+ (NSDate *)zjs_transformToDateWithDateString:(NSString *)dateString;
// 将@"yyyy-MM-dd"格式的字符串转化成时间
+ (NSDate *)zjs_transformToBlurryDateWithDateString:(NSString *)dateString;
// 将@"yyyy-MM-dd HH:mm:ss"格式的字符串转化成时间戳（以毫秒为单位）
+ (NSTimeInterval)zjs_transformToTimeIntervalWithDateString:(NSString *)dateString;
// 将@"yyyy-MM-dd"格式的时间字符串排序
+ (NSArray *)zjs_sortTimeStrings:(NSArray *)timeStrings ascending:(BOOL)ascending;
// 计算文本宽度
+ (CGFloat)zjs_widthForLabelWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font;
// 计算文本高度
+ (CGFloat)zjs_heightForLabelWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font numberOfLines:(NSInteger)numberOflines maxWidth:(CGFloat)maxWidth;
// 计算文本高度
+ (CGFloat)zjs_heightForLabelWithAttributedText:(NSAttributedString *)attributedText textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font numberOfLines:(NSInteger)numberOflines maxWidth:(CGFloat)maxWidth;
// 获取一个指定行高的字符串
+ (NSAttributedString *)zjs_attributedTextWithText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;
// 获取一个指定行高，字体大小，字体颜色，对齐方式的字符串
+ (NSAttributedString *)zjs_attributedTextWithText:(NSString *)text lineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;
// 获取一个指定字体，字体颜色的字符串
+ (NSAttributedString *)zjs_attributedTextWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;
// 获取一个带中划线的字符串
+ (NSAttributedString *)zjs_attributedStrikethroughTextWithText:(NSString *)text lineColor:(UIColor *)lineColor;
// 获取一个带下划线的字符串
+ (NSAttributedString *)zjs_attributedUnderlineTextWithText:(NSString *)text lineColor:(UIColor *)lineColor;
// 创建一个标准的下标数组
+ (NSArray *)zjs_indexsArrayWithCount:(NSUInteger)count;
// 随机一个指定位数的随机数字字符串
+ (NSString *)zjs_arc4randomNumStringWithCount:(NSUInteger)count;
// 随机一个指定位数的随机数字字符串（不含0）
+ (NSString *)zjs_arc4randomNumExceptZeroStringWithCount:(NSUInteger)count;
// 随机一个指定位数的随机字符串（数字和字母组合）
+ (NSString *)zjs_arc4randomStringWithCount:(NSUInteger)count;
// 将indexPath转化成字符串key
+ (NSString *)zjs_indexPathStringKey:(NSIndexPath *)indexPath;
// 拨打电话
+ (UIWebView *)zjs_callSomeoneWithPhoneNumber:(NSString *)phoneNumber;
// 获取App版本号
+ (NSString *)zjs_getAppVersion;
// 获取App版本号和build号
+ (NSString *)zjs_getAppVersionAppendBuildVersion;
// 将字典序列化为请求字符串
+ (NSString *)zjs_serializeToStringWithDic:(NSDictionary *)dic;
// 将请求字符串反序列化为字典
+ (NSDictionary *)zjs_deserializeToDicWithString:(NSString *)string;
// 封装UIAlertController（8.0及以上）
+ (void)zjs_showAlertControllerWithPresentingVC:(UIViewController *)presentingVC preferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message alertActions:(NSArray<UIAlertAction *> *)alertActions presentCompletion:(void (^)(void))presentCompletion;
// 正则判断文本是否包含中文
+ (BOOL)zjs_predicateIfContainsChineseWithText:(NSString *)text;
// 正则判断文本是否是纯中文
+ (BOOL)zjs_predicateIfPureChineseWithText:(NSString *)text;

@end
