//
//  WQLanguage.h
//  Hodor
//
//  Created by achen on 16/7/22.
//  应用内切换国际化方案实现；
//  从Hodor修改而来。
//  Copyright © 2016年 aufree. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GLOBAL_STR(key) [WQLanguage globalString:key alter:nil]

#define WQLanguageCodes @[@"zh-Hans", @"en"] // 输入的语言key列表

@interface WQLanguage : NSObject

// 此方法在外部当且仅当程序启动时被调用；加载语言对应的bundle。
+ (void)setupBundle;

// 已封装成宏。不应该被直接调用，而是调用GLOBAL_STR(key)。
+ (NSString *)globalString:(NSString *)key alter:(NSString *)alternate;

// 手动切换语言时调用此方法。
// 返回NO表示无变更，返回YES表示变更了语言。
+ (BOOL)selectLanguage:(NSString *)language;

+ (NSUInteger)currentLanguageIndex;

@end
