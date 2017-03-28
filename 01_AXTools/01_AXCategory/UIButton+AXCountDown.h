//
//  UIButton+AXCountDown.h
//  BigApple
//
//  Created by Mole Developer on 2017/3/27.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AXCountDown)

/**
 短信倒计时事件,不需要主动调用开始

 @param second 时长
 @param condition 条件
 @param events 事件
 */
- (void)ax_messageWithSecond:(NSInteger)second condition:(BOOL (^)())condition events:(void(^)(UIButton *button))events;
/**
 * 开始倒计时,正常情况下,不需要调用
 */
-(void)ax_beginCountDown;
/**
 * 停止倒计时,正常情况下,不需要调用
 */
-(void)ax_stopCountDown;

@end
