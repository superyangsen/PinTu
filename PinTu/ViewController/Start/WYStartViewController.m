//
//  WYStartViewController.m
//  PinTu
//
//  Created by 协力达 on 15/10/14.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "WYStartViewController.h"
#import "WYHomePageViewController.h"

@interface WYStartViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation WYStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.imgView];
    [self startAnimation];
}

#pragma mark - 懒加载
- (UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, DEVICE_SIZE.height * 0.2, DEVICE_SIZE.width, 40)];
        

        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"益智拼图";
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    return _titleLabel;
}

- (UIImageView *)imgView
{
    if(!_imgView)
    {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_SIZE.width / 2 - 50, DEVICE_SIZE.height * 0.5 - 50, 100, 100)];
        _imgView.image = [UIImage imageNamed:@"0060.李贞贤.jpg"];
    }
    return _imgView;
}

- (void)startAnimation
{
    self.titleLabel.alpha = 0.3;
    self.imgView.alpha = 0;
    
    [UIView animateWithDuration:2.0f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.titleLabel.alpha = 1.0f;
        
        NSLog(@"1");
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:2.0f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.imgView.alpha = 1.0f;
            
            NSLog(@"2");
            
        } completion:^(BOOL finished) {
            
            NSLog(@"3");
            [self endAnimation];
        }];
    }];
}

- (void)endAnimation
{
    WYHomePageViewController *homePageVC = [[WYHomePageViewController alloc] init];
    
    UINavigationController *homePageNav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
    
    self.appDelegate.window.rootViewController = homePageNav;
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
