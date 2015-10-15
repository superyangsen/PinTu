//
//  UIImage+SubImage.m
//  PinTu
//
//  Created by 协力达 on 15/10/12.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "UIImage+SubImage.h"

@implementation UIImage (SubImage)

- (NSArray *)cropImageWithRowNumber:(NSInteger)rowNumber
{
    NSMutableArray *cropImages = [NSMutableArray array];
    
    for (int i = 0, j = 0, cnt = 0; cnt < rowNumber * rowNumber; cnt++) {
        
        CGFloat subWidth = self.size.width / rowNumber;
        CGFloat subHeight = self.size.height / rowNumber;
        CGFloat x = subWidth * i;
        CGFloat y = subHeight * j;
        
        CGRect cropRect = CGRectMake(x, y, subWidth, subHeight);
        
        UIImage *cropImage = [self imageByCroppingWithRect:cropRect];
        
        [cropImages addObject:cropImage];
        
        i++;
        if( i == rowNumber )
        {
            i = 0;
            j++;
        }
    }
    
    return cropImages;
}

- (UIImage *)imageByCroppingWithRect:(CGRect)rect
{
    CGImageRef imageRef = self.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *cropImage = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    
    return cropImage;
}

@end
