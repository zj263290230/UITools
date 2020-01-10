//
//  UIImage+tools.h
//  QCT
//
//  Created by zj on 2019/5/27.
//  Copyright © 2019 coder_zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (tools)

+ (UIImage *)qct_imageWithColor:(UIColor *)color;

+ (UIImage *)qct_imageWithColor:(UIColor *)color frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
