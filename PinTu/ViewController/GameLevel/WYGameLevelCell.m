//
//  WYGameLevelCell.m
//  PinTu
//
//  Created by 协力达 on 15/10/14.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "WYGameLevelCell.h"

@implementation WYGameLevelCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.imgView];
    }
    return self;
}

- (UIImageView *)imgView
{
    if(!_imgView)
    {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _imgView;
}

@end
