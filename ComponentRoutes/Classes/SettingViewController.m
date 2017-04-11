//
//  ViewController.m
//  ComponentRoutes
//
//  Created by Jion on 2017/2/28.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "SettingViewController.h"
#import "UILabel+Pasteboard.h"
#import <objc/runtime.h>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma clang diagnostic pop

@interface SettingViewController ()
@property(nonatomic,strong)UIButton  *button;
@property(nonatomic,strong)UILabel  *lable;
@property(nonatomic,strong)UILabel  *pasteLable;

+ (void)learnClass:(NSString *) string;
- (void)goToSchool:(NSString *) name;

@end

void dynamicMethodIMP(id self, SEL _cmd) {
    // implementation ....
}

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
    NSString *string = @"m2";
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string];
    //NSVerticalGlyphFormAttributeName 0为水平排版的字，1为垂直排版的字
    //NSDictionary *daict = @{NSVerticalGlyphFormAttributeName:@0,NSFontAttributeName:[UIFont systemFontOfSize:8]};
    //NSBaselineOffsetAttributeName 基准线
    NSDictionary *daict = @{NSBaselineOffsetAttributeName:@(self.lable.font.pointSize/3),NSFontAttributeName:[UIFont systemFontOfSize:self.lable.font.pointSize/2]};
    [attributed addAttributes:daict range:NSMakeRange(1, 1)];
    [self.view addSubview:self.lable];
    self.lable.attributedText = attributed;
    if (self.userId) {
        [self.view addSubview:self.lable];
        self.lable.text = [NSString stringWithFormat:@"m²用户id:%@",self.userId];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.button];
    [self.view addSubview:self.pasteLable];
    [self runtimeTest];
}

-(void)runtimeTest{

    NSString *name = [self nameWithInstance:self.button];
}

+(BOOL)resolveInstanceMethod:(SEL)sel{

    if (sel == @selector(dynamicMethodIMP)) {
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
        return YES;
    }else if (sel == @selector(goToSchool:)){
        class_addMethod([self class], sel, class_getMethodImplementation([self class], @selector(myInstanceMethod:)), "v@:");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}


+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(learnClass:)) {
        class_addMethod(object_getClass(self), sel, class_getMethodImplementation(object_getClass(self), @selector(myClassMethod:)), "v@:");
        return YES;
    }
    return [class_getSuperclass(self) resolveClassMethod:sel];
}

+ (void)myClassMethod:(NSString *)string {
    NSLog(@"myClassMethod = %@", string);
}

- (void)myInstanceMethod:(NSString *)string {
    NSLog(@"myInstanceMethod = %@", string);
}

//属性名反射机制
-(NSString *)nameWithInstance:(id)instance {
    unsigned int numIvars = 0;
    NSString *key=nil;
    //class_copyIvarList 函数获取的不仅有实例变量，还有属性。但会在原本的属性名前加上一个下划线。
    Ivar * ivars = class_copyIvarList([self class], &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        const char *type = ivar_getTypeEncoding(thisIvar);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        if (![stringType hasPrefix:@"@"]) {
            continue;
        }
        //此处若 crash 不要慌！
        if ((object_getIvar(self, thisIvar) == instance)) {            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
            break;
        }
    }
    free(ivars);
    return key;
}

#pragma mark -- 布局
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_lable]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lable)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_lable(200)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lable)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_pasteLable]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pasteLable)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_pasteLable(30)]-50-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pasteLable)]];
    
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
        [_lable pasteboardHandler];
    }
    return _lable;
}

-(UILabel*)pasteLable{
    if (!_pasteLable) {
        _pasteLable = [[UILabel alloc] init];
        _pasteLable.translatesAutoresizingMaskIntoConstraints = NO;
        _pasteLable.textColor = [UIColor redColor];
        _pasteLable.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _pasteLable.textAlignment = NSTextAlignmentCenter;
        _pasteLable.numberOfLines = 0;
        [_pasteLable pasteboardHandler];
    }
    return _pasteLable;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
