//
//  UIColor+hex.h
//  QCT
//
//  Created by zj on 2019/5/27.
//  Copyright © 2019 coder_zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (hex)
+ (UIColor *)qct_colorWithHexStr:(NSString *)colorStr;


+ (UIColor *)qct_colorWithHexStr:(NSString *)colorStr alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
