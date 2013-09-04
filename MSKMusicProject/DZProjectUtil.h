//
//  DZProjectUtil.h
//  MSKMusicProject
//
//  Created by msk on 13-9-3.
//  Copyright (c) 2013年 AHDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZProjectUtil : NSObject
//通过歌曲名字得到可以下载的歌曲信息
+(NSData *)dataByMusicName:(NSString *)musicName;
@end
