//
//  NavigationController.m
//  ComponentRoutes
//
//  Created by Jion on 2017/3/1.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//自定义push操作，加载优化
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
        
        if (animated) {
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.4f;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            [self.navigationController.view.layer addAnimation:animation forKey:nil];
            [self.view.layer addAnimation:animation forKey:nil];
            [super pushViewController:viewController animated:NO];
            return;
        }
    }
    [super pushViewController:viewController animated:animated];
}

/*
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;

    }
    [super pushViewController:viewController animated:animated];
    
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
