//
//  HomeViewController.m
//  ComponentRoutes
//
//  Created by Jion on 2017/3/1.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView  *tableView;
@property(nonatomic,strong)NSArray   *dataArray;
@end

@implementation HomeViewController
//第一模块按钮点击事件
- (void)touch
{
    
    NSString *url = @"Route://NaviPush/OneViewController";
    
    //若有中文传输需要进行转义
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<10.0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else{
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildView];
    
}

-(void)buildView{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"首页按钮" forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[button(100)]" options:0 metrics:@{@"leading":[NSNumber numberWithDouble:(self.view.frame.size.width-100)/2]} views:NSDictionaryOfVariableBindings(button)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[button(40)]" options:0 metrics:@{@"top":[NSNumber numberWithDouble:64]} views:NSDictionaryOfVariableBindings(button)]];

    [self.view addSubview:self.tableView];
}


-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_tableView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[_tableView]-|" options:0 metrics:@{@"top":[NSNumber numberWithDouble:64+40]} views:NSDictionaryOfVariableBindings(_tableView)]];
}

#pragma mark --TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * urlString = self.dataArray[indexPath.row][@"prefs"];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    }
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    }
    return _tableView;
}
-(NSArray*)dataArray{
    if (!_dataArray) {
        _dataArray = @[
                       
  @{@"title":@"微信",@"prefs":@"weixin://"},
  @{@"title":@"QQ",@"prefs":@"mqq://"},
  @{@"title":@"支付宝",@"prefs":@"alipay://"},
  @{@"title":@"Safari",@"prefs":@"http://m.baidu.com"},
  @{@"title":@"WIFI",@"prefs":@"App-Prefs:root=WIFI"},
  @{@"title":@"设置",@"prefs":UIApplicationOpenSettingsURLString},
  @{@"title":@"设置Safari",@"prefs":@"App-Prefs:root=Safari"},
  @{@"title":@"移动网络",@"prefs":@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"},
  @{@"title":@"相机",@"prefs":@"App-Prefs:root=Photos"},
  @{@"title":@"定位服务",@"prefs":@"App-Prefs:root=LOCATION_SERVICES"},
  @{@"title":@"通知",@"prefs":@"App-Prefs:root=NOTIFICATIONS_ID"}];
        
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
