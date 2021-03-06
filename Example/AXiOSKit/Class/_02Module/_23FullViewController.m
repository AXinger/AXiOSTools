//
//  _23FullViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/27.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_23FullViewController.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>


@interface _23FullViewController ()

@end

@implementation _23FullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ax_status_bar_height = %lf",ax_status_bar_height());
    NSLog(@"ax_navigation_and_status_height = %lf",ax_navigation_and_status_height());
    NSLog(@"ax_safe_area_insets = %@   %lf",NSStringFromUIEdgeInsets(ax_safe_area_insets()),UIApplication.sharedApplication.statusBarFrame.size.height);
    //    self.AXListener.hiddenNavigationBar = YES;
    
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        CGFloat   statusBarHeight = statusBarManager.statusBarFrame.size.height;
        NSLog(@"statusBarHeight %lf",statusBarHeight);
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - 隐藏状态条
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
