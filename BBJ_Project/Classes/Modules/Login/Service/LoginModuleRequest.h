//
//  LoginModuleRequest.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/4.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <Foundation/Foundation.h>

#define verificationUrl @"http://nginx002.hwcloud.huivo.net/api/v4/users/auth/request?"
#define loginUrl        @"http://nginx002.hwcloud.huivo.net/api/v4/users/auth/verify?"

@interface LoginModuleRequest : NSObject

+(void)getVerificationWithPhoneNum:(NSString *)phoneNum
                         succeeded:(SucceededCallback)succeeded
                            failed:(FailedCallback)failed;
+ (void)postLoginInfoWithPhoneNum:(NSString *)phoneNum
                        passCode:(NSString *)passCode
                       succeeded:(SucceededCallback)succeeded
                          failed:(FailedCallback)failed;

@end
