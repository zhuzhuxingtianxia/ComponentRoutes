//
//  ViewController.m
//  ComponentRoutes
//
//  Created by Jion on 2017/2/28.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property(nonatomic,strong)UIButton  *button;
@property(nonatomic,strong)UILabel  *lable;
@end

@implementation SettingViewController
//第二模块按钮点击
- (void)touch
{
    NSString *url = @"Route://NaviPush/TwoViewController?userId=99999&age=18";
    //若有中文传输需要进行转义
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<10.0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.userId) {
        [self.view addSubview:self.lable];
        self.lable.text = [NSString stringWithFormat:@"用户id:%@",self.userId];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.button];
    
}

#pragma mark -- 布局
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    if (self.userId) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_lable]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lable)]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_lable(200)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lable)]];
    }
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[_button(100)]" options:0 metrics:@{@"leading":[NSNumber numberWithDouble:(self.view.frame.size.width-100)/2]} views:NSDictionaryOfVariableBindings(_button)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[_button(40)]" options:0 metrics:@{@"top":[NSNumber numberWithDouble:(self.view.frame.size.height-40)/2]} views:NSDictionaryOfVariableBindings(_button)]];
    
}

#pragma mark --getter
-(UIButton*)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"设置界面按钮" forState:UIControlStateNormal];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        [_button addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
-(UILabel*)lable{
    if (!_lable) {
        _lable = [[UILabel alloc] init];
        _lable.translatesAutoresizingMaskIntoConstraints = NO;
        _lable.textColor = [UIColor redColor];
        _lable.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.numberOfLines = 0;
    }
    return _lable;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
