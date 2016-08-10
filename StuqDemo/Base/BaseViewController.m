//
//  BaseViewController.m
//  StuqDemo
//
//  Created by achen on 16/7/30.
//  Copyright © 2016年 achen. All rights reserved.
//

#import "BaseViewController.h"
#import "LocalConnection.h"
#import "MBProgressHUD.h"


@interface BaseViewController ()
@property (nonatomic, strong) MBProgressHUD *innerHUD;

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //  4. 应用内国际化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(languageChanged:)
                                                 name:LanguageChangedNotification
                                               object:nil];
    
    //  7. 应用主题设置
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(themeChanged:)
                                                 name:ThemeChangedNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *themeString = [[NSUserDefaults standardUserDefaults] stringForKey:@"Theme"];
    if ([themeString length] > 0)
    {
        [self reloadUIForTheme:[themeString integerValue]];
    }
    
    // 这里的麻烦之处在于IB的国际化；我们并未生成2个不同的IB文件，因此需要刷新一些值的内容；所以在这里有这个方法调用。
    [self reloadUIForGlobal];
    // 5. 页面打点 TODO:引入mobclick相关的库
    //[MobClick beginLogPageView:NSStringFromClass([self class])];
    
    // fixing the rotate bugs, ios7 & ios 8  ok!
    // 页面进入时也要根据屏幕方向调整相关布局。
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (currentOrientation == UIInterfaceOrientationLandscapeLeft || currentOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [self changeConstraintsToLandscape:currentOrientation];
    }
    else
    {
        [self changeConstraintsToPortrait:currentOrientation];
    }
    
    BOOL isNetworkAvailable = [GLocalConnection isReachable];
    if (!isNetworkAvailable)
    {
        // 页面进入时若网络不可用则也触发此方法。
        [self handleNetworkStatus:isNetworkAvailable];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kLocalConnectionChangedNotification
                                               object:nil];
    
    //  6. 处理全局的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(forceLogout:)
                                                 name:ForceLogoutNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 5. 页面打点
    //[MobClick endLogPageView:NSStringFromClass([self class])];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kLocalConnectionChangedNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:ForceLogoutNotification
                                                  object:nil];
    
    // 页面退出时隐藏HUD
    [MBProgressHUD hideHUDForView:self.view animated:NO];
}


#pragma mark - 可被调用的方法
//  3. 便捷调用HUD
- (void)showHUD
{
    if (self.innerHUD == nil)
    {
        self.innerHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.innerHUD.userInteractionEnabled = NO;
        self.innerHUD.mode = MBProgressHUDModeCustomView;
    }
}

- (void)showHUDWithText:(NSString *)text
{
    [self showHUD];
    self.innerHUD.label.text = text;
}

- (void)hideHUD
{
    [self.innerHUD hideAnimated:NO];
    self.innerHUD = nil;
}

- (void)hideHUDWithText:(NSString *)text
{
    self.innerHUD.label.text = text;
    [self.innerHUD hideAnimated:NO afterDelay:1.0f];
    self.innerHUD = nil;
}

#pragma mark - 子类实现的方法（不能直接调用）

// disable this method.  use willRotateToInterfaceOrientation in both ios7 & ios8.
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
//{
//    //DDLogInfo(@"BaseViewController viewWillTransitionToSize");
//    
//    if (size.width == LANDSCAPE_SCREEN_WIDTH)
//    {
//        [self changeConstraintsToLandscape];
//    }
//    else
//    {
//        [self changeConstraintsToPortrait];
//    }
//}

// implement this method to support ios7 either.
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [self changeConstraintsToLandscape:toInterfaceOrientation];
    }
    else
    {
        [self changeConstraintsToPortrait:toInterfaceOrientation];
    }
}

- (void)networkChanged:(NSNotification *)notification
{
    LocalConnection *lc = (LocalConnection *)notification.object;
    BOOL isNetworkAvailable = [lc isReachable];
    
    [self handleNetworkStatus:isNetworkAvailable];
}

- (void)languageChanged:(NSNotification *)notification
{
    [self reloadUIForGlobal];
}

- (void)themeChanged:(NSNotification *)notification
{
    CustomThemeType themeType = [notification.object integerValue];
    [self reloadUIForTheme:themeType];
}

- (void)forceLogout:(NSNotification *)notification
{
    [self backToLogin];
}

//  1. 处理网络状态变化
- (void)handleNetworkStatus:(BOOL)isAvailable
{
    // virtual, for subclass override
}

- (void)reloadUIForGlobal NS_REQUIRES_SUPER
{
   // 基类若存在需要国际化的UI部分，可以在此处处理。
}

- (void)reloadUIForTheme:(CustomThemeType)theme NS_REQUIRES_SUPER
{
    // 基类若存在主题相关的UI部分，可以在此处处理。
}

//  2. 处理屏幕旋转 
- (void)changeConstraintsToLandscape:(UIInterfaceOrientation)orient
{
    // virtual, for subclass override
}

- (void)changeConstraintsToPortrait:(UIInterfaceOrientation)orient
{
    // virtual, for subclass override
}

- (void)backToLogin
{
    // !!!这里简单回到根页面。
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
