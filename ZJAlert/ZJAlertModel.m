//
//  ZJAlertModel.m
//  demo1
//
//  Created by zj on 2019/10/18.
//  Copyright © 2019 zj. All rights reserved.
//

#import "ZJAlertModel.h"


@implementation ZJAlertActionModel

+ (instancetype)actionWithTitle:(NSString *)title actionStyle:(UIAlertActionStyle)style {
    ZJAlertActionModel * model = [[self alloc] initWithTitle:title actionStyle:style];
    return model;
}

- (instancetype)initWithTitle:(NSString *)title actionStyle:(UIAlertActionStyle)style {
    self = [super init];
    if (self) {
        self.actionTitle = title;
        self.actionStyle = style;
    }
    return self;
}


@end


@implementation ZJAlertModel

+ (instancetype)actionWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style {
    ZJAlertModel *model = [[self alloc] initWithTitle:title message:message style:style];
    return model;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style {
    self = [super init];
    if (self) {
        self.title = title;
        self.message = message;
        self.alertStyle = style;
    }
    return self;
}


@end
