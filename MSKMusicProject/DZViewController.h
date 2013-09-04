//
//  DZViewController.h
//  MSKMusicProject
//
//  Created by msk on 13-9-2.
//  Copyright (c) 2013年 AHDZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DZBaiduViewController.h"
#import "DZTudouViewController.h"
#import "DZDownLoadViewController.h"
#import "DZSetingViewController.h"

@interface DZViewController : UITabBarController

@property (strong, nonatomic) UINavigationController *baiduNav;
@property (strong, nonatomic) UINavigationController *tudouNav;
@property (strong, nonatomic) UINavigationController *downNav;
@property (strong, nonatomic) UINavigationController *settingNav;

@property (strong, nonatomic) DZBaiduViewController *baiduCon;
@property (strong, nonatomic) DZTudouViewController *tudouCon;
@property (strong, nonatomic) DZDownLoadViewController *downCon;
@property (strong, nonatomic) DZSetingViewController *settingCon;

@end
