//
//  UIButton+Tools.h
//
//  Created by zj on 2019/10/12.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ButtonImageTitleStyle){
    ButtonImageTitleStyleDefault = 0, // 图片在左,文字在右,整体居中
    ButtonImageTitleStyleLeft,
    ButtonImageTitleStyleRight,
    ButtonImageTitleStyleTop,
    ButtonImageTitleStyleBottom,
};



@interface UIButton (Tools)


/// 调整按钮的文本和图片的布局，需要同时存在,
/// @param style 布局样式
/// @param padding 文本与图片的间距
- (void)configButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
