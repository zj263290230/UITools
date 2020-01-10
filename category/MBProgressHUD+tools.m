//
//  MBProgressHUD+tools.m
//  QCT
//
//  Created by zj on 2019/5/29.
//  Copyright © 2019 coder_zhao. All rights reserved.
//

#import "MBProgressHUD+tools.h"

@implementation MBProgressHUD (tools)
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view showTime:(NSTimeInterval)delay
{
    if (view == nil) view = [[UIApplication sharedApplication].delegate window];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = text;
    // 设置图片
    if (icon.length) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    }
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:delay];
}

/**
 *  显示成功信息
 *
 *  @param success 文字
 *  @param delay   时间
 */
+ (void)showSuccess:(NSString *)success showTime:(NSTimeInterval)delay
{
    [self showSuccess:success toView:nil showTime:delay];
}
/**
 *  显示失败信息
 *
 *  @param error 文字
 *  @param delay   时间
 */
+ (void)showError:(NSString *)error showTime:(NSTimeInterval)delay
{
    [self showError:error toView:nil showTime:delay];
}
/**
 *  显示成功信息
 *
 *  @param success 文字
 *  @param view    哪一个视图
 *  @param delay   时间
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view showTime:(NSTimeInterval)delay
{
    [self show:success icon:@"" view:view showTime:delay]; // 取消图片
}
/**
 *  显示失败信息
 *
 *  @param error 文字
 *  @param view    哪一个视图
 *  @param delay   时间
 */
+ (void)showError:(NSString *)error toView:(UIView *)view showTime:(NSTimeInterval)delay
{
    [self show:error icon:@"" view:view showTime:delay]; // 取消图片
}

#pragma mark - 加载动画

/**
 *  显示HUD
 *
 *  @param message 文字
 *  @param view    哪一个view
 */
+ (MBProgressHUD *)animationWithMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].delegate window];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    
    hud.labelColor = [UIColor whiteColor];
    
    return hud;
}
/**
 *  显示HUD
 *
 *  @param message 文字
 */
+ (MBProgressHUD *)animationWithMessage:(NSString *)message
{
    return [self animationWithMessage:message toView:nil];
}
/**
 *  隐藏HUD
 *
 *  @param view 哪一个view
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].delegate window];
    
    [self hideHUDForView:view animated:YES];
}
/**
 *  隐藏HUD
 *
 *  @param delay 延迟时间
 */
+ (void)hideHUDForView:(UIView *)view timeOut:(NSTimeInterval)delay
{
    if (view == nil) view = [[UIApplication sharedApplication].delegate window];
    
    MBProgressHUD *hud = [self HUDForView:view];
    
    [hud hide:YES afterDelay:delay];
}
/**
 *  隐藏HUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
