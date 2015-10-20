//
//  WYHomePageViewController.m
//  PinTu
//
//  Created by 协力达 on 15/10/12.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "WYHomePageViewController.h"
#import "WYMainGameViewController.h"
#import "WYSettingViewController.h"
#import "WYGameLevelViewController.h"

typedef NS_ENUM(NSUInteger, HomePageButton) {
    HomePageButtonStartGame = 1,    //开始游戏
    HomePageButtonGameLevel,        //游戏关卡
    HomePageButtonSuccessRecord,    //成功纪录
};

@interface WYHomePageViewController ()

@property (nonatomic, strong) UIButton *startGameButton;
@property (nonatomic, strong) UIButton *gameLevelButton;
@property (nonatomic, strong) UIButton *successRecordButton;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation WYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavgationBarTitle:@"拼图"];
    [self setRightBtnTitle:@"设置" imageStr:nil];
    [self.view addSubview:self.startGameButton];
    [self.view addSubview:self.gameLevelButton];
    [self.view addSubview:self.successRecordButton];
    
    [self.view setNeedsUpdateConstraints];
    
    
    
}

- (void)updateViewConstraints
{
    if(!self.didSetupConstraints)
    {
        [self.startGameButton autoPinToTopLayoutGuideOfViewController:self withInset:60];
//        [self.startGameButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view withOffset:-120];
        [self.startGameButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.startGameButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withMultiplier:0.5];
     
        [self.startGameButton autoSetDimension:ALDimensionHeight toSize:50];
        
        [self.gameLevelButton autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.startGameButton];
        [self.gameLevelButton autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.startGameButton];
        [self.gameLevelButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.startGameButton withOffset:40];
        [self.gameLevelButton  autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.startGameButton];
        
        [self.successRecordButton autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.gameLevelButton];
        [self.successRecordButton autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.gameLevelButton];
        [self.successRecordButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.gameLevelButton withOffset:40];
        [self.successRecordButton  autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.gameLevelButton];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateViewConstraints];
}

#pragma mark - 懒加载
- (UIButton *)startGameButton
{
    if(!_startGameButton)
    {
        _startGameButton = [self homePageButtonWithTitle:@"开始游戏" tag:HomePageButtonStartGame];
    }
    return _startGameButton;
}

- (UIButton *)gameLevelButton
{
    if(!_gameLevelButton)
    {
        _gameLevelButton = [self homePageButtonWithTitle:@"游戏关卡" tag:HomePageButtonGameLevel];
    }
    return _gameLevelButton;
}

- (UIButton *)successRecordButton
{
    if(!_successRecordButton)
    {
        _successRecordButton = [self homePageButtonWithTitle:@"成功纪录" tag:HomePageButtonSuccessRecord];
    }
    return _successRecordButton;
}

- (UIButton *)homePageButtonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.backgroundColor = [UIColor greenColor];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    btn.tag = tag;
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(homePageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

#pragma mark - 设置
- (void)rightButtonClick
{
    WYSettingViewController *settingVC = [[WYSettingViewController alloc] init];
    
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - buttonClick
- (void)homePageButtonClick:(UIButton *)sender
{
    switch (sender.tag) {
        case HomePageButtonStartGame:
        {
            WYMainGameViewController *mainGameVC = [[WYMainGameViewController alloc] init];
            
            [self.navigationController pushViewController:mainGameVC animated:YES];
        }
            break;
        case HomePageButtonGameLevel:
        {
            WYGameLevelViewController *gameLevelVC = [[WYGameLevelViewController alloc] init];
            
            [self.navigationController pushViewController:gameLevelVC animated:YES];
        }
            break;
        case HomePageButtonSuccessRecord:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)startGame
{
    WYMainGameViewController *mainGameVC = [[WYMainGameViewController alloc] init];
    
    [self.navigationController pushViewController:mainGameVC animated:YES];
}

- (void)gameLevel
{
    WYGameLevelViewController *gameLevelVC = [[WYGameLevelViewController alloc] init];
    
    [self.navigationController pushViewController:gameLevelVC animated:YES];
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
