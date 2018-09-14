//
//  NSObject+ZJSUtil.m
//  Pods-ZJSUtil_Example
//
//  Created by 查俊松 on 2018/9/13.
//

#import "NSObject+ZJSUtil.h"

@implementation NSObject (ZJSUtil)

#pragma mark 获取当前的时间戳（以毫秒为单位）
+ (NSTimeInterval)zjs_currentTimeInterval
{
    NSDate *date = [NSDate date];
    NSTimeInterval currentTimeInterval = [date timeIntervalSince1970];
    return currentTimeInterval*kZJS_ScaleBetweenSecondAndMillisecond;
}

#pragma mark 获取当天的@"yyyy-MM-dd HH:mm:ss"格式的字符串（timeString为HH:mm:ss格式）
+ (NSString *)zjs_todaySomeTimeDateStringWithTimeString:(NSString *)timeString
{
    if (!timeString || !timeString.length || ([timeString componentsSeparatedByString:kZJS_Symbol_Colon].count != 3)) {
        timeString = @"00:00:00";
    }
    NSString *todayString = [NSObject zjs_transformToBlurryDateStringWithTimeInterval:[NSObject zjs_currentTimeInterval]];
    NSString *someTimeDateString = [NSString stringWithFormat:@"%@%@%@", todayString, kZJS_Space, timeString];
    return someTimeDateString;
}

#pragma mark 将时间转化成指定格式
+ (NSString *)zjs_transformToSpecificDateStringWithFormat:(NSString *)format date:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format.length ? format : @"yyyy-MM-dd HH:mm:ss";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

#pragma mark 将时间戳转化成指定格式（以毫秒为单位）
+ (NSString *)zjs_transformToSpecificDateStringWithFormat:(NSString *)format timeInterval:(NSTimeInterval)timeInterval
{
    timeInterval = timeInterval / kZJS_ScaleBetweenSecondAndMillisecond;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [NSObject zjs_transformToSpecificDateStringWithFormat:format date:date];
}

#pragma mark 将指定格式时间字符串转化成时间
+ (NSDate *)zjs_transformToDateWithFormat:(NSString *)format specificTimeString:(NSString *)specificTimeString
{
    if (!specificTimeString || !specificTimeString.length) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:specificTimeString];
    return date;
}

#pragma mark 将指定格式时间字符串转化成时间戳（以毫秒为单位）
+ (NSTimeInterval)zjs_transformToTimeIntervalWithFormat:(NSString *)format specificTimeString:(NSString *)specificTimeString
{
    NSDate *date = [self zjs_transformToDateWithFormat:format specificTimeString:specificTimeString];
    if (!date) {
        return 0;
    }
    // 转化成以毫秒为单位返回
    return [date timeIntervalSince1970]*kZJS_ScaleBetweenSecondAndMillisecond;
}

#pragma mark 将时间转化成@"yyyy-MM-dd"的格式
+ (NSString *)zjs_transformToBlurryDateStringWithDate:(NSDate *)date
{
    return [self zjs_transformToSpecificDateStringWithFormat:@"yyyy-MM-dd" date:date];
}

#pragma mark 将时间戳转化成@"yyyy-MM-dd"的格式（以毫秒为单位）
+ (NSString *)zjs_transformToBlurryDateStringWithTimeInterval:(NSTimeInterval)timeInterval
{
    return [self zjs_transformToSpecificDateStringWithFormat:@"yyyy-MM-dd" timeInterval:timeInterval];
}

#pragma mark 将时间转化成@"yyyy-MM-dd HH:mm:ss"的格式
+ (NSString *)zjs_transformToDateStringWithDate:(NSDate *)date
{
    return [self zjs_transformToSpecificDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss" date:date];
}

#pragma mark 将时间戳转化成@"yyyy-MM-dd HH:mm:ss"的格式（以毫秒为单位）
+ (NSString *)zjs_transformToDateStringWithTimeInterval:(NSTimeInterval)timeInterval
{
    return [self zjs_transformToSpecificDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss" timeInterval:timeInterval];
}

#pragma mark 将@"yyyy-MM-dd HH:mm:ss"格式的字符串转化成时间
+ (NSDate *)zjs_transformToDateWithDateString:(NSString *)dateString
{
    return [self zjs_transformToDateWithFormat:@"yyyy-MM-dd HH:mm:ss" specificTimeString:dateString];
}

#pragma mark 将@"yyyy-MM-dd"格式的字符串转化成时间
+ (NSDate *)zjs_transformToBlurryDateWithDateString:(NSString *)dateString
{
    return [self zjs_transformToDateWithFormat:@"yyyy-MM-dd" specificTimeString:dateString];
}

#pragma mark 将@"yyyy-MM-dd HH:mm:ss"格式的字符串转化成时间戳（以毫秒为单位）
+ (NSTimeInterval)zjs_transformToTimeIntervalWithDateString:(NSString *)dateString
{
    return [self zjs_transformToTimeIntervalWithFormat:@"yyyy-MM-dd HH:mm:ss" specificTimeString:dateString];
}

#pragma mark 将@"yyyy-MM-dd"格式的时间字符串排序
+ (NSArray *)zjs_sortTimeStrings:(NSArray *)timeStrings ascending:(BOOL)ascending
{
    // 安全判断
    if (!timeStrings || !timeStrings.count) {
        return timeStrings;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSComparisonResult exchangeResult = NSOrderedSame;
    if (ascending) {
        exchangeResult = NSOrderedDescending;
    } else {
        exchangeResult = NSOrderedAscending;
    }
    timeStrings = [timeStrings sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *timeString1 = obj1;
        NSString *timeString2 = obj2;
        NSDate *date1 = [formatter dateFromString:timeString1];
        NSDate *date2 = [formatter dateFromString:timeString2];
        NSComparisonResult comparisonResult = [date1 compare:date2];
        return (comparisonResult == exchangeResult);
    }];
    return timeStrings;
}

#pragma mark 计算文本宽度
+ (CGFloat)zjs_widthForLabelWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font
{
    if (!text || !text.length || !font) {
        return 0;
    }
    UILabel *lab = [UILabel new];
    lab.textAlignment = textAlignment;
    lab.font = font;
    lab.text = text;
    [lab sizeToFit];
    return lab.bounds.size.width;
}

#pragma mark 计算文本高度
+ (CGFloat)zjs_heightForLabelWithText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font numberOfLines:(NSInteger)numberOflines maxWidth:(CGFloat)maxWidth
{
    if (!text || !text.length || !font || !maxWidth) {
        return 0;
    }
    UILabel *lab = [UILabel new];
    lab.bounds = CGRectMake(0, 0, maxWidth, 0);
    lab.textAlignment = textAlignment;
    lab.font = font;
    lab.numberOfLines = numberOflines;
    lab.text = text;
    [lab sizeToFit];
    return lab.bounds.size.height;
}

#pragma mark 计算文本高度
+ (CGFloat)zjs_heightForLabelWithAttributedText:(NSAttributedString *)attributedText textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font numberOfLines:(NSInteger)numberOflines maxWidth:(CGFloat)maxWidth
{
    if (!attributedText || !attributedText.length || !font || !maxWidth) {
        return 0;
    }
    UILabel *lab = [UILabel new];
    lab.bounds = CGRectMake(0, 0, maxWidth, 0);
    lab.textAlignment = textAlignment;
    lab.font = font;
    lab.numberOfLines = numberOflines;
    lab.attributedText = attributedText;
    [lab sizeToFit];
    return lab.bounds.size.height;
}

#pragma mark 获取一个指定行高的字符串
+ (NSAttributedString *)zjs_attributedTextWithText:(NSString *)text lineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    return attributedText;
}

#pragma mark 获取一个指定行高，字体大小，字体颜色，对齐方式的字符串
+ (NSAttributedString *)zjs_attributedTextWithText:(NSString *)text lineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.alignment = textAlignment;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    if (fontSize > 0) {
        [attributes setObject:kZJS_Font(fontSize) forKey:NSFontAttributeName];
    }
    if (textColor) {
        [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributedText;
}

#pragma mark 获取一个指定字体，字体颜色的字符串
+ (NSAttributedString *)zjs_attributedTextWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    if (font) {
        [attributes setObject:font forKey:NSFontAttributeName];
    }
    if (textColor) {
        [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributedText;
}

#pragma mark 获取一个带中划线的字符串
+ (NSAttributedString *)zjs_attributedStrikethroughTextWithText:(NSString *)text lineColor:(UIColor *)lineColor
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:@(NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
    [attributes setObject:@0 forKey:NSBaselineOffsetAttributeName];
    if (lineColor) {
        [attributes setObject:lineColor forKey:NSStrikethroughColorAttributeName];
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributedText;
}

#pragma mark 获取一个带下划线的字符串
+ (NSAttributedString *)zjs_attributedUnderlineTextWithText:(NSString *)text lineColor:(UIColor *)lineColor
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:@(NSUnderlineStyleSingle) forKey:NSUnderlineStyleAttributeName];
    [attributes setObject:@0 forKey:NSBaselineOffsetAttributeName];
    if (lineColor) {
        [attributes setObject:lineColor forKey:NSUnderlineColorAttributeName];
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributedText;
}

#pragma mark 创建一个标准的下标数组
+ (NSArray *)zjs_indexsArrayWithCount:(NSUInteger)count
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        [array addObject:@(i)];
    }
    return array;
}

#pragma mark 随机一个指定位数的随机数字字符串
+ (NSString *)zjs_arc4randomNumStringWithCount:(NSUInteger)count
{
    NSString *targetString = kZJS_NoneString;
    if (!count) {
        return targetString;
    }
    for (int i=0; i<count; i++) {
        int temp = arc4random() % 10;
        targetString = [targetString stringByAppendingString:[NSString stringWithFormat:@"%d", temp]];
    }
    return targetString;
}

#pragma mark 随机一个指定位数的随机数字字符串（不含0）
+ (NSString *)zjs_arc4randomNumExceptZeroStringWithCount:(NSUInteger)count
{
    NSString *targetString = kZJS_NoneString;
    if (!count) {
        return targetString;
    }
    for (int i=0; i<count; i++) {
        int temp = (arc4random() % 9) + 1;
        targetString = [targetString stringByAppendingString:[NSString stringWithFormat:@"%d", temp]];
    }
    return targetString;
}

#pragma mark 随机一个指定位数的随机字符串（数字和字母组合）
+ (NSString *)zjs_arc4randomStringWithCount:(NSUInteger)count
{
    NSString *targetString = kZJS_NoneString;
    if (!count) {
        return targetString;
    }
    for (int i=0; i<count; i++) {
        int num = arc4random() % 62;
        if (num < 10) {
            int figure = arc4random() % 10;
            targetString = [targetString stringByAppendingString:[NSString stringWithFormat:@"%d", figure]];
        } else if (num < 36) {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            targetString = [targetString stringByAppendingString:[NSString stringWithFormat:@"%c", character]];
        } else {
            int figure = (arc4random() % 26) + 65;
            char character = figure;
            targetString = [targetString stringByAppendingString:[NSString stringWithFormat:@"%c", character]];
        }
    }
    return targetString;
}

#pragma mark 将indexPath转化成字符串key
+ (NSString *)zjs_indexPathStringKey:(NSIndexPath *)indexPath
{
    if (indexPath) {
        return NSStringFromCGPoint(CGPointMake(indexPath.section, indexPath.row));
    }
    return kZJS_NoneString;
}

#pragma mark 拨打电话
+ (UIWebView *)zjs_callSomeoneWithPhoneNumber:(NSString *)phoneNumber
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", @"tel:", phoneNumber];
    NSURL *url = [NSURL URLWithString:urlString];
    UIWebView *callWebView = [UIWebView new];
    [callWebView loadRequest:[NSURLRequest requestWithURL:url]];
    return callWebView;
}

#pragma mark 获取App版本号
+ (NSString *)zjs_getAppVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *shortVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return shortVersion;
}

#pragma mark 获取App版本号和build号
+ (NSString *)zjs_getAppVersionAppendBuildVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *shortVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSString *buildVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSString *currentVersion = [NSString stringWithFormat:@"%@.%@", shortVersion, buildVersion];
    return currentVersion;
}

#pragma mark - 将字典序列化为请求字符串
+ (NSString *)zjs_serializeToStringWithDic:(NSDictionary *)dic
{
    NSString *targetString = kZJS_NoneString;
    if (!dic || !dic.allKeys.count) {
        return targetString;
    }
    NSMutableArray *serializedKeyArray = [NSMutableArray arrayWithArray:dic.allKeys];
    [serializedKeyArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *key1 = obj1;
        NSString *key2 = obj2;
        return [key1 compare:key2];
    }];
    NSMutableArray *componentsArray = [NSMutableArray array];
    for (NSString *key in serializedKeyArray) {
        id value = dic[key];
        if (key.length && [value isKindOfClass:[NSString class]] && [value length]) {
            [componentsArray addObject:[NSString stringWithFormat:@"%@%@%@", key, kZJS_Symbol_Equal, value]];
        }
    }
    if (!componentsArray.count) {
        return targetString;
    }
    targetString = [componentsArray componentsJoinedByString:kZJS_Symbol_Link];
    return targetString;
}

#pragma mark - 将请求字符串反序列化为字典
+ (NSDictionary *)zjs_deserializeToDicWithString:(NSString *)string
{
    NSMutableDictionary *targetDic = [NSMutableDictionary dictionary];
    if (!string || !string.length || ![string containsString:kZJS_Symbol_Equal]) {
        return targetDic;
    }
    NSArray *componentsArray = [string componentsSeparatedByString:kZJS_Symbol_Link];
    if (!componentsArray || !componentsArray.count) {
        return targetDic;
    }
    for (NSString *component in componentsArray) {
        if (component && component.length && [component containsString:kZJS_Symbol_Equal]) {
            NSArray *tempArray = [component componentsSeparatedByString:kZJS_Symbol_Equal];
            if (tempArray.count == 2 && [tempArray.firstObject length] && [tempArray.lastObject length]) {
                // value中不包含=
                [targetDic setObject:tempArray.lastObject forKey:tempArray.firstObject];
            } else if (tempArray.count > 2) {
                // value中包含=
                NSMutableArray *valueArray = [NSMutableArray arrayWithArray:tempArray];
                [valueArray removeObjectAtIndex:0];
                NSString *value = [valueArray componentsJoinedByString:kZJS_Symbol_Equal];
                if ([tempArray.firstObject length] && value && value.length) {
                    [targetDic setObject:value forKey:tempArray.firstObject];
                }
            }
        }
    }
    return targetDic;
}

#pragma mark 封装UIAlertController（8.0及以上）
+ (void)zjs_showAlertControllerWithPresentingVC:(UIViewController *)presentingVC preferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message alertActions:(NSArray<UIAlertAction *> *)alertActions presentCompletion:(void (^)(void))presentCompletion
{
    // 安全判断
    if (!presentingVC || !alertActions || !alertActions.count) {
        return;
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    for (UIAlertAction *alertAction in alertActions) {
        [alertVC addAction:alertAction];
    }
    [presentingVC presentViewController:alertVC animated:YES completion:presentCompletion];
}

#pragma mark 正则判断文本是否包含中文
+ (BOOL)zjs_predicateIfContainsChineseWithText:(NSString *)text
{
    // 安全判断
    if (!text.length) {
        return NO;
    }
    NSString *regEx = @"^.*[\u4e00-\u9fa5].*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [predicate evaluateWithObject:text];
}

#pragma mark 正则判断文本是否是纯中文
+ (BOOL)zjs_predicateIfPureChineseWithText:(NSString *)text
{
    // 安全判断
    if (!text.length) {
        return NO;
    }
    NSString *regEx = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [predicate evaluateWithObject:text];
}

@end
