//
//  ZJBannerView.m
//  demo11
//
//  Created by zzt on 2020/1/10.
//  Copyright © 2020 zzt. All rights reserved.
//

#import "ZJBannerView.h"
#import "ZJBannerImageView.h"

@interface ZJBannerView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSArray *imageViews;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) bannerTouchBlock bannerBlock;

@property (nonatomic, assign) CGFloat rollInterval;
@property (nonatomic, assign) CGFloat animateInterval;

@end


@implementation ZJBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_creatViews];
        [self p_defaultSetting];
        
    }
    return self;
}

- (void)reloadBanner {
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self setImagesWithBannerDatas:self.datas withTouchBlcok:self.bannerBlock];
}

- (void)setImagesWithBannerDatas:(NSArray *)datas withTouchBlcok:(bannerTouchBlock)bannerBlock {
    self.datas = datas;
    self.bannerBlock = bannerBlock;
    
    [self layoutIfNeeded];
    
    // 头部加如最后一张，尾部加入第一张
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.datas];
    id firstObject = self.datas.firstObject;
    id lastObject = self.datas.lastObject;
    [tmp insertObject:lastObject atIndex:0];
    [tmp addObject:firstObject];
    
    CGRect frame = self.frame;
    NSMutableArray *imageViews = [NSMutableArray array];
    for (int i = 0; i < tmp.count; i++) {
        id<ZJBannerData> model = self.datas[i];
        ZJBannerImageView *imageView = [[ZJBannerImageView alloc] initWithFrame:CGRectMake(i * frame.size.width, 0, frame.size.width, frame.size.height)];
        if (bannerBlock) {
            imageView.touchBlock = ^{
                bannerBlock(model);
            };
        }
        if (model.image) {
            [imageView setImage:model.image];
        } else {
            // need sdwebimage
//            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrlstr] placeholderImage:model.placeHolder];
        }
        [self.scrollView addSubview:imageView];
        [imageViews addObject:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(tmp.count * frame.size.width, 0);
    self.imageViews = [imageViews copy];
    
    [self p_setUpPageControl:tmp.count];
    [self p_creatTimer];
    
}

- (void)setImagesWithBannerDatas:(NSArray *)datas rollInterval:(CGFloat)rollInterval animatedInterval:(CGFloat)animatedInterval withTouchBlcok:(bannerTouchBlock)bannerBlock {
    self.animateInterval = animatedInterval;
    self.rollInterval = rollInterval;
    [self setImagesWithBannerDatas:datas withTouchBlcok:bannerBlock];
}

- (void)setImagesWithBannerDatas:(NSArray *)datas selectedColor:(UIColor *)selectedColor indicatorTintColor:(UIColor *)indicatorTintColor withTouchBlcok:(bannerTouchBlock)bannerBlock {
    self.pageControl.pageIndicatorTintColor = indicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = selectedColor;
    [self setImagesWithBannerDatas:datas withTouchBlcok:bannerBlock];
}

//图片的个数  1 2 3 4 5 6 7 8
//真实的页码  0 1 2 3 4 5 6 7
//显示的页码    0 1 2 3 4 5

- (void)rolling {
    CGPoint point = self.scrollView.contentOffset;
    CGFloat width = self.frame.size.width;
    CGPoint endpoint = CGPointMake(point.x + width, 0);
    
    if (endpoint.x == (self.imageViews.count - 1) * width) {
        [UIView animateWithDuration:self.animateInterval animations:^{
            self.scrollView.contentOffset = CGPointMake(endpoint.x, 0);
        } completion:^(BOOL finished) {
            // 重置为第一页
            self.scrollView.contentOffset = CGPointMake(width, 0);
            
            CGPoint realEnd = self.scrollView.contentOffset;
            self.currentPage = realEnd.x / width;
            self.pageControl.currentPage = self.currentPage - 1;
        }];
    } else {
        [UIView animateWithDuration:self.animateInterval animations:^{
            self.scrollView.contentOffset = endpoint;
        } completion:^(BOOL finished) {
            
            CGPoint realEnd = self.scrollView.contentOffset;
            self.currentPage = realEnd.x / width;
            self.pageControl.currentPage = self.currentPage - 1;
            
        }];
    }
}


#pragma mark - delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.timer) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.rollInterval]];
    }
    
    CGPoint point = self.scrollView.contentOffset;
    CGFloat width = self.frame.size.width;
    
    if (point.x == (self.imageViews.count - 1) * width) {
        // 重置为第一张
        self.scrollView.contentOffset = CGPointMake(width, 0);
    }
    
    if (point.x == 0) {
        // 重置为最后一张
        self.scrollView.contentOffset = CGPointMake((self.imageViews.count - 2) * width, 0);
    }
    
    CGPoint realEnd = self.scrollView.contentOffset;
    self.currentPage = realEnd.x / width;
    self.pageControl.currentPage = self.currentPage - 1;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

#pragma mark - private
- (void)p_defaultSetting {
    self.rollInterval = 5;
    self.animateInterval = 0.5;
    
    self.pageControl.pageIndicatorTintColor = [UIColor redColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
}

- (void)p_creatViews {
    CGRect frame = self.frame;
    
    self.bgView = [[UIView alloc] initWithFrame:frame];
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.center = CGPointMake(frame.size.height / 2, self.pageControl.frame.size.width / 2);
    
    [self addSubview:self.bgView];
    
    [self.bgView addSubview:self.scrollView];
    [self.bgView addSubview:self.pageControl];
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    
    // 屏幕旋转时重新处理下
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadBanner) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
//    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.equalTo(self);
//    }];
//
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.equalTo(backgroundView);
//    }];
//
//    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(backgroundView.mas_bottom);
//        make.centerX.equalTo(backgroundView);
//    }];
}

- (void)p_setUpPageControl:(NSInteger)count {
    self.pageControl.numberOfPages = count;
    self.pageControl.currentPage = count;
    self.currentPage = 0;
}

- (void)p_creatTimer {
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.rollInterval target:self selector:@selector(rolling) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
@end
