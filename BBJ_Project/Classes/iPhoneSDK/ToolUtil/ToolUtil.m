//
//  ToolUtil.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/5.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "ToolUtil.h"
#import "SSKeychain.h"

#define KeyChain    @"UDID"
#define KeyService  @"com.baobeijia_parent.chain"

@implementation ToolUtil

/**
 *  获取设备id
 *
 *  @return 设备ID
 */
+ (NSString*)getDeviceIdentifies
{
    NSString *retrieveuuid = [SSKeychain passwordForService:KeyService account:KeyChain];
    
    if (!retrieveuuid || [retrieveuuid isEqualToString:@""]) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        assert(uuid != NULL);
        
        retrieveuuid = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuid));
        [SSKeychain setPassword: [NSString stringWithFormat:@"%@", retrieveuuid]
                     forService:KeyService account:KeyChain];
        CFRelease(uuid);
    }
    
    return retrieveuuid;
}

@end
