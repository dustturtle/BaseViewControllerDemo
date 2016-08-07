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
    self.title = GLOBAL_STR(@"欢迎拥抱STUQ!");
}


- (IBAction)changeToChinese:(id)sender
{
    [WQLanguage selectLanguage:WQLanguageCodes[0]];
    [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChangedNotification
                                                        object:nil];
}

- (IBAction)changeToEnglish:(id)sender
{
    [WQLanguage selectLanguage:WQLanguageCodes[1]];
    [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChangedNotification
                                                        object:nil];
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
    [self showHUDWithText:GLOBAL_STR(@"加载中")];
    
}

- (IBAction)stopLoading:(id)sender
{
    [self hideHUDWithText:GLOBAL_STR(@"加载结束")];
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
    
    self.title = GLOBAL_STR(@"欢迎拥抱STUQ!");
    
    [self.switchToChinese setTitle:GLOBAL_STR(@"切换到中文") forState:UIControlStateNormal];
    [self.switchToEnglish setTitle:GLOBAL_STR(@"切换到英文") forState:UIControlStateNormal];
    [self.kickOut setTitle:GLOBAL_STR(@"模拟被T出通知") forState:UIControlStateNormal];
    [self.whiteTheme setTitle:GLOBAL_STR(@"白色主题") forState:UIControlStateNormal];
    [self.colorTheme setTitle:GLOBAL_STR(@"彩色主题") forState:UIControlStateNormal];
    [self.startHud setTitle:GLOBAL_STR(@"开启Hud") forState:UIControlStateNormal];
    [self.stopHud setTitle:GLOBAL_STR(@"停止Hud") forState:UIControlStateNormal];
}

@end
