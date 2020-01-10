//
//  UIImage+tools.m
//  QCT
//
//  Created by zj on 2019/5/27.
//  Copyright © 2019 coder_zhao. All rights reserved.
//

#import "UIImage+tools.h"

@implementation UIImage (tools)

+ (UIImage *)qct_imageWithColor:(UIColor *)color {
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    return [self qct_imageWithColor:color frame:rect];
}

+ (UIImage *)qct_imageWithColor:(UIColor *)color frame:(CGRect)frame {
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    [color setFill];
    UIRectFill(frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
