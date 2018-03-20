//
//  UIButton+Add.h
//  TreeMenu
//
//  Created by Allen on 2018/3/19.
//  Copyright © 2018年 Cpsdna. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImageDirection) {
    ImageDirectionTop,
    ImageDirectionLeft,
    ImageDirectionBottom,
    ImageDirectionRight,
    ImageDirectionCenter
};

@interface UIButton (Add)
-(void)setImageDirection:(ImageDirection)direction withSpan:(float)span;

@end
