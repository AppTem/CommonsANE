//
//  CommonsANE.m
//  CommonsANE
//
//  Created by Emck on 3/17/15.
//  Copyright (c) 2015 AppTem. All rights reserved.
//

#import "CommonsANE.h"

static CommonsANE* CommonsANE_handler;          // CommonsANE主句柄

@interface CommonsANE ()

@end

@implementation CommonsANE
{
}

@synthesize context;

- (id)initWithContext:(FREContext)extensionContext
{
    self = [super init];
    if (self) self.context = extensionContext;
    return self;
}

// 将FREObject转成NSString
- (NSString*)getStringFromFREObject:(FREObject)obj
{
    uint32_t length;
    const uint8_t *value;
    FREGetObjectAsUTF8(obj, &length, &value);
    return [NSString stringWithUTF8String:(const char *)value];
}

// 将FREObject转成NSInteger
- (NSInteger)getNSIntegerFromFREObject :(FREObject)freObject
{
    int32_t asNumber = 0;
    FREObjectType   freObjectType = FRE_TYPE_NULL;
    FREGetObjectType(freObject, &freObjectType);
    
    assert(freObjectType == FRE_TYPE_NUMBER);
    
    if (freObjectType == FRE_TYPE_NUMBER) {
        FREGetObjectAsInt32(freObject, &asNumber);
    }
    return asNumber;
}

// boolean值生成FREObject
- (FREObject)getFREObjectFromNSString :(NSString *)String
{
	FREObject returnFREobject = NULL;
    if (String == nil || [String length] <=0) {
        NSString *temp = @"";
        FRENewObjectFromUTF8((int)strlen([temp UTF8String])+1, (const uint8_t*)[temp UTF8String], &returnFREobject);
    }
    else FRENewObjectFromUTF8((int)strlen([String UTF8String])+1, (const uint8_t*)[String UTF8String], &returnFREobject);
	return returnFREobject;
}

// boolean值生成FREObject
- (FREObject)getFREObjectFromBool :(BOOL)objcBool
{
	FREObject returnFREobject = NULL;
	FRENewObjectFromBool(objcBool, &returnFREobject);
	return returnFREobject;
}

- (void)dealloc
{
    #ifdef DEBUG
        NSLog(@"CommonsANE dealloc");
    #endif
    
    self.context = nil;     // 释放句柄
    [super dealloc];
}

@end


//////////////// 定义ANE的外部接口

// 初始化....
ANE_FUNCTION(CommonsSDKInit)
{
    #ifdef DEBUG
        NSLog(@"CommonsSDKInit....");
    #endif
    return [CommonsANE_handler getFREObjectFromBool:YES];           // 返回初始化成功
}

// 获取Apple IDFA
ANE_FUNCTION(CommonsGetIDFA)
{
    #ifdef DEBUG
        NSLog(@"CommonsSDK IDFA=%@",[CommonsSDK getIDFA]);
    #endif
    return [CommonsANE_handler getFREObjectFromNSString:[CommonsSDK getIDFA]];      // 返回IDFA
}

// 获取OpenUUID
ANE_FUNCTION(CommonsGetOpenUUID)
{
    #ifdef DEBUG
        NSLog(@"CommonsSDK OpenUUID=%@",[CommonsSDK getOpenUUID]);
    #endif
    return [CommonsANE_handler getFREObjectFromNSString:[CommonsSDK getOpenUUID]];      // 返回OpenUUID
}


/////////////////////////////////////
//////// Air的初始化接口 由extension.xml定义
void CommonsANEExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &CommonsANEContextInitializer;
    *ctxFinalizerToSet = &CommonsANEContextFinalizer;
}

void CommonsANEExtFinalizer(void* extData)
{
    return;
}

void CommonsANEContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    #ifdef DEBUG
        NSLog(@"CommonsANE ContextInitializer()");
    #endif
    static FRENamedFunction func[] =
    {
        MAP_FUNCTION(CommonsSDKInit, NULL),
        MAP_FUNCTION(CommonsGetIDFA, NULL),
        MAP_FUNCTION(CommonsGetOpenUUID, NULL),
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
    CommonsANE_handler = [[CommonsANE alloc] initWithContext:ctx];
}

void CommonsANEContextFinalizer(FREContext ctx)
{
    #ifdef DEBUG
        NSLog(@"CommonsANE ContextFinalizer()...");
    #endif
    if (CommonsANE_handler != nil) CommonsANE_handler = nil;
    return;
}