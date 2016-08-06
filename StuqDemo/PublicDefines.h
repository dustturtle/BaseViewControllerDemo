//
//  PublicDefines.h
//  StuqDemo
//
//  Created by achen on 16/7/30.
//  Copyright © 2016年 achen. All rights reserved.
//

#ifndef PublicDefines_h
#define PublicDefines_h


typedef NS_ENUM(NSInteger, CustomThemeType){
    
    CustomThemeTypeWhite = 0,
    CustomThemeTypeColor = 1,
    CustomThemeTypeBlack = 2
};

static NSString * const ForceLogoutNotification = @"ForceLogoutNotification";

static NSString * const LanguageChangedNotification = @"LanguageChangedNotification";

static NSString * const ThemeChangedNotification = @"ThemeChangedNotification";


#endif /* PublicDefines_h */
