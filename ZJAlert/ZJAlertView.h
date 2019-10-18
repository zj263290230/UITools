//
//  ZJAlertView.h
//  demo1
//
//  Created by zj on 2019/10/18.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJAlertModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^clickBlock)(NSInteger index);


@interface ZJAlertView : UIView


/// show a system alertView
/// @param title title
/// @param message message
/// @param block click event
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message clickBlock:(clickBlock)block;


/// show a system actionSheet
/// @param title title
/// @param message message
/// @param block click event
+ (instancetype)showActionSheetViewWithTitle:(NSString *)title message:(NSString *)message clickBlock:(clickBlock)block;


/// show alert by model
/// @param model alert model
/// @param block click event
+ (id)showItem:(ZJAlertModel *)model clickBlock:(clickBlock)block;



@end

NS_ASSUME_NONNULL_END
