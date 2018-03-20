//
//  TreeMenu.h
//  TreeMenu
//
//  Created by Allen on 2018/3/19.
//  Copyright © 2018年 Cpsdna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PracticeCategory.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define is5_8Inches    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIOS_X(systemVersionfloatArgs) ([UIDevice currentDevice].systemVersion.floatValue >= (systemVersionfloatArgs) ? YES : NO)

#define NAVI_BAR_HEIGHT (is5_8Inches?88:(isIOS_X(7.0)?64:44))


@class TreeMenu;

@protocol TreeMenuDelegate<NSObject>

- (void)treeMenu:(TreeMenu *)treeMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface TreeMenu : UIView

@property (nonatomic, strong) UIColor *bgColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *menuBGColor;

@property (nonatomic, strong) UIFont *menuFont;

@property (nonatomic, strong) UIColor *menuColor;

@property (nonatomic, strong) UIFont *menuDetailFont;

@property (nonatomic, strong) UIColor *menuDetailColor;

@property (nonatomic, strong) UIColor *subMenuBGColor;

@property (nonatomic, strong) UIFont *subMenuFont;

@property (nonatomic, strong) UIColor *subMenuColor;

@property (nonatomic, strong) UIColor *subMenuDetailColor;

@property (nonatomic, strong) UIFont *subMenuDetailFont;

@property (nonatomic, weak) id<TreeMenuDelegate> delegate;



/**
 初始化

 @param frame 标题的frame
 @param superView 父view,弱引用
 @param categories 数据源
 @param delegate 代理
 */
- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView practiceCategories:(NSArray<PracticeCategory *> *)categories delegate:(id<TreeMenuDelegate>)delegate;

- (void)open;

- (void)close;

@end
