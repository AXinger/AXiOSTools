//
//  NSMutableArray+AXSafe.m
//  AXiOSTools
//
//  Created by liuweixing on 2017/2/22.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import "NSMutableArray+AXSafe.h"
#import <objc/runtime.h>
@implementation NSMutableArray (AXSafe)

+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
 
        Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
        Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(catch_objectAtIndex:));
        method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
        
    });
}

- (id)catch_objectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self catch_objectAtIndex:index];
        } @catch (NSException *exception) {
            //__throwOutException  抛出异常
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self catch_objectAtIndex:index];
    }
}

@end
