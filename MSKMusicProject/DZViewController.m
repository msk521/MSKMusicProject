//
//  DZViewController.m
//  MSKMusicProject
//
//  Created by msk on 13-9-2.
//  Copyright (c) 2013年 AHDZ. All rights reserved.
//

#import "DZViewController.h"

#define BDMUSIC @"百度音乐"
#define TDMUSIC @"土豆视频"
#define DLMUSIC @"音乐列表"
#define STMUSIC @"软件设置"

#define BDMUSICNav @"百度音乐盒"
#define TDMUSICNav @"土豆视频网"
#define DLMUSICNav @"音乐下载列表"
#define STMUSICNav @"软件设置中心"

@interface DZViewController (){
	NSArray *tabArr;
}

@end

@implementation DZViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.baiduCon = [[DZBaiduViewController alloc] init];
	self.baiduCon.navigationItem.title = BDMUSICNav;
	self.baiduNav = [[UINavigationController alloc] initWithRootViewController:self.baiduCon];
	self.baiduNav.tabBarItem.title = BDMUSIC;
	
	self.tudouCon = [[DZTudouViewController alloc] init];
	self.tudouCon.navigationItem.title = TDMUSICNav;
	self.tudouNav = [[UINavigationController alloc] initWithRootViewController:self.tudouCon];
	self.tudouNav.tabBarItem.title = TDMUSIC;
	
	self.downCon = [[DZDownLoadViewController alloc] init];
	self.downCon.navigationItem.title = DLMUSICNav;
	self.downNav = [[UINavigationController alloc] initWithRootViewController:self.downCon];
	self.downNav.tabBarItem.title = DLMUSIC;
	
	self.settingCon = [[DZSetingViewController alloc] init];
	self.settingCon.navigationItem.title = STMUSICNav;
	self.settingNav = [[UINavigationController alloc] initWithRootViewController:self.settingCon];
	self.settingNav.tabBarItem.title = STMUSIC;
	
	tabArr = [NSArray arrayWithObjects:self.baiduNav,self.tudouNav,self.downNav,self.settingNav, nil];
	self.viewControllers = tabArr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
