//
//  AXMacros.h
//  AXiOSKit
//
//  Created by liuweixing on 2017/1/3.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXMacros_runTime.h"
#import "AXMacros_addProperty.h"
#import "AXMacros_log.h"
#import "AXMacros_instance.h"
#import "AXMacros_value.h"

typedef void(^AxBlock)(void);


//import 不同类型
//#if __has_include(<YYWebImage/YYWebImage.h>)
//#import <YYWebImage/YYWebImage.h>
//#else
//#import "YYWebImage.h"
//#endif

/*
 过期宏 三种方式都是 第一种的宏
 
 __attribute__((deprecated(" ")));
 
 DEPRECATED_MSG_ATTRIBUTE ()
 
 DEPRECATED_ATTRIBUTE
 
 
 NS_UNAVAILABLE 当我们不想要其他开发人员，用普通的 init 方法去初始化一个类，我们可以在.h 文件里这样写：
 - (instancetype)init NS_UNAVAILABLE;
 
 NS_DESIGNATED_INITIALIZER 指定的初始化方法。当一个类提供多种初始化方法时，所有的初始化方法最终都会调用这个指定的初始化方法。比较常见的有：
 - (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
 
 */

//#define AX_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//
//#define AX_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


/**
 Class   alloc]init] 初始化

 @param Class Class
 @return 当前对象
 */
#define ax_Obj_init(Class) [[Class alloc]init]

/**
 * ax_kWeakObj(block 外面使用)
 */
#define axWeakObj(obj) __weak typeof(obj) obj##Weak = obj;

/**
 * StrongObj(block 里面使用)
 */
#define axStrongObj(obj) __strong typeof(obj) obj = obj##Weak;

/**
 * 弱引用 self
 */
#define axSelfWeak axWeakObj(self);

/**
 * 强引用 self
 */
#define axSelfStrong axStrongObj(self);


/***/

/**
 * ax_kWeakObj(block 外面使用)
 */
#define AX_WEAK_OBJ(obj) __weak typeof(obj) AxWeak##obj = obj;

/**
 * StrongObj(block 里面使用) obj = obj##Weak;
 */
#define AX_STRONG_OBJ(obj) __strong typeof(obj) obj = AxWeak##obj;

/**
 * 弱引用 self
 */
#define AX_WEAK_SELF AX_WEAK_OBJ(self);

/**
 * 强引用 self
 */
#define AX_STRONG_SELF AX_STRONG_OBJ(self);

/**
 * NSNotificationCenter
 */
#define axNotificationCenter [NSNotificationCenter defaultCenter]

/**
 * NSUserDefaults
 */
#define axUserDefaults [NSUserDefaults standardUserDefaults]

/**
 * NSUserDefaults synchronize
 */
#define axUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]

/**
 self.tableView.tableFooterView
 */
#define axTableFooterViewZero self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];


/**
 view 中 加载xib自定义view
 */
#define ax_load_xib_view \
self = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].lastObject;\
self.frame = frame;\

/**
 showHUD
 */
#define AX_showHUD_Message(String)  MBProgressHUD *hud = [MBProgressHUD ax_showMessage:String];
/**
 hideHUD 
 */
#define AX_hideHUD  [hud hideAnimated:YES];


/**
 * vc中定义一个同名的view替代原来的 aViewClass 需要替代的view
 */
#define AX_REDEFINE_CONTROLLER_VIEW_IMPL(aViewClass)\
@dynamic view;\
- (void)loadView{\
[super loadView];\
self.view = [[aViewClass alloc]init];\
}\
- (void)setView:(aViewClass *)view{\
[super setView:view];\
}\
- (aViewClass *)view{\
return (aViewClass *)[super view];\
}\

/**GCD 信号量创建*/
#define AX_LOCK_INIT dispatch_semaphore_t sem = dispatch_semaphore_create(0);
/**GCD 信号量发送*/
#define AX_UNLOCK dispatch_semaphore_signal(sem);
/**GCD 信号量等待*/
#define AX_LOCK dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);

#pragma mark - weakify

/**weakify*/
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#pragma mark - strongify

/**strongify*/
#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif



#pragma mark - ax_keypath
/**
 此处@keypath(TARGET, KEYPATH)一定要添加@符号，就是为了能预编译出TARGET中所有的KEYPATH属性。
 何为预编译？
 在main函数执行之前，执行预编译处理。把整个类加载进内存中，在编程过程中，会去匹配TARGET类的类型，当匹配到对应类之后，会去编译查找对应的属性表property list、成员表IRG list、方法表method list。所以这里执行了预编译处理后，就可以提示出TARGET所有的示例变量、属性以及方法。
 */

/**
 forKey
[self.view setValue:UIColor.redColor forKey:@ax_keypath(self.view, backgroundColor)];
 */
#define ax_keypath(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), # PATH))


#pragma mark - 懒加载

#ifndef PCH_LazyLoading
#define PCH_LazyLoading(_type_, _ivar_)        \
-(_type_*)_ivar_                           \
{                                          \
if (!_##_ivar_) {                      \
_##_ivar_ = [[_type_ alloc] init]; \
}                                      \
return _##_ivar_;                      \
}
#endif

#ifndef PCH_LazyLoadingBlock
#define PCH_LazyLoadingBlock(_type_, _ivar_, block)                   \
-(_type_*)_ivar_                                                  \
{                                                                 \
void (^initBlock)(_type_ * _ivar_) = ^(_type_ * _ivar_)block; \
if (!_##_ivar_) {                                             \
_type_* _ivar_ = [[_type_ alloc] init];                   \
_##_ivar_ = _ivar_;                                       \
initBlock(_ivar_);                                        \
}                                                             \
return _##_ivar_;                                             \
}
#endif