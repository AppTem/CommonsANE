//
//  CommonsSDK.h
//  CommonsSDK
//
//  Created by Emck on 03/17/15.
//  Copyright (c) 2015 AppTem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonsSDK : NSObject

//// 获取静态实例
//+ (CommonsSDK*)defaultInstance;

// 获取Apple IDFA
+ (NSString *)getIDFA;

// 获取OpenUUID
+ (NSString *)getOpenUUID;

@end