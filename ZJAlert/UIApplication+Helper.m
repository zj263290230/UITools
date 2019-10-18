//
//  UIApplication+Helper.m
//  demo1
//
//  Created by zj on 2019/10/18.
//  Copyright © 2019 zj. All rights reserved.
//

#import "UIApplication+Helper.h"

@implementation UIApplication (Helper)

- (UIViewController *)zj_getCurrentViewController {
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self p_getController:vc];
}

- (UIViewController *)p_getController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        return [self p_getController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.childViewControllers.count) {
            return [self p_getController:svc.childViewControllers.lastObject];
        }
        return svc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        if (nav.viewControllers.count) {
            return [self p_getController:nav.topViewController];
        }
        return nav;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVC = (UITabBarController *)vc;
        if (tabVC.viewControllers.count) {
            return [self p_getController:tabVC.selectedViewController];
        }
        return tabVC;
    } else {
        return vc;
    }
}

@end
