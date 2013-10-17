//
//  DZMusicModel.h
//  MSKMusicProject
//
//  Created by msk on 13-9-5.
//  Copyright (c) 2013年 AHDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZMusicModel : NSObject
@property(nonatomic,copy)NSString *fileID;
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,copy)NSString *fileSize;
@property(nonatomic)BOOL isFistReceived;//是否是第一次接受数据，如果是则不累加第一次返回的数据长度，之后变累加
@property(nonatomic,copy)NSString *fileReceivedSize;
@property(nonatomic,retain)NSMutableData *fileReceivedData;//接受的数据
@property(nonatomic,copy)NSString *fileURL;
@property(nonatomic)BOOL isDownloading;//是否正在下载
@property(nonatomic)BOOL isP2P;//是否是p2p下载
@end
