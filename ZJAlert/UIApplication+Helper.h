//
//  UIApplication+Helper.h
//  demo1
//
//  Created by zj on 2019/10/18.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Helper)


/// 获取当前控制器
- (UIViewController *)zj_getCurrentViewController;

@end

NS_ASSUME_NONNULL_END
