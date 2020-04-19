//
//  KFNestScrollManager.h
//  KFNestScrollViewExample
//
//  Created by Carefree on 2020/4/19.
//  Copyright © 2020年 Carefree. All rights reserved.
//

#import "UIScrollView+KFNestScrollView.h"

@interface KFNestScrollManager : NSObject<KFNestScrollHandler>

//父视图ScrollView可滚动的偏移量
@property (nonatomic, assign) CGFloat   fixedVerticalOffset;
//子视图ScrollView是否回到顶部，默认为YES
@property (nonatomic, assign) BOOL      autoScrollsToTop;
//是否回到顶部操作
@property (nonatomic, assign) BOOL      isScrollingToTop;

@end
