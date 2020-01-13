//
//  PageViewController.h
//  demo11
//
//  Created by zzt on 2020/1/13.
//  Copyright © 2020 zzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PageViewController;
@protocol PageViewControllerDelegate <NSObject>
- (void)viewPager:(PageViewController *)viewPager didFinishScrollWithCurrentViewController:(UIViewController *)viewController;
- (void)viewPager:(PageViewController *)viewPager willScrollWithCurrentViewController:(UIViewController *)viewController;
@end

@protocol PageviewcontrollerDatasource <NSObject>
@required
- (NSInteger)numberViewControllersInViewPager:(PageViewController *)viewPager;
- (UIViewController *)viewPager:(PageViewController *)viewPager indexViewController:(NSInteger)index;
- (NSString *)viewPager:(PageViewController *)viewPager titleWithIndexViewController:(NSInteger)index;


@optional
- (UIButton *)viewPager:(PageViewController *)viewPager titleButtonStyle:(NSInteger)index;
- (CGFloat)heightForTitleViewPager:(PageViewController *)viewPager;
- (UIView *)headerViewForViewPager:(PageViewController *)viewPager;
- (CGFloat)heightForHeaderViewPager:(PageViewController *)viewPager;
@end




@interface PageViewController : UIViewController

@property (nonatomic, weak) id<PageViewControllerDelegate> delegate;
@property (nonatomic, weak) id<PageviewcontrollerDatasource> datasource;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) CGFloat lineWidth;

- (void)reloadScrollPage;

@end


@interface PageButton : UIButton

@property (nonatomic, assign) CGFloat btnLineWidth;

@end

NS_ASSUME_NONNULL_END
