//
//  WYMainGameViewController.m
//  PinTu
//
//  Created by 协力达 on 15/10/12.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "WYMainGameViewController.h"
#import "UIImage+SubImage.h"
#import "WYGameImageView.h"

@interface WYMainGameViewController ()
<UIAlertViewDelegate>

@property (nonatomic, strong) UIView *navigationBar;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) NSMutableArray *numberArray;
@property (nonatomic, assign) NSInteger spaceNumber;
@property (nonatomic, assign) NSInteger rowNumber;

@end

@implementation WYMainGameViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _rowNumber = [[[NSUserDefaults standardUserDefaults] objectForKey:GAME_DIFFICULTY] integerValue] + 3;
    
//    UIImage *original = [UIImage imageNamed:@"original.jpg"];
    
    NSInteger index = [[[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_GAME_LEVEL] integerValue];
    
    NSDictionary *photoDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GamePhoto" ofType:@"plist"]];
    
    NSString *photoName = [photoDict objectForKey:[NSString stringWithFormat:@"%04d", index]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:photoName ofType:nil];
    
    NSData *orginalImageData = [NSData dataWithContentsOfFile:path];
    UIImage *orginalImage = [UIImage imageWithData:orginalImageData];
    
    NSArray *cropImages = [orginalImage cropImageWithRowNumber:_rowNumber];
  
    for (int cnt = 0; cnt < _rowNumber * _rowNumber; cnt++) {
        
        
        WYGameImageView *imageView = [[WYGameImageView alloc] initWithFrame:[self imageRectWithNumber:cnt + 1]];
        
        imageView.tag = cnt + 100;
        imageView.originalNumber = cnt + 1;
        imageView.currentNumber = cnt + 1;
        imageView.totalNumber = _rowNumber * _rowNumber;
        imageView.image = [cropImages objectAtIndex:cnt];
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.layer.borderWidth = 0.25;
        imageView.layer.shadowColor = [UIColor blackColor].CGColor;
        imageView.layer.shadowOffset = CGSizeMake(2, 2);
        imageView.layer.shadowOpacity = 1;
        imageView.layer.shadowRadius = 3;
        imageView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:imageView.bounds] CGPath];
        
        if(cnt == _rowNumber * _rowNumber - 1)
        {
            break;
        }
        
        [self.view addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction:)];
        
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        
        [self.imageViewArray addObject:imageView];
    }
    
    _spaceNumber = _rowNumber * _rowNumber;
    
    [self.view addSubview:self.navigationBar];
    
    [self randomImageLocation];
}

#pragma mark - 判断是否可以移动
- (BOOL)imageViewCanMoveWithImageNumber:(NSInteger)number
{
    NSInteger spaceJ = (_spaceNumber - 1) / _rowNumber;
    NSInteger spaceI = (_spaceNumber - 1) % _rowNumber;
    
    NSInteger j = (number - 1) / _rowNumber;
    NSInteger i = (number - 1) % _rowNumber;
    
    BOOL canMove = NO;
    
    if(j == spaceJ)
    {
        if(i == spaceI - 1 || i == spaceI + 1)
        {
            canMove = YES;
        }
    }
    else if(i == spaceI)
    {
        if(j == spaceJ - 1 || j == spaceJ + 1)
        {
            canMove = YES;
        }
    }
    
    return canMove;
}

#pragma mark - 随即图片位置
- (void)randomImageLocation
{
    for (int i = 0; i < self.imageViewArray.count; i++) {
        
        int n = arc4random() % self.imageViewArray.count;
        
        WYGameImageView *imageView = [self.imageViewArray objectAtIndex:n];
        
        NSInteger oldNumber = imageView.currentNumber;
        imageView.currentNumber = self.spaceNumber;
        self.spaceNumber = oldNumber;
        
        imageView.frame = [self imageRectWithNumber:imageView.currentNumber];
    }
    
    return;
    
    if(_rowNumber <= 3)
    {
        for (int i = 0; i < self.imageViewArray.count; i++) {
            
            int n = arc4random() % self.imageViewArray.count;
            
            WYGameImageView *imageView = [self.imageViewArray objectAtIndex:n];
            
            NSInteger oldNumber = imageView.currentNumber;
            imageView.currentNumber = self.spaceNumber;
            self.spaceNumber = oldNumber;
            
            imageView.frame = [self imageRectWithNumber:imageView.currentNumber];
        }
        
        return;
    }
    
    for (int i = 0; i < self.numberArray.count; i++) {
        
//        int n = (arc4random() % (self.numberArray.count - i)) + i;
        
        int n = arc4random() % self.imageViewArray.count;
        
        [self.numberArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }

    for (int i = 0; i < self.imageViewArray.count; i++) {
        
        WYGameImageView *imageView = [self.imageViewArray objectAtIndex:i];
        
        imageView.currentNumber = [[self.numberArray objectAtIndex:i] integerValue];
        
        imageView.frame = [self imageRectWithNumber:imageView.currentNumber];
    }
    
    _spaceNumber = [[self.numberArray lastObject] integerValue];
}

#pragma mark - 通过号码计算坐标
- (CGRect)imageRectWithNumber:(NSInteger)number
{
    CGRect rect;
    
    CGFloat subWidth = DEVICE_SIZE.width / _rowNumber;
    CGFloat subHeight = DEVICE_SIZE.height / _rowNumber;
    
    NSInteger j = (number - 1) / _rowNumber;
    NSInteger i = (number - 1) % _rowNumber;
    
    CGFloat x = subWidth * i;
    CGFloat y = subHeight * j;
    
    rect = CGRectMake(x, y, subWidth, subHeight);
    
    return rect;
}

#pragma mark - 拉加载
- (UIView *)navigationBar
{
    if(!_navigationBar)
    {
        _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, 40)];
        
        _navigationBar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        backBtn.frame = CGRectMake(10, 0, 40, 40);
        [backBtn setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_navigationBar addSubview:backBtn];
    }
    return _navigationBar;
}

- (NSMutableArray *)imageViewArray
{
    if(!_imageViewArray)
    {
        _imageViewArray = [[NSMutableArray alloc] init];
    }
    return _imageViewArray;
}

- (NSMutableArray *)numberArray
{
    if(!_numberArray)
    {
        _numberArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < _rowNumber * _rowNumber; i++) {
            
            NSNumber *number = [NSNumber numberWithInt:i + 1];
            
            [_numberArray addObject:number];
        }
    }
    return _numberArray;
}

#pragma mark - backButtonClick
- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击图片事件
- (void)imageViewTapAction:(UITapGestureRecognizer *)sender
{
    NSInteger index = sender.view.tag - 100;
    WYGameImageView *imageView = [self.imageViewArray objectAtIndex:index];
    
    if([self imageViewCanMoveWithImageNumber:imageView.currentNumber])
    {
        NSInteger oldNumber = imageView.currentNumber;
        imageView.currentNumber = self.spaceNumber;
        self.spaceNumber = oldNumber;
        
        for (int i = 0; i < _rowNumber * _rowNumber - 1; i++) {
            
            WYGameImageView *imgView = [self.imageViewArray objectAtIndex:i];
            
            if(imgView.currentNumber != imgView.originalNumber)
            {
                break;
            }
            
            if(i == _rowNumber * _rowNumber - 2)
            {
                [self gameSuccess];
            }
        }
        
        [UIView animateWithDuration:0.3 animations:^{
           
            imageView.frame = [self imageRectWithNumber:imageView.currentNumber];
        }];
    }
}

- (void)gameSuccess
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"恭喜过关" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSInteger level = [[[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_GAME_LEVEL] integerValue];
        
        level++;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:level] forKey:CURRENT_GAME_LEVEL];
    }];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}



#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
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
