//
//  _01ContentViewController.m
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2020/9/19.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import "_01ContentViewController.h"

#import <AXiOSKit/AXBiometryManager.h>
#import <AXiOSKit/AXLocationManager.h>
#import <AXiOSKit/AXiOSKit.h>
#import <AuthenticationServices/AuthenticationServices.h>
#import <Canvas/Canvas.h>
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <UserNotifications/UserNotifications.h>

@interface _01ContentViewController ()<UITextViewDelegate>

@property(nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) MASConstraint *viewBottomConstraint;

@property(nonatomic, strong) AXBiometryManager *manager;

@property(nonatomic, strong) UIPageControl *pageControl;

@property(nonatomic, strong) AXLocationManager *locationManager;

@property(nonatomic, assign) NSInteger age;

@end

@implementation _01ContentViewController
- (void)injected {
    NSLog(@"重启了 InjectionIII: %@", self);
    [self viewDidLoad];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"02";
    self.view.backgroundColor = [UIColor ax_colorWithNormalStyle:UIColor.whiteColor];
    
    // self.locationManager =   [AXLocationManager managerWithState:AXLocationStateWhenInUseAuthorization result:^(BOOL resultState, CLLocation *location) {
    //
    //        [self _WiFi];
    //    }];
    //    [self _WiFi];
    //    [self _UITextView_link];
    
    //    [self _kvoInt];
    
    
    //    [self _bottomView];
    
    UIScrollView *scrollView = [UIScrollView.alloc init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 2.给scrollView添加一个containerView
    UIView *containerView = [UIView.alloc init];
    containerView.backgroundColor = UIColor.whiteColor;
    self.containerView = containerView;
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView); // 需要设置宽度和scrollview宽度一样
    }];
    
    UIView *topView = containerView;
//    topView =  [self _01loginTest:topView];
    topView =  [self _01UITextView_link:topView];
    topView =  [self _02AlternateIconName:topView];
    topView =  [self _03textToImg:topView];
    topView =  [self _04masron_uninstall:topView];
    topView =  [self _05DateVC:topView];
    topView =  [self _06per:topView];
    topView =  [self _07bubbleImage:topView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView.mas_bottom).mas_equalTo(100);// 这里放最后一个view的底部
    }];
    
}


-(UIView *)_00ButtonTopView:(UIView *)topView title:(NSString *)title handler:(void(^)(void))handler {
    if (title.length==0) {
        title = @"title";
    }
    UIButton *btn = [[UIButton alloc] init];
    [self.containerView addSubview:btn];
    btn.backgroundColor = UIColor.blueColor;
    [btn ax_setTitleStateNormal:title];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    /// 按钮事件
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        if (handler) {
            handler();
        }
    }];
    topView =btn;
    return topView;
}

-(void)_bottomView {
    
    UIView *bottomView = [UIView ax_init];
    [self.containerView addSubview:bottomView];
    bottomView.backgroundColor = UIColor.orangeColor;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50+ax_safe_area_insets_bottom_offset(0));
        make.bottom.mas_equalTo(-ax_safe_area_insets_bottom_zero_offset(10));
    }];
    
    UIView *subView = [UIView ax_init];
    [bottomView addSubview:subView];
    subView.backgroundColor = UIColor.greenColor;
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        //        make.bottom.mas_equalTo(-ax_safe_area_insets_bottom_offset(10));
        make.height.mas_equalTo(50);
    }];
}

//- (NSString *)application:(NSString *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
//    NSLog(@"name %@ %@",application,launchOptions);
//
//    return @"aaa";
//}
//-(void)test:(NSString *)name age:(NSString *)age age2:(NSString *)age2{
//    NSLog(@"name %@ %@",name,age);
//}


-(void)_kvoInt{
    
    __weak typeof(self) weakSelf = self;
    [RACObserve(self, age) subscribeNext:^(id  _Nullable x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"age = %ld %@",strongSelf.age,x);
    }];
    
    [self ax_addFBKVOKeyPath:AX_FBKVOKeyPath(self.age) result:^(AXKVOResultModel * _Nonnull resultModel) {
        NSLog(@"age222 = %ld %@",self.age,resultModel.aNewValue);
    }];
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"kvoInt" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.orangeColor;
    [self.containerView addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        
    }];
    
    [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
        self.age = ax_randomZeroToValue(100);
        
    }];
}

-(UIView *)_01loginTest:(UIView *)topView {
    
    
    {
        UITextField *nameTF = [[UITextField alloc]init];
        nameTF.backgroundColor = UIColor.orangeColor;
        nameTF.placeholder = @"输入姓名";
        nameTF.accessibilityIdentifier = @"pwdTextField";
        [self.containerView addSubview:nameTF];
        [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView).mas_offset(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(50);
        }];
        topView = nameTF;
    }
    {
        UITextField *nameTF = [[UITextField alloc]init];
        nameTF.backgroundColor = UIColor.orangeColor;
        nameTF.placeholder = @"输入密码";
        nameTF.accessibilityIdentifier = @"nameTextField";
        [self.containerView addSubview:nameTF];
        [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom).mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(50);
        }];
        topView = nameTF;
    }
    
    return topView;
}

-(UIView *)_01UITextView_link:(UIView *)topView{
    
    NSString *str1 = @"点击“立即体验”按钮，\n即表示你同意";
    NSString *str3 = @"《许可及服务协议》";
    NSString *str = [NSString stringWithFormat:@"%@%@",str1,str3];
    NSRange range3 = [str rangeOfString:str3];
    
    NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range3];
    NSString *link = [[NSString stringWithFormat:@"license://%@",str3] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    /// 这里修改UITextView链接字体颜色无效
    [mastring addAttribute:NSLinkAttributeName value:link range:range3];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.editable = NO;
    textView. scrollEnabled= NO;
    textView.delegate = self;
    textView.attributedText = mastring;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.backgroundColor = UIColor.clearColor;
    /// 链接字体颜色
    textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor],NSUnderlineStyleAttributeName:@1};
    [self.containerView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).mas_offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    
    topView = textView;
    
    return topView;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    if ([[URL scheme] isEqualToString:@"license"]) {
        
        NSString *titleString = [NSString stringWithFormat:@"你点击了第一个文字:%@",[URL host]];
        
        NSLog(@"%@",titleString);
        
        return NO;
        
    }
    return YES;
    
}

-(UIView *)_02AlternateIconName:(UIView *)topView {
    
    __weak typeof(self) weakSelf = self;
    return [self _00ButtonTopView:topView title:@"换icon" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf setIconname:@"Alternate_AppIcon_2"];
    }];
    
}

- (void)setIconname:(NSString *)name {
    UIApplication *appli = [UIApplication sharedApplication];
    //判断系统是否支持切换icon
    if (@available(iOS 10.3, *)) {
        if ([appli supportsAlternateIcons]) {
            //切换icon
            [appli setAlternateIconName:name completionHandler:^(NSError * _Nullable error) {
                if (error) {
                    NSLog(@"error==> %@",error.localizedDescription);
                }else{
                    NSLog(@"done!!!");
                }
            }];
        }
    } else {
        // Fallback on earlier versions
    }
}
-(UIView *)_03textToImg:(UIView *)topView {
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    
    [self.containerView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(50);
    }];
    img.backgroundColor = UIColor.orangeColor;
    //    img.contentMode = UIViewContentModeCenter;
    //    img.image =   [UIImage imageFromText:@[@"jim"] withFont:20 withTextColor:UIColor.redColor withBgImage:nil withBgColor:UIColor.blueColor];
    img.contentMode = UIViewContentModeScaleAspectFill;
    img.image = [UIImage imageFromText:@[@"jim"]  withFont:100];
    
    return img;
}

-(UIView *)_04masron_uninstall:(UIView *)topView {
    
    CGFloat width = 100;
    
    UIView *view1 = [[UIView alloc]init];
    [self.containerView addSubview:view1];
    view1.backgroundColor = UIColor.orangeColor;
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(100);
        
        self.viewBottomConstraint = make.width.mas_equalTo(width);
    }];
    topView = view1;
    
    __weak typeof(self) weakSelf = self;
    topView = [self _00ButtonTopView:topView title:@"masron - uninstall" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.viewBottomConstraint uninstall];
        [view1.superview setNeedsUpdateConstraints];
        [UIView animateWithDuration:1 animations:^{
            [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-30);
            }];
            [view1.superview layoutIfNeeded];
        }];
    }];
    
    
    return topView;
}

-(UIView *)_05DateVC:(UIView *)topView {
    __weak typeof(self) weakSelf = self;
    return [self _00ButtonTopView:topView title:@"date" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        AXDateVC *vc = [[AXDateVC alloc]init];
        [strongSelf ax_showVC:vc];
    }];
}

-(UIView *)_06per:(UIView *)topView {
    
    __weak typeof(self) weakSelf = self;
    return [self _00ButtonTopView:topView title:@"奔溃拦截" handler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        //        [self performSelector:@selector(test:age:age2:) withObjects:@[@"JIM",@"20"]];
        //        id obj =[self performSelector:@selector(application:didFinishLaunchingWithOptions:) withObjects:@[@"JIM",@"20"]];
        //        NSLog(@"obj = %@",obj);
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:nil];
    }];
    
}

-(UIView *)_07bubbleImage:(UIView *)topView {
    //leftCapWidth: 左边不拉伸的像素
    //topCapHeight:上边不拉伸的像素
    UIImage *image = [UIImage imageNamed:@"chat_bubble"];
    UIImageView * imgView = [[UIImageView alloc] initWithImage:[image stretchableImageWithLeftCapWidth:30 topCapHeight:30]];
    
    [self.containerView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    
    return imgView;
}

-(void)_WiFi{
    
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dic = (NSDictionary *)info;
    NSString *ssid = [[dic objectForKey:@"SSID"] lowercaseString];
    NSString *bssid = [dic objectForKey:@"BSSID"];
    NSLog(@"ssid:%@ \nssid:%@",ssid,bssid);
    
    
    //    NSString *ssid = nil;
    //       NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    //       for (NSString *ifnam in ifs) {
    //           NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
    //           if (info[@"SSID"]) {
    //               ssid = info[@"SSID"];
    //           }
    //       }
    //    NSLog(@"sssid = %@",ssid);
    
    
}

-(void)_CSAnimationView{
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.orangeColor;
    [self.containerView addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        
    }];
    
    [btn1 ax_addTargetBlock:^(UIButton * _Nullable button) {
        
        CSAnimationView *animationView = [[CSAnimationView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        animationView.backgroundColor = [UIColor redColor];
        animationView.duration = 0.5;
        animationView.delay = 0;
        animationView.type = CSAnimationTypeFadeOutRight;
        [self.containerView addSubview:animationView];
        
        //添加你想增加效果的 View 为 animationView 的子视图
        // [animationView addSubview:<#(UIView *)#>]
        
        [animationView startCanvasAnimation];
        
    }];
}



//- (void)didMoveToParentViewController:(UIViewController *)parent {
//    [super didMoveToParentViewController:parent];
//    NSLog(@"didMoveToParentViewController %@  self = %@",parent,self);
//}

- (void)configUI{
    // 使用系统提供的按钮，要注意不支持系统版本的处理
    if (@available(iOS 13.0, *)) {
        // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeDefault style:ASAuthorizationAppleIDButtonStyleWhite];
        appleIDBtn.frame = CGRectMake(30, self.view.bounds.size.height - 180, self.view.bounds.size.width - 60, 100);
        //    appleBtn.cornerRadius = 22.f;
        [appleIDBtn addTarget:self action:@selector(didAppleIDBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:appleIDBtn];
    }
    
    // 或者自己用UIButton实现按钮样式
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(30, 80, self.view.bounds.size.width - 60, 44);
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn setTitle:@"Sign in with Apple" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(didCustomBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:addBtn];
}

// 自己用UIButton按钮调用处理授权的方法
- (void)didCustomBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    //    self.signInApple = [[SignInApple alloc] init];
    //    [self.signInApple handleAuthorizationAppleIDButtonPress];
    
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
        ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
        [request setRequestedScopes:@[ASAuthorizationScopeFullName,ASAuthorizationScopeEmail]];
    } else {
        // Fallback on earlier versions
    }
    
}
// 使用系统提供的按钮调用处理授权的方法
- (void)didAppleIDBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    //    self.signInApple = [[SignInApple alloc] init];
    //    [self.signInApple handleAuthorizationAppleIDButtonPress];
}

// 处理授权
- (void)handleAuthorizationAppleIDButtonPress{
    NSLog(@"////////");
    
    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 在用户授权期间请求的联系信息
        appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest]];
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
    }else{
        // 处理不支持系统版本
        NSLog(@"该系统版本不可用Apple登录");
    }
}


//- (void)removeFromParentViewController {
//    [super removeFromParentViewController];
//    AXLogFunc;
//}
//- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
//    [super popoverPresentationControllerDidDismissPopover:popoverPresentationController];
//    AXLogFunc;
//}
@end
