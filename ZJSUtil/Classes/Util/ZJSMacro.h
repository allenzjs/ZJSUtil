//
//  ZJSMacro.h
//  Pods
//
//  Created by 查俊松 on 2018/9/13.
//

#ifndef ZJSMacro_h
#define ZJSMacro_h

//常用符号宏
#define kZJS_Symbol_Comma @","
#define kZJS_Symbol_Pause @"、"
#define kZJS_Symbol_Dot @"."
#define kZJS_Symbol_Query @"?"
#define kZJS_Symbol_Plus @"+"
#define kZJS_Symbol_Minus @"-"
#define kZJS_Symbol_Equal @"="
#define kZJS_Symbol_Slash @"/"
#define kZJS_Symbol_BackSlash @"\\"
#define kZJS_Symbol_Colon @":"
#define kZJS_Symbol_Percent @"%"
#define kZJS_Symbol_Link @"&"
#define kZJS_Symbol_JH @"#"
#define kZJS_Symbol_RMB @"￥"

//常用字符串宏
#define kZJS_NoneData @"--"
#define kZJS_NoneString @""
#define kZJS_Space @" "
#define kZJS_DoubleSpace @"  "
#define kZJS_BoolString_YES @"true"
#define kZJS_BoolString_NO @"false"

//常用宏
#define kZJS_App ([UIApplication sharedApplication])
#define kZJS_AppDelegate (kZJS_App.delegate)
#define kZJS_AppWindow (kZJS_AppDelegate.window)
#define kZJS_KeyWindow (kZJS_App.keyWindow)
#define kZJS_AppVersionString ([NSObject zjs_getAppVersion])
#define kZJS_CurrentVC ([UIViewController zjs_currentVC])
#define kZJS_SafeString(string, defaultString) (string.length ? string : defaultString)
#define kZJS_IfNoneData(string) kZJS_SafeString(string, kZJS_NoneData)
#define kZJS_IfNoneString(string) kZJS_SafeString(string, kZJS_NoneString)
#define kZJS_IfNoneNumber(number) (number ? number : @0)

//时间
#define kZJS_ScaleBetweenSecondAndMillisecond 1000
#define kZJS_OneMinuteTimeInterval 60
#define kZJS_OneHourTimeInterval (60*kZJS_OneMinuteTimeInterval)
#define kZJS_OneDayTimeInterval (24*kZJS_OneHourTimeInterval)
#define kZJS_OneWeekTimeInterval (7*kZJS_OneDayTimeInterval)

//判断系统版本号
#define kZJS_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define kZJS_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define kZJS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define kZJS_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define kZJS_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//屏幕相关
#define kZJS_ScreenWidth                ([UIScreen mainScreen].bounds.size.width)
#define kZJS_ScreenHeight               ([UIScreen mainScreen].bounds.size.height)
#define kZJS_ScreenWidthRatio           (kZJS_ScreenWidth / 375.f)
#define kZJS_ScreenHeightRatio          (kZJS_ScreenHeight / 667.f)
#define kZJS_Screen_Small               (kZJS_ScreenWidthRatio < 1.f)
#define kZJS_Screen_Normal              (kZJS_ScreenWidthRatio == 1.f)
#define kZJS_Screen_Big                 (kZJS_ScreenWidthRatio > 1.f)

#define kZJS_ScreenSafeAreaInsetsFunc()\
({\
UIEdgeInsets tmp;\
if (@available(iOS 11.0, *)) {\
UIEdgeInsets temp = [UIApplication sharedApplication].delegate.window.safeAreaInsets;\
tmp = temp.bottom ? temp : UIEdgeInsetsZero; }\
else {\
tmp = UIEdgeInsetsZero; }\
tmp;\
})\

#define kZJS_ScreenSafeAreaInsets kZJS_ScreenSafeAreaInsetsFunc()
#define kZJS_ScreenSafeAreaInsets_Abnormal (!UIEdgeInsetsEqualToEdgeInsets(kZJS_ScreenSafeAreaInsets, UIEdgeInsetsZero))
#define kZJS_NavigationBar_Height 44.f
#define kZJS_TabBar_Height 49.f
#define kZJS_StatusBar_Height (kZJS_ScreenSafeAreaInsets_Abnormal ? 44.f : 20.f)
#define kZJS_TopSafe_Margin (kZJS_ScreenSafeAreaInsets_Abnormal ? 44.f : 0.f)
#define kZJS_BottomSafe_Margin (kZJS_ScreenSafeAreaInsets_Abnormal ? 34.f : 0.f)
#define kZJS_TopBar_Height (kZJS_NavigationBar_Height+kZJS_StatusBar_Height)
#define kZJS_BottomBar_Height (kZJS_TabBar_Height+kZJS_BottomSafe_Margin)

//颜色
#define kZJS_Hex(_HexString_) [UIColor zjs_colorWithHexString:_HexString_]
#define kZJS_HexAlpha(_HexString_,_Alpha_) [UIColor zjs_colorWithHexString:_HexString_ alpha:_Alpha_]
#define kZJS_RGB(_R_,_G_,_B_) [UIColor zjs_colorWithR:_R_ g:_G_ b:_B_]
#define kZJS_RGBA(_R_,_G_,_B_,_A_) [UIColor zjs_colorWithR:_R_ g:_G_ b:_B_ a:_A_]
#define kZJS_RandomColor [UIColor zjs_randomColor]

//字体
#define kZJS_Font(_Size_) [UIFont systemFontOfSize:_Size_]
#define kZJS_BoldFont(_Size_) [UIFont boldSystemFontOfSize:_Size_]
#define kZJS_WeightFont(_Size_,_Weight_) [UIFont systemFontOfSize:_Size_ weight:_Weight_]
#define kZJS_SpecFont(_Name_,_Size_) [UIFont fontWithName:_Name_ size:_Size_]

//图片
#define kZJS_Image(_Name_,_Bundle_) [UIImage imageNamed:_Name_ inBundle:_Bundle_ compatibleWithTraitCollection:nil]

/**
 *  解析JSON字典时可能会出现Null，使用该宏定义将其转换为安全的nil
 *
 *  @param value 字典的value
 *
 *  @return 安全的返回值
 */
#define kZJS_NullSafe(value)\
({\
id tmp;\
if ([value isKindOfClass:[NSNull class]]) {\
tmp = nil; }\
else {\
tmp = value; }\
tmp;\
})\

/**
 *  向NSDictionary类型变量插入键值时可能出现值为nil而引起崩溃的问题，使用该宏定义将其转换为安全的[NSNull null]插入
 *
 *  @param object 待插入字典的值
 *
 *  @return 可以安全插入字典的值
 */
#define kZJS_ObjectOrNull(object)\
({\
id value;\
value = object ?: [NSNull null];\
value;\
})\

/**
 *  强弱引用
 */
#ifndef zjs_weakify
#if DEBUG
#if __has_feature(objc_arc)
#define zjs_weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define zjs_weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define zjs_weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define zjs_weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef zjs_strongify
#if DEBUG
#if __has_feature(objc_arc)
#define zjs_strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define zjs_strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define zjs_strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define zjs_strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

/**
 *  自定义Log（提供两种模式，默认只在DEBUG下输出日志）
 */
#define kZJS_LogMode_Always 0
#define kZJS_LogMode_Debug 1
#define kZJS_LogMode kZJS_LogMode_Debug
#define _kZJS_Log(...) fprintf(stderr, "%s 第%d行\n%s\n\n", __func__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#if kZJS_LogMode
#ifdef DEBUG  //调试阶段
#define kZJS_Log(...) _kZJS_Log(__VA_ARGS__)
#else  //发布阶段
#define kZJS_Log(...)
#endif
#else
#define kZJS_Log(...) _kZJS_Log(__VA_ARGS__)
#endif

#endif /* ZJSMacro_h */
