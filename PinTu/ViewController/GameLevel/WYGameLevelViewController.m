//
//  WYGameLevelViewController.m
//  PinTu
//
//  Created by 协力达 on 15/10/12.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "WYGameLevelViewController.h"
#import "WYMainGameViewController.h"
#import "WYGameLevelCell.h"

@interface WYGameLevelViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WYGameLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavgationBarTitle:@"游戏关卡"];
    [self setBackBtnTitle:nil imageStr:nil];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if(!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat itemWidth = (DEVICE_SIZE.width - 10 * 4) / 4;
        CGFloat itemHeight = itemWidth * 568.0f / 320.0f;
        CGFloat widthSpace = 10;
        NSInteger ycount = (DEVICE_SIZE.height - 64) / itemHeight;
        
        CGFloat space = DEVICE_SIZE.height - 64 - itemHeight * ycount;
        
        CGFloat heightSpace = 10;;
        
        if(heightSpace * (ycount + 1) > space)
        {
            ycount--;
            space = DEVICE_SIZE.height - 64 - itemHeight * ycount;
//            heightSpace = space / (ycount + 1);
        }
        
        CGFloat bottomSpace = space - heightSpace * (ycount + 1);
        
        layout.sectionInset = UIEdgeInsetsMake(10, widthSpace / 2.0f, bottomSpace, widthSpace / 2.0f);
        layout.minimumLineSpacing = widthSpace;
        layout.minimumInteritemSpacing = 10;
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.height - 64) collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[WYGameLevelCell class] forCellWithReuseIdentifier:@"cell"];
        
        NSDictionary *photoDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GamePhoto" ofType:@"plist"]];
        NSInteger page = [photoDict allKeys].count / (4 * ycount);
        
        if([[photoDict allKeys] count] % (4 * ycount) != 0)
        {
            page++;
        }
        
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.bounces = NO;
        _collectionView.contentSize = CGSizeMake(DEVICE_SIZE.width * page, DEVICE_SIZE.height - 64);
        
    }
    return _collectionView;
}

- (NSMutableArray *)imageViewArray
{
    if(!_imageViewArray)
    {
        _imageViewArray = [[NSMutableArray alloc] init];
    }
    return _imageViewArray;
}

- (NSMutableArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc] init];
        
        NSDictionary *photoDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GamePhoto" ofType:@"plist"]];
        NSString *thumbailPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"ThumbailPhoto"];
        
        for (int i = 0; i < [[photoDict allKeys] count]; i++) {
            
            NSString *fileName = [photoDict objectForKey:[NSString stringWithFormat:@"%04d", i]];
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", thumbailPath, fileName];

            [_dataArray addObject:filePath];
        }
    }
    return _dataArray;
}

- (UIScrollView *)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.height - 64)];
        
        NSDictionary *photoDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GamePhoto" ofType:@"plist"]];
        NSString *thumbailPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"ThumbailPhoto"];
        
        CGFloat space = 5;
        CGFloat imageWidth = (DEVICE_SIZE.width - 4 * space * 2) / 4;
        CGFloat imageHeight = 586.0f / 320.0f * imageWidth;
        
        int i = 0, j = 0, k = 0;
        for (int cnt = 0; cnt < [photoDict allKeys].count; cnt++) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(k * DEVICE_SIZE.width + space + i * (imageWidth + 2 * space), space * 2 + j * (imageHeight + space * 2), imageWidth, imageHeight)];
            
            imageView.tag = cnt + 100;
            NSString *fileName = [photoDict objectForKey:[NSString stringWithFormat:@"%04d", cnt]];
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", thumbailPath, fileName];
            
            NSData *thumbailImageData = [NSData dataWithContentsOfFile:filePath];
            UIImage *thumbailImage = [UIImage imageWithData:thumbailImageData];
    
            imageView.image = thumbailImage;
            
            [_scrollView addSubview:imageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
            
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            
            [self.imageViewArray addObject:imageView];
            
            i++;
            if(i == 4)
            {
                i = 0;
                j++;
                
                if((space * 2 + imageHeight) * (j + 1) > DEVICE_SIZE.height - 64)
                {
                    j = 0;
                    k++;
                }
            }
        }
        
        CGFloat width = 0;
    
        if(i == 0 && j == 0)
        {
            width = k * DEVICE_SIZE.width;
        }
        else
        {
            width = (k + 1) * DEVICE_SIZE.width;
        }
        
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(width, DEVICE_SIZE.height - 64);
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)imageTapAction:(UITapGestureRecognizer *)sender
{
    NSInteger index = sender.view.tag - 100;
  
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:index] forKey:CURRENT_GAME_LEVEL];
    
    WYMainGameViewController *mainGameVC = [[WYMainGameViewController alloc] init];
    
    [self.navigationController pushViewController:mainGameVC animated:YES];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WYGameLevelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSData *thumbailImageData = [NSData dataWithContentsOfFile:[self.dataArray objectAtIndex:indexPath.row]];
    UIImage *thumbailImage = [UIImage imageWithData:thumbailImageData];
    
    cell.imgView.image = thumbailImage;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:indexPath.row] forKey:CURRENT_GAME_LEVEL];
    
    WYMainGameViewController *mainGameVC = [[WYMainGameViewController alloc] init];
    
    [self.navigationController pushViewController:mainGameVC animated:YES];

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
