//
//  TwoViewController.m
//  ComponentRoutes
//
//  Created by Jion on 2017/3/1.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()
@property(nonatomic,strong)UILabel  *lable;
@property(nonatomic,strong)UIButton  *button;
@end

@implementation TwoViewController
- (void)touch
{
    NSString *url = @"Route://NaviPush/ThreeViewController?userId=99999";
    //若有中文传输需要进行转义
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<10.0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
       [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"第二个界面";
    
    [self.view addSubview:self.lable];
    [self.view addSubview:self.button];
    
    self.lable.text = [NSString stringWithFormat:@"年龄：%@\n用户id:%@",self.age,self.userId];
}

#pragma mark -- 布局
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_lable]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lable)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_lable(200)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lable)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[_button(200)]" options:0 metrics:@{@"leading":[NSNumber numberWithDouble:(self.view.frame.size.width-200)/2]} views:NSDictionaryOfVariableBindings(_button)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_lable]-[_button(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_button,_lable)]];
    
}

#pragma mark --getter
-(UIButton*)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"userID传到下个界面" forState:UIControlStateNormal];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        [_button addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
