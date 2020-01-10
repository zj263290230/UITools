//
//  ZJBannerImageView.m
//  demo11
//
//  Created by zzt on 2020/1/10.
//  Copyright © 2020 zzt. All rights reserved.
//

#import "ZJBannerImageView.h"

@implementation ZJBannerImageView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImageView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)didClickImageView {
    if (self.touchBlock) {
        self.touchBlock();
    }
}
@end
