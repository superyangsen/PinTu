//
//  Define.h
//  PinTu
//
//  Created by 协力达 on 15/10/12.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define CURRENT_GAME_LEVEL  @"currentGameLevel" //当前游戏关卡
#define GAME_DIFFICULTY @"gameDifficulty"   //游戏难度

#define APPLICATION_SIZE [UIScreen mainScreen].applicationFrame.size
#define DEVICE_BOUNDS [UIScreen mainScreen].bounds
#define DEVICE_SIZE [UIScreen mainScreen].bounds.size
#define CONTROLLERVIEW_SIZE self.view.frame.size
#define VIEW_SIZE self.frame.size
#define DEVICE_OS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define DELTA_Y (DEVICE_OS_VERSION >= 7.0f? 20.0f : 0.0f)

#define color(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


#endif /* Define_h */
