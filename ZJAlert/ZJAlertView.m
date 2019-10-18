//
//  ZJAlertView.m
//  demo1
//
//  Created by zj on 2019/10/18.
//  Copyright © 2019 zj. All rights reserved.
//

#import "ZJAlertView.h"
#import "UIApplication+Helper.h"

@implementation ZJAlertView

+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message clickBlock:(clickBlock)block {
    ZJAlertModel *model = [[ZJAlertModel alloc] initWithTitle:title message:message style:UIAlertControllerStyleAlert];
    
    ZJAlertActionModel *cancel = [[ZJAlertActionModel alloc] initWithTitle:@"取消" actionStyle:UIAlertActionStyleCancel];

    model.actions = @[cancel];
    return [self showItem:model clickBlock:block];
}


+ (instancetype)showActionSheetViewWithTitle:(NSString *)title message:(NSString *)message clickBlock:(clickBlock)block {
    
    ZJAlertModel *model = [[ZJAlertModel alloc] initWithTitle:title message:message style:UIAlertControllerStyleActionSheet];
    ZJAlertActionModel *cancel = [[ZJAlertActionModel alloc] initWithTitle:@"取消" actionStyle:UIAlertActionStyleCancel];
    
    model.actions = @[cancel];
    
    return [self showItem:model clickBlock:block];
}



+ (id)showItem:(ZJAlertModel *)model clickBlock:(clickBlock)block {
    if (!model) {
        return nil;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:model.title message:model.message preferredStyle:model.alertStyle];
    
    for (int i = 0; i < model.actions.count; i++) {
        ZJAlertActionModel *acitonModel = model.actions[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:acitonModel.actionTitle style:acitonModel.actionStyle handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(i);
            }
        }];
        
        [alert addAction:action];
    }
    
    [[[UIApplication sharedApplication] zj_getCurrentViewController] presentViewController:alert animated:YES completion:nil];
    return alert;
}


@end
