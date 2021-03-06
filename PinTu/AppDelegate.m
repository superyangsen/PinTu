//
//  AppDelegate.m
//  PinTu
//
//  Created by 协力达 on 15/10/12.
//  Copyright © 2015年 wangyang. All rights reserved.
//

#import "AppDelegate.h"
#import "WYHomePageViewController.h"
#import "WYStartViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation AppDelegate

#pragma mark - 懒加载
- (UINavigationController *)homeNav
{
    if(!_homeNav)
    {
        _homeNav = [[UINavigationController alloc] initWithRootViewController:[[WYHomePageViewController alloc] init]];
    }
    return _homeNav;
}

- (UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, DEVICE_SIZE.height * 0.2, DEVICE_SIZE.width, 40)];
        
//        _titleLabel.hidden = YES;
        _titleLabel.text = @"益智拼图";
        _titleLabel.backgroundColor = [UIColor blueColor];
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
//    [UIView animateWithDuration:1 animations:^{
//        
//        self.titleLabel.hidden = NO;
//        
//    } completion:^(BOOL finished) {
//        
//        [self endAnimation];
////        [UIView animateWithDuration:1 animations:^{
////            
////            self.imgView.hidden = NO;
////            
////        } completion:^(BOOL finished) {
////            
////            [self endAnimation];
////        }];
//    }];
    
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
    [self.titleLabel removeFromSuperview];
    [self.imgView removeFromSuperview];
    
//    WYHomePageViewController *homePageVC = [[WYHomePageViewController alloc] init];
//    
//    UINavigationController *homePageNav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
    
    self.window.rootViewController = self.homeNav;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        NSLog(@"任务1");
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            
//            NSLog(@"任务2");
//        });
//        
//        NSLog(@"任务3");
//    });
//    NSLog(@"任务4");
////    while (1) {
////        
////    }
//    
//    NSLog(@"任务5");
//    
//    return YES;
    
    NSLog(@"%@", NSHomeDirectory());
    
    NSDictionary *photoDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GamePhoto" ofType:@"plist"]];
    
    NSString *thumbailPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"ThumbailPhoto"];
    
    if(![[NSFileManager defaultManager] isExecutableFileAtPath:thumbailPath])
    {
        if([[NSFileManager defaultManager] createDirectoryAtPath:thumbailPath withIntermediateDirectories:YES attributes:nil error:nil])
        {
            for (int i = 0; i < [photoDict allKeys].count; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%04d", i];
                NSString *fileName = [photoDict objectForKey:str];
                
                UIImage *image = [UIImage imageNamed:fileName];
                
                UIImage *thumbailImage = [[Helper sharedInstance] imageWithMaxSide:120 sourceImage:image];
                
                NSData *imageData = UIImageJPEGRepresentation(thumbailImage, 0);
                
                NSString *path = [NSString stringWithFormat:@"%@/%@", thumbailPath, fileName];
                
                [imageData writeToFile:path atomically:YES];
            }
        }

    }
    
    self.window.rootViewController = [[WYStartViewController alloc] init];
//    
//    [self.window addSubview:self.titleLabel];
//    [self.window addSubview:self.imgView];
//    
//    [self.window bringSubviewToFront:self.imgView];
//    [self.window bringSubviewToFront:self.titleLabel];
//    
//    [self startAnimation];
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    if([shortcutItem.type isEqualToString:@"com.wangyang.PinTu.startgame"])
    {
        WYHomePageViewController *homePageVC = [[WYHomePageViewController alloc] init];
        
        UINavigationController *homePageNav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
        
        self.window.rootViewController = homePageNav;
  
        [homePageVC startGame];
    }
    else if([shortcutItem.type isEqualToString:@"com.wangyang.PinTu.gamelevel"])
    {
        WYHomePageViewController *homePageVC = [[WYHomePageViewController alloc] init];
        
        UINavigationController *homePageNav = [[UINavigationController alloc] initWithRootViewController:homePageVC];
        
        self.window.rootViewController = homePageNav;
        
        [homePageVC gameLevel];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.wangyang.PinTu" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PinTu" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PinTu.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
