//
//  LoginModuleRequest.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/4.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "LoginModuleRequest.h"

@implementation LoginModuleRequest

+(void)getVerificationWithPhoneNum:(NSString *)phoneNum
                    succeeded:(SucceededCallback)succeeded
                       failed:(FailedCallback)failed
{
    NSString *str = [NSString stringWithFormat:@"%@phone_no=%@&client_type=parent",verificationUrl,phoneNum];
   
}

+ (void)postLoginInfoWithPhoneNum:(NSString *)phoneNum
                        passCode:(NSString *)passCode
                       succeeded:(SucceededCallback)succeeded
                          failed:(FailedCallback)failed
{
    NSString *str = loginUrl;
    NSString *deviceId = [ToolUtil getDeviceIdentifies];
    NSDictionary *param = @{@"client_type":@"parent",
                            @"phone_no":phoneNum,
                            @"code":passCode,
                            @"device_id":deviceId};
   
}

@end
