//
//  ZJBannerImageView.h
//  demo11
//
//  Created by zzt on 2020/1/10.
//  Copyright © 2020 zzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^touchImageBlock)(void);

@interface ZJBannerImageView : UIImageView
@property (nonatomic, copy) touchImageBlock touchBlock;
@end

NS_ASSUME_NONNULL_END
