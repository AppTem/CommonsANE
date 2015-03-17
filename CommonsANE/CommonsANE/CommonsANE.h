//
//  CommonsANE.h
//  CommonsANE
//
//  Created by Emck on 3/17/15.
//  Copyright (c) 2015 AppTem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

#import <CommonsSDK/CommonsSDK.h>

#define ANE_FUNCTION(f) FREObject (f)(FREContext ctx, void *data, uint32_t argc, FREObject argv[])
#define MAP_FUNCTION(f, data) { (const uint8_t*)(#f), (data), &(f) }


@interface CommonsANE : NSObject

@property (nonatomic, assign) FREContext context;

@end

/////// ObjectC本地方法列表
ANE_FUNCTION(CommonsSDKInit);                       // 初始化
ANE_FUNCTION(CommonsGetIDFA);                       // 获取Apple IDFA
ANE_FUNCTION(CommonsGetOpenUUID);                   // 获取OpenUUID


void CommonsANEExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

void CommonsANEExtFinalizer(void* extData);

void CommonsANEContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

void CommonsANEContextFinalizer(FREContext ctx);