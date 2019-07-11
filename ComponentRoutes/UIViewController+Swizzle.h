//
//  UIViewController+Swizzle.h
//  ComponentRoutes
//
//  Created by ZZJ on 2018/9/4.
//  Copyright © 2018年 Youjuke. All rights reserved.
//可操考：https://www.jianshu.com/p/3a5db9caace8
//来源：https://juejin.im/post/5b8be6c86fb9a019d9247b2a
//用于数据的收集，页面的加载速度

#import <UIKit/UIKit.h>

@interface UIViewController (Swizzle)
@property(nonatomic,assign) CFAbsoluteTime viewLoadStartTime;
@end
