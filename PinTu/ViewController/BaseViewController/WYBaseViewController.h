//
//  BaseViewController.h
//  PinTu
//
//  Created by 协力达 on 15/10/12.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Define.h"
#import "Helper.h"

@interface WYBaseViewController : UIViewController

@property (nonatomic, strong) AppDelegate *appDelegate;

/**
 设置title
 */
- (void)setNavgationBarTitle:(NSString *)title;

/**
 设置左键
 */
- (void)setLeftBtnTitle:(NSString *)title imageStr:(NSString *)imageStr;

/**
 设置右键
 */
- (void)setRightBtnTitle:(NSString *)title imageStr:(NSString *)imageStr;

/**
 设置返回键
 */
- (void)setBackBtnTitle:(NSString *)title imageStr:(NSString *)imageStr;

- (void)leftButtonClick;

- (void)rightButtonClick;

- (void)backButtonClick;


/**
 显示提示信息
 */
- (void)showMessageWithMessage:(NSString *)message;

@end
