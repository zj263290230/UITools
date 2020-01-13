//
//  PageViewController.m
//  demo11
//
//  Created by zzt on 2020/1/13.
//  Copyright © 2020 zzt. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
    CGRect oldRect;
    UIButton *oldBtn;
}
@property (nonatomic, assign) NSInteger totalVC;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *vcArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, assign) NSInteger currenIndex;

@property (nonatomic, strong) UIView *headerView;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lineWidth = self.lineWidth ? self.lineWidth : 0.5;
    self.titleFont = self.titleFont ? self.titleFont : [UIFont systemFontOfSize:14];
    self.defaultColor = self.defaultColor ? self.defaultColor : [UIColor blackColor];
    self.selectedColor = self.selectedColor ? self.selectedColor : [UIColor redColor];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.view addSubview:self.scrollView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = CGRectMake(0, self.topLayoutGuide.length, self.view.frame.size.width, [self.datasource respondsToSelector:@selector(heightForHeaderViewPager:)] ? [self.datasource heightForHeaderViewPager:self] : 0);
    self.scrollView.frame = CGRectMake(0, self.headerView.frame.size.height ? self.headerView.frame.origin.y + self.headerView.frame.size.height : self.topLayoutGuide.length, self.view.frame.size.width, [self.datasource respondsToSelector:@selector(heightForTitleViewPager:)] ? [self.datasource heightForTitleViewPager:self] : 0);
    if (self.titleArray.count) {
        UIButton *btn = self.titleArray.lastObject;
        self.scrollView.contentSize = CGSizeMake(btn.frame.size.width + btn.frame.origin.x, self.scrollView.frame.size.height);
    }
    self.pageViewController.view.frame = CGRectMake(0, self.scrollView.frame.size.height + self.scrollView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - self.scrollView.frame.size.height - self.scrollView.frame.origin.y);
}

- (void)reloadScrollPage {
    if (self.datasource && [self.datasource respondsToSelector:@selector(headerViewForViewPager:)]) {
        self.headerView = [self.datasource headerViewForViewPager:self];
        [self.view addSubview:self.headerView];
    }
    
    if (self.datasource && [self.datasource respondsToSelector:@selector(numberViewControllersInViewPager:)]) {
        self.totalVC = [self.datasource numberViewControllersInViewPager:self];
        oldRect = CGRectZero;
        NSMutableArray *vcLists = [NSMutableArray array];
        NSMutableArray *btnLists = [NSMutableArray array];
        for (int i = 0; i < self.totalVC; i++) {
            if (self.datasource && [self.datasource respondsToSelector:@selector(viewPager:indexViewController:)]) {
                UIViewController *vc = [self.datasource viewPager:self indexViewController:i];
                if (vc && [vc isKindOfClass:[UIViewController class]]) {
                    [vcLists addObject:vc];
                }
            }
            
            UIButton *btn = nil;
            if ([self.datasource respondsToSelector:@selector(viewPager:titleButtonStyle:)]) {
                btn = [self.datasource viewPager:self titleButtonStyle:i];
            } else {
                btn = [[PageButton alloc] init];
                ((PageButton *)btn).btnLineWidth = self.lineWidth;
                
                btn.tag = i;
                [btn.titleLabel setFont:self.titleFont];
                [btn setTitleColor:self.defaultColor forState:UIControlStateNormal];
                [btn setTitleColor:self.selectedColor forState:UIControlStateSelected];
            }
            
            [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *btnTitle = @"";
            if ([self.datasource respondsToSelector:@selector(viewPager:titleWithIndexViewController:)]) {
                btnTitle = [self.datasource viewPager:self titleWithIndexViewController:i];
                [btn setTitle:btnTitle forState:UIControlStateNormal];
            }
            btn.frame = CGRectMake(oldRect.origin.x + oldRect.size.width, 0, [self p_textString:btnTitle withFontHeight:20], [self.datasource respondsToSelector:@selector(heightForTitleViewPager:)] ? [self.datasource heightForTitleViewPager:self] : 0);
            oldRect = btn.frame;
            [btnLists addObject:btn];
            
            [self.scrollView addSubview:btn];
            if (i == self.selectedIndex) {
                oldBtn = [btnLists objectAtIndex:i];
                oldBtn.selected = YES;
            }
        }
        
        if (btnLists.count && ((UIButton *)btnLists.lastObject).frame.origin.x + ((UIButton *)btnLists.lastObject).frame.size.width < self.view.frame.size.width) {
            oldRect = CGRectZero;
            CGFloat padding = self.view.frame.size.width - ((UIButton *)btnLists.lastObject).frame.origin.x - ((UIButton *)btnLists.lastObject).frame.size.width;
            for (UIButton *btn in btnLists) {
                btn.frame = CGRectMake(oldRect.origin.x+oldRect.size.width, 0, btn.frame.size.width + padding / btnLists.count, [self.datasource respondsToSelector:@selector(heightForTitleViewPager:)] ? [self.datasource heightForTitleViewPager:self] : 0);
                oldRect = btn.frame;
            }
        }
        
        self.titleArray = [btnLists copy];
        self.vcArray = [vcLists copy];
    }
    
    if (self.vcArray.count) {
        [self.pageViewController setViewControllers:@[self.vcArray[self.selectedIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    
}

- (void)scrollViewOffset:(UIButton *)btn {
    if (!(self.scrollView.contentSize.width > CGRectGetWidth(self.view.frame))) {
        return;
    }
    
    if (CGRectGetMidX(btn.frame) > CGRectGetMidX(self.view.frame)) {
        if (self.scrollView.contentSize.width < CGRectGetMaxX(self.view.frame) / 2 + CGRectGetMidX(btn.frame)) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - CGRectGetWidth(self.view.frame), 0) animated:YES];
        } else {
            [self.scrollView setContentOffset:CGPointMake(CGRectGetMidX(btn.frame) - CGRectGetWidth(self.view.frame) / 2, 0) animated:YES];
        }
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)titleBtnClick:(UIButton *)btn {
    NSInteger isDirection = oldBtn.tag < btn.tag ? 1 : 0;
    oldBtn.selected = NO;
    btn.selected = YES;
    oldBtn = btn;
    NSInteger index = [self.titleArray indexOfObject:btn];
    [self.pageViewController setViewControllers:@[self.vcArray[index]] direction:isDirection ? UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    [self scrollViewOffset:btn];
    
}

#pragma mark - delegate && datasource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.vcArray indexOfObject:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    } else {
        return self.vcArray[--index];
    }
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.vcArray indexOfObject:viewController];
    if (index == self.vcArray.count - 1 || index == NSNotFound) {
        return nil;
    } else {
        return self.vcArray[++index];
    }
}

// Sent when a gesture-initiated transition begins.
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    self.currenIndex = [self.vcArray indexOfObject:pendingViewControllers.firstObject];
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        if (self.currenIndex != [self.vcArray indexOfObject:previousViewControllers[0]]) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(viewPager:didFinishScrollWithCurrentViewController:)]) {
                [self.delegate viewPager:self didFinishScrollWithCurrentViewController:[self.vcArray objectAtIndex:self.currenIndex]];
            }
        }
    }
}

#pragma mark - private
- (void)p_chooseTitleIndex:(NSInteger)index {
    [self p_titleBtnConvert:self.titleArray[index]];
}
- (void)p_titleBtnConvert:(UIButton *)btn {
    oldBtn.selected = NO;
    btn.selected = YES;
    oldBtn = btn;
    
    [self scrollViewOffset:oldBtn];
}

- (CGFloat)p_textString:(NSString *)text withFontHeight:(CGFloat)fontHeight {
    CGFloat padding = 20;
    NSDictionary *dict = @{
                           NSFontAttributeName: self.titleFont
                           };
    CGSize fontSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, fontHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    return fontSize.height + padding;
}

#pragma mark - setter && getter
- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

@end



@implementation PageButton

- (instancetype)init {
    self = [super init];
    if (self) {
        self.btnLineWidth = 1.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (self.selected) {
        CGFloat lineWidth = self.btnLineWidth;
        CGColorRef color = self.titleLabel.textColor.CGColor;
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctx, color);
        CGContextSetLineWidth(ctx, 1.0);
        CGContextMoveToPoint(ctx, 0, self.frame.size.width - lineWidth);
        CGContextAddLineToPoint(ctx, self.frame.size.width, self.frame.size.height - lineWidth);
        CGContextStrokePath(ctx);
    }
}

@end
