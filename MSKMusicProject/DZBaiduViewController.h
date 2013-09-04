//
//  DZBaiduViewController.h
//  MSKMusicProject
//
//  Created by msk on 13-9-2.
//  Copyright (c) 2013年 AHDZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZBaiduViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,NSXMLParserDelegate>{
}
@property (strong ,nonatomic) UISearchBar *searchBar;
@end
