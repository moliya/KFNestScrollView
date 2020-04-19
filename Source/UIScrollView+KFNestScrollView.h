//
//  UIScrollView+KFNestScrollView.h
//  KFNestScrollViewExample
//
//  Created by Carefree on 2020/4/19.
//  Copyright © 2020年 Carefree. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KFNestScrollHandler <NSObject>

//父视图ScrollView滚动回调
- (void)mainScrollViewDidScroll:(UIScrollView *)scrollView;

//子视图ScrollView滚动回调
- (void)childScrollViewDidScroll:(UIScrollView *)scrollView;

@end


@interface UIScrollView (KFNestScrollView)

@property (nonatomic, weak) id<KFNestScrollHandler> kf_scrollHandler;

@end
