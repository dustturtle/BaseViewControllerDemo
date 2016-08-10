//
//  BaseViewController.h
//  StuqDemo
//  这里在实际使用时建议加上工程的前缀（因OC统一命名空间问题，避免重复）
//  这里头部暴露的方法分两类，一类是可以被调用的方法；
//  一类是生命周期方法(用法类似viewDidLoad这种)，子类只需要实现之。
//  查看UIViewController的头文件也可以发现这种情况。
//
//  当前功能列表:
//  1. 处理网络状态变化
//  2. 处理屏幕旋转 （iPad应用中非常有用）
//  3. 便捷调用HUD
//  4. 应用内国际化
//  5. 页面留存打点 （比如UMENG）
//  6. 处理全局的通知，比如账号被T出（当前处在任意的页面，这种情况一般都是从server端收到的通知），自动退回到登陆页
//  7. 应用主题设置，全局修改主题（这里用背景色做演示）
//
//  宗旨：全局性viewcontroller可以共有的且应该属于viewcontroller处理范畴内的任务，放到基类来做。
//
//  其他适合放到基类的任务举例：
//  TODO: router方案：自动注册基类，处理url跳转等。 （此处内容较多，demo未实现）
//  参考：UMViewController，https://github.com/gaosboy/urlmanager
//
//  Created by achen on 16/7/30.
//  Copyright © 2016年 achen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefines.h"
#import "UIView+Toast.h"
#import "WQLanguage.h"

@interface BaseViewController : UIViewController

#pragma mark - 可被调用的方法
- (void)showHUD;

- (void)showHUDWithText:(NSString *)text;

- (void)hideHUD;

- (void)hideHUDWithText:(NSString *)text;


#pragma mark - 子类实现的方法（不能直接调用）

// 若需要子类调用super的方法，可以在后面加上NS_REQUIRES_SUPER
// 例：- (void)foo NS_REQUIRES_SUPER;

// virtual, for subclass override
- (void)changeConstraintsToLandscape:(UIInterfaceOrientation)orient;
// virtual, for subclass override
- (void)changeConstraintsToPortrait:(UIInterfaceOrientation)orient;
// virtual, for subclass override
- (void)handleNetworkStatus:(BOOL)isAvailable;

- (void)reloadUIForGlobal NS_REQUIRES_SUPER;

- (void)reloadUIForTheme:(CustomThemeType)theme NS_REQUIRES_SUPER;

// 子类可以不重写此方法（默认行为退回到login页）。
- (void)backToLogin;

@end
