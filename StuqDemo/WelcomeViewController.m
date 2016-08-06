//
//  WelcomeViewController.m
//  StuqDemo
//
//  Created by achen on 16/8/6.
//  Copyright © 2016年 achen. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *switchToChinese;
@property (weak, nonatomic) IBOutlet UIButton *switchToEnglish;
@property (weak, nonatomic) IBOutlet UIButton *whiteTheme;
@property (weak, nonatomic) IBOutlet UIButton *colorTheme;
@property (weak, nonatomic) IBOutlet UIButton *kickOut;
@property (weak, nonatomic) IBOutlet UIButton *startHud;
@property (weak, nonatomic) IBOutlet UIButton *stopHud;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"欢迎拥抱STUQ!";
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    
}


- (IBAction)changeToChinese:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChangedNotification
                                                        object:WQLanguageCodes[0]];
}

- (IBAction)changeToEnglish:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChangedNotification
                                                        object:WQLanguageCodes[1]];
}

- (IBAction)postKickOut:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ForceLogoutNotification object:nil];
}

- (IBAction)whiteTheme:(id)sender
{
    NSString *themeString = [NSString stringWithFormat:@"%@", @(CustomThemeTypeWhite)];
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeChangedNotification object:themeString];
}

- (IBAction)colorTheme:(id)sender
{
    NSString *themeString = [NSString stringWithFormat:@"%@", @(CustomThemeTypeColor)];
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeChangedNotification object:themeString];
}

- (IBAction)startLoading:(id)sender
{
    [self showHUDWithText:@"加载中"];
    
}

- (IBAction)stopLoading:(id)sender
{
    [self hideHUDWithText:@"加载结束"];
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
    
    [self.switchToChinese setTitle:GLOBAL_STR(@"切换到中文") forState:UIControlStateNormal];
}

@end
