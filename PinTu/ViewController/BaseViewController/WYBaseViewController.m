//
//  BaseViewController.m
//  PinTu
//
//  Created by 协力达 on 15/10/12.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "WYBaseViewController.h"

@interface WYBaseViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *leftBtn;

@end

@implementation WYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor greenColor]] forBarMetrics:UIBarMetricsDefault];
}

- (AppDelegate *)appDelegate
{
    if(!_appDelegate)
    {
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

#pragma mark - 设置title
- (void)setNavgationBarTitle:(NSString *)title
{
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_SIZE.width - 60, 0, 120, 44)];
        
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.navigationItem.titleView = _titleLabel;
        _titleLabel.text = title;
    }
}

#pragma mark - 设置返回键
- (void)setBackBtnTitle:(NSString *)title imageStr:(NSString *)imageStr
{
    if(!_backBtn)
    {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _backBtn.frame = CGRectMake(0, 0, 40, 44);
        
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 3, 5, 7);
        
        [_backBtn setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
        
        [_backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        //[_navbarView addSubview:_backBtn];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    }
}

#pragma mark - 设置左键
- (void)setLeftBtnTitle:(NSString *)title imageStr:(NSString *)imageStr
{
    if(!_leftBtn)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _leftBtn.frame = CGRectMake(0, 0, 40, 44);
        
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 20);
        
        [_leftBtn setTitle:title forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        
        [_leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        //    [_navbarView addSubview:_leftBtn];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    }
}

#pragma mark - 设置右键
- (void)setRightBtnTitle:(NSString *)title imageStr:(NSString *)imageStr
{
    if(!_rightBtn)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _rightBtn.frame = CGRectMake(0, 0, 40, 44);
        
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _rightBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 20, 12, 0);
        
        [_rightBtn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        
        [_rightBtn setTitle:title forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        //    [_navbarView addSubview:_rightBtn];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    }
}

- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftButtonClick
{
    
}

- (void)rightButtonClick
{
    
}

#pragma mark - 显示提示信息
- (void)showMessageWithMessage:(NSString *)message
{
    CGFloat  height = 30;
    CGFloat width = [Helper widthOfString:message font:[UIFont systemFontOfSize:17] height:height];
    
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width + 30, height + 10)];
    
    messageLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    messageLabel.layer.cornerRadius = 5;
    messageLabel.clipsToBounds = YES;
    messageLabel.center = CGPointMake(DEVICE_SIZE.width / 2, DEVICE_SIZE.height / 2);
    messageLabel.text = message;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:messageLabel];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [messageLabel removeFromSuperview];
    });
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

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
