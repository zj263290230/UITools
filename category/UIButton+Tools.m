//
//  UIButton+Tools.m
//
//  Created by zj on 2019/10/12.
//

#import "UIButton+Tools.h"


@implementation UIButton (Tools)

- (void)configButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding {
    if (self.titleLabel.text && self.imageView.image) {
        // 先还原为默认值
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        
        CGRect imageRect = self.imageView.frame;
        CGRect titleRect = self.titleLabel.frame;
        
        CGFloat totalHeight = imageRect.size.height + padding + titleRect.size.height;
        CGFloat selfHeight = self.frame.size.height;
        CGFloat selfWidth = self.frame.size.width;
        
        switch (style) {
            case ButtonImageTitleStyleLeft:{
                self.titleEdgeInsets = UIEdgeInsetsMake(0, padding / 2, 0, -padding / 2);
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -padding / 2, 0, padding / 2);
            }
                break;
            case ButtonImageTitleStyleRight:{
                // 图片在右,文字在左
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageRect.size.width + padding / 2), 0, (imageRect.size.width + padding / 2));
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (titleRect.size.width + padding / 2), 0, -(titleRect.size.width + padding / 2));
            }
                break;
            case ButtonImageTitleStyleTop:{
                // 图片在上, 文字在下
                self.titleEdgeInsets = UIEdgeInsetsMake(
                                                        ((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                                        
                                                        (selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2,
                                                                       
                                                        -((selfHeight - totalHeight)/2 + imageRect.size.height + padding - titleRect.origin.y),
                                                        -(selfWidth/2 - titleRect.origin.x - titleRect.size.width /2) - (selfWidth - titleRect.size.width) / 2
                                                        );
                self.imageEdgeInsets =  UIEdgeInsetsMake(
                                                         ((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                                        
                                                         (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                                        
                                                         -((selfHeight - totalHeight)/2 - imageRect.origin.y),
                                                                        
                                                         -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2)
                                                         );
            }
                break;
            case ButtonImageTitleStyleBottom:{
                // 图片在下, 文在在上
                 self.titleEdgeInsets = UIEdgeInsetsMake(
                                                         ((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                                        
                                                         (selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                                        
                                                         -((selfHeight - totalHeight)/2 - titleRect.origin.y),
                                                                        
                                                         -(selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2
                                                         );
                                
                                
                self.imageEdgeInsets = UIEdgeInsetsMake(
                                                        ((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                                        
                                                        (selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2),
                                                                        
                                                        -((selfHeight - totalHeight)/2 + titleRect.size.height + padding - imageRect.origin.y),
                                                                        
                                                        -(selfWidth /2 - imageRect.origin.x - imageRect.size.width / 2)
                                                        );

            }
                break;
            default:
                break;
        }
    } else {
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
    }
}

@end
