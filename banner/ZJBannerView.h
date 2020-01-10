//
//  ZJBannerView.h
//  demo11
//
//  Created by zzt on 2020/1/10.
//  Copyright © 2020 zzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol ZJBannerData <NSObject>

@property (nonatomic, copy) NSString *imageUrlstr;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *placeHolder;

@end


typedef void(^bannerTouchBlock)(id<ZJBannerData> bannerData);


@interface ZJBannerView : UIView
- (void)reloadBanner;
- (void)setImagesWithBannerDatas:(NSArray *)datas withTouchBlcok:(bannerTouchBlock)bannerBlock;
- (void)setImagesWithBannerDatas:(NSArray *)datas rollInterval:(CGFloat)rollInterval animatedInterval:(CGFloat)animatedInterval withTouchBlcok:(bannerTouchBlock)bannerBlock;
- (void)setImagesWithBannerDatas:(NSArray *)datas selectedColor:(UIColor *)selectedColor indicatorTintColor:(UIColor *)indicatorTintColor withTouchBlcok:(bannerTouchBlock)bannerBlock;

@end

NS_ASSUME_NONNULL_END
