//
//  UserInfoEntity.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/5.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "HVEntity.h"
@interface UserInfoEntity : HVEntity

@property (nonatomic ,copy) NSString *auth_token;
@property (nonatomic ,copy) NSString *avatar_url;
@property (nonatomic ,copy) NSString *gender;
@property (nonatomic ,copy) NSString *is_active;
@property (nonatomic ,copy) NSString *phone_no;
@property (nonatomic ,copy) NSString *secure_phone_no;
@property (nonatomic ,copy) NSString *session_id;
@property (nonatomic ,copy) NSString *user_id;
@property (nonatomic ,copy) NSString *user_name;
@property (nonatomic ,copy) NSString *vip;

@end
