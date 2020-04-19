//
//  KFNestScrollManager.m
//  KFNestScrollViewExample
//
//  Created by Carefree on 2020/4/19.
//  Copyright © 2020年 Carefree. All rights reserved.
//

#import "KFNestScrollManager.h"

@interface KFNestScrollManager()

//父视图ScrollView是否可滑动
@property (nonatomic, assign) BOOL  mainScrollEnabled;
//子视图ScrollView是否可滑动
@property (nonatomic, assign) BOOL  childScrollEnabled;
//子视图ScrollView集合
@property (nonatomic, strong) NSHashTable<UIScrollView *> *childScrollViews;

@end

@implementation KFNestScrollManager

#pragma mark - Lifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.fixedVerticalOffset = CGFLOAT_MAX;
        self.mainScrollEnabled = YES;
        self.childScrollEnabled = YES;
        self.autoScrollsToTop = YES;
    }
    
    return self;
}

#pragma mark - QSNestScrollDelegate
- (void)mainScrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    //当偏移值大于最大偏移值时，父视图ScrollView不可滑动
    if (offsetY > self.fixedVerticalOffset) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, self.fixedVerticalOffset);
    }
    
    if (self.mainScrollEnabled) {
        //更新子视图ScrollView是否可滑动
        self.childScrollEnabled = offsetY >= self.fixedVerticalOffset;
    } else {
        //子视图ScrollView可滑动
        self.childScrollEnabled = YES;
        //父视图ScrollView不可滑动
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, self.fixedVerticalOffset);
    }
    
    if (self.autoScrollsToTop && scrollView.contentOffset.y < self.fixedVerticalOffset) {
        //将所有childScrollView回滚到顶部
        [self makeChildScrollsToTop];
    }
}

- (void)childScrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.childScrollEnabled) {
        //更新父视图ScrollView是否可滑动
        self.mainScrollEnabled = scrollView.contentOffset.y <= 0;
    } else {
        //子视图ScrollView不可滑动
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
    
    [self.childScrollViews addObject:scrollView];
}

#pragma mark - Private
- (void)makeChildScrollsToTop {
    for (UIScrollView *obj in self.childScrollViews) {
        if (obj.contentOffset.y == 0) {
            continue;
        }
        obj.contentOffset = CGPointMake(obj.contentOffset.x, 0);
    }
}

#pragma mark - Lazyloading
- (NSHashTable<UIScrollView *> *)childScrollViews {
    if (_childScrollViews) {
        return _childScrollViews;
    }
    
    _childScrollViews = [NSHashTable weakObjectsHashTable];
    return _childScrollViews;
}

@end
