//
//  UIButton+Add.m
//  TreeMenu
//
//  Created by Allen on 2018/3/19.
//  Copyright © 2018年 Cpsdna. All rights reserved.
//

#import "UIButton+Add.h"

@implementation UIButton (Add)
-(void)setImageDirection:(ImageDirection)direction withSpan:(float)span
{
    UIImage *image = self.imageView.image;
    if(image){
        float imageWidth = image.size.width;
        float imageHeight = image.size.height;
        float titleWidth = self.titleLabel.bounds.size.width;
        float titleHeight = self.titleLabel.bounds.size.height;
        if(imageWidth == 0 || imageHeight == 0 || titleWidth == 0 || titleHeight == 0){
            return;
        }
        
        // UIEdgeInsetsMake  top left bottom right
        switch (direction) {
            case ImageDirectionTop:
                [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,titleHeight + (span/2),-titleWidth)];
                [self setTitleEdgeInsets:UIEdgeInsetsMake( imageHeight + (span/2),-imageWidth, 0.0,0.0)];
                break;
            case ImageDirectionLeft:
                [self setImageEdgeInsets:UIEdgeInsetsMake(0.0,0.0,0.0,span/2)];
                [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0,span/2,0.0,0.0)];
                break;
            case ImageDirectionRight:
                [self setImageEdgeInsets:UIEdgeInsetsMake(0.0,0.0,0.0,-titleWidth*2 - (span/2))];
                [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0,-imageWidth*2-(span/2),0.0,0.0)];
                break;
            case ImageDirectionBottom:
                [self setImageEdgeInsets:UIEdgeInsetsMake(titleHeight + (span/2),0.0,0.0,-titleWidth)];
                [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0,-imageWidth,imageHeight + (span/2),0.0)];
                break;
            case ImageDirectionCenter:
                [self setImageEdgeInsets:UIEdgeInsetsMake(0.0,0.0,0.0,-titleWidth)];
                [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0,-imageWidth,0.0,0.0)];
                break;
            default:
                break;
        }
    }
}
@end
