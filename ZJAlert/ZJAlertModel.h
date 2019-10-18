//
//  ZJAlertModel.h
//  demo1
//
//  Created by zj on 2019/10/18.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJAlertActionModel : NSObject

@property (nonatomic, assign) UIAlertActionStyle actionStyle; // action style
@property (nonatomic, copy) NSString *actionTitle; // action title

- (instancetype)initWithTitle:(NSString *)title actionStyle:(UIAlertActionStyle)style;

+ (instancetype)actionWithTitle:(NSString *)title actionStyle:(UIAlertActionStyle)style;

@end




@interface ZJAlertModel : NSObject

@property (nonatomic, assign) UIAlertControllerStyle alertStyle; // alert style

@property (nonatomic, copy) NSString *title; // alert title
@property (nonatomic, copy) NSString *message; // alert message

@property (nonatomic, copy) NSArray<ZJAlertActionModel *> *actions;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style;

+ (instancetype)actionWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style;


@end




NS_ASSUME_NONNULL_END
