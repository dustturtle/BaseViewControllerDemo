//
//  LoginViewController.m
//  StuqDemo
//
//  Created by GuanZhenwei on 16/7/31.
//  Copyright © 2016年 achen. All rights reserved.
//

#import "LoginViewController.h"
#import "WelcomeViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginYRelation;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginXRetion;

@property (weak, nonatomic) IBOutlet UITextField *accountInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = GLOBAL_STR(@"返回");
    
    self.navigationItem.backBarButtonItem = backItem;
    self.title = GLOBAL_STR(@"登录");
    
    [self.accountInput becomeFirstResponder];
}

- (IBAction)login:(id)sender
{
    if ([self.accountInput.text isEqualToString:@"stuq"] && [self.passwordInput.text isEqualToString:@"stuq"])
    {
        // 登陆成功
        WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] init];
        [self.navigationController pushViewController:welcomeVC animated:YES];
    }
    else
    {
        // 登陆失败
        [self.view makeToast:GLOBAL_STR(@"登陆失败，请检查输入")];
        
    }
}

// 演示旋转屏的处理。
- (void)changeConstraintsToPortrait:(UIInterfaceOrientation)orient
{
    self.topDistance.constant = 107.0f;
    self.loginXRetion.constant = 0.0f;
    self.loginYRelation.constant = 0.0f;
}


- (void)changeConstraintsToLandscape:(UIInterfaceOrientation)orient
{
    self.topDistance.constant = 50.0f;
    self.loginXRetion.constant = 100.0f;
    self.loginYRelation.constant = -50.0f;
}

// 演示网络变化的处理
- (void)handleNetworkStatus:(BOOL)isAvailable
{
    if (!isAvailable)
    {
        [self.view makeToast:GLOBAL_STR(@"网络连接断开")];
    }
    else
    {
        [self.view makeToast:GLOBAL_STR(@"网络连接恢复")];
    }
}

// 演示更换主题的处理
- (void)reloadUIForTheme:(CustomThemeType)theme
{
    [super reloadUIForTheme:theme];
    
    if (theme == CustomThemeTypeWhite)
    {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    else if (theme == CustomThemeTypeColor)
    {
        self.view.backgroundColor = [UIColor purpleColor];
    }
}

// 演示国际化
- (void)reloadUIForGlobal
{
    [super reloadUIForGlobal];
    
    self.accountLabel.text = GLOBAL_STR(@"账号");
    self.passwordLabel.text = GLOBAL_STR(@"密码");
    
    [self.loginBtn setTitle:GLOBAL_STR(@"登录") forState:UIControlStateNormal];
    
}

@end
