//
//  WeakProxy.h
//  demo1
//
//  Created by zj on 2019/10/22.
//  Copyright © 2019 zj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;



@end

NS_ASSUME_NONNULL_END
