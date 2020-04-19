//
//  UIScrollView+KFNestScrollView.m
//  KFNestScrollViewExample
//
//  Created by Carefree on 2020/4/19.
//  Copyright © 2020年 Carefree. All rights reserved.
//

#import "UIScrollView+KFNestScrollView.h"
#import <objc/runtime.h>

@implementation UIScrollView (KFNestScrollView)

- (id<KFNestScrollHandler>)kf_scrollHandler {
    return objc_getAssociatedObject(self, @selector(kf_scrollHandler));
}

- (void)setKf_scrollHandler:(id<KFNestScrollHandler>)kf_scrollHandler {
    objc_setAssociatedObject(self, @selector(kf_scrollHandler), kf_scrollHandler, OBJC_ASSOCIATION_ASSIGN);
}

@end
