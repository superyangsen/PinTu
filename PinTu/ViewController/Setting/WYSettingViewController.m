//
//  WYSettingViewController.m
//  PinTu
//
//  Created by 协力达 on 15/10/12.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "WYSettingViewController.h"

@interface WYSettingViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation WYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavgationBarTitle:@"设置"];
    [self setBackBtnTitle:nil imageStr:nil];
    
    [self.view addSubview:self.segmentedControl];
}

#pragma mark - 懒加载
- (UISegmentedControl *)segmentedControl
{
    if(!_segmentedControl)
    {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"容易", @"中等", @"困难"]];
        
        _segmentedControl.frame = CGRectMake(20, 70, DEVICE_SIZE.width - 40, 40);
        [_segmentedControl addTarget:self action:@selector(segmentedControlValueChange:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:GAME_DIFFICULTY] integerValue];
    }
    return _segmentedControl;
}

#pragma mark - 游戏难度选择
- (void)segmentedControlValueChange:(UISegmentedControl *)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:index] forKey:GAME_DIFFICULTY];
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
