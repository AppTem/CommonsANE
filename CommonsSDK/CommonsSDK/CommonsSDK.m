//
//  CommonsSDK.m
//  CommonsSDK
//
//  Created by Emck on 03/17/15.
//  Copyright (c) 2015 AppTem. All rights reserved.
//

#import "CommonsSDK.h"
#import "OpenUDID.h"

#import <AdSupport/AdSupport.h>

//static CommonsSDK *CommonsSDKInit = nil;

@implementation CommonsSDK

//// 获取静态实例
//+ (CommonsSDK*)defaultInstance
//{
//    if (CommonsSDKInit != nil) return CommonsSDKInit;
//    else {
//        CommonsSDKInit = [[CommonsSDK alloc] init];
//        return CommonsSDKInit;
//    }
//}

// 获取Apple IDFA
+ (NSString *)getIDFA
{
    @try {
        ASIdentifierManager *Manager = [ASIdentifierManager sharedManager];
        if (Manager == nil) return @"";
        else {
            NSUUID *nsuuid = [Manager advertisingIdentifier];
            if (nsuuid == nil) return @"";
            else return [nsuuid UUIDString];
        }
    }
    @catch (NSException *ex) {
        return @"";
    }
}

// 获取OpenUUID
+ (NSString *)getOpenUUID
{
    @try {
        NSString* openUDID = [OpenUDID value];
        if (openUDID == nil) return @"";
        else return openUDID;
    }
    @catch (NSException *ex) {
        return @"";
    }
}

@end