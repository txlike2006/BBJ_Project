//  Created by  on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#ifndef HUIWOBAO_AllConstDefine_h
#define HUIWOBAO_AllConstDefine_h


//常用 宏定义 －－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
#define kWindowFrame           [[UIScreen mainScreen] bounds]
#define kWindowWidth           [[UIScreen mainScreen] bounds].size.width
#define kWindowHeight          [[UIScreen mainScreen] bounds].size.height
#define kWindowSize            [UIScreen mainScreen].bounds.size
#define kMarginWith            10

#define kTipsTopOffset         70

#define kStatusBarAdapterHeight   ([[[UIDevice currentDevice] systemVersion] floatValue] >=  7.0 ? 20 : 0)
#define DEVICE_IS_IOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]<8)

//常用 font －－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

#define kUIFONT_12 [UIFont systemFontOfSize:12]
#define kUIFONT_13 [UIFont systemFontOfSize:13]
#define kUIFONT_14 [UIFont systemFontOfSize:14]
#define kUIFONT_15 [UIFont systemFontOfSize:15]
#define kUIFONT_16 [UIFont systemFontOfSize:16]
#define kUIFONT_18 [UIFont systemFontOfSize:18]


//自动计算行高
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    #define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
        boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
        attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
    #define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
        sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

// Reused colors
#define kHVViewBGColor      (0xededed)

//字数限制  －－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
#define MAX_NUMBER_OF_INPUT 40


//常用 color －－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


//如果是null 就改成 @""
#define NULL_TO_NIL(object) ([object isKindOfClass:[NSNull class]] ? (@"") : (object))
 
//-------------------------------------------日志打印------------------------------------------------------------------
#ifdef DEBUG
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#       define DLog(...)
#endif

//数据持久化－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
#define USER_STATUS_DB_PATH     ([NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/status.db",[defaults objectForKey:UDKEY_USER_ID]]])
#define STATUS_UNREAD_PATH      ([ToolUtil getConfigFile:[NSString stringWithFormat:@"%@/statusur.plist",[defaults objectForKey:UDKEY_USER_ID]]])

//userdefaults UDKEY_ 开头命名
#define defaults    [NSUserDefaults standardUserDefaults]

#define UDKEY_USER_ID             @"UDKEY_USER_ID"
#define UDKEY_LOGIN               @"UDKEY_LOGIN"
#define UDKEY_LAST_BUILD_VERSION  @"UDKEY_LAST_BUILD_VERSION"
#define UDKEY_TOKEN               @"UDKEY_TOKEN"
#define UDKEY_SESSION_ID          @"UDKEY_SESSION_ID"
#define UDKEY_IS_FIRST_LAUNCH     @"UDKEY_IS_FIRST_LAUNCH"
#define UDKEY_NEW_GUIDE           @"UDKEY_NEW_GUIDE"
#define UDKEY_USER_ROLE           @"UDKEY_USER_ROLE" //1 普通老师 2班主任 3班主任加管理员 4管理员 5家长
#define UDKEY_LOGIN_MOBILE        @"UDKEY_LOGIN_MOBILE"

#define UDKEY_CLIENT_TYPE         @"UDKEY_CLIENT_TYPE"
#define UDKEY_MOBILE              @"UDKEY_MOBILE"
#define UDKEY_SECURE_MOBILE       @"UDKEY_SECURE_MOBILE" //安全号码
#define UDKEY_USER_NAME           @"UDKEY_USER_NAME"
#define UDKEY_NICK_NAME           @"UDKEY_NICK_ANME"
#define UDKEY_USER_SEX            @"UDKEY_USER_SEX"
#define UDKEY_AVATAR_URL          @"UDKEY_AVATAR_URL"
#define UDKEY_HAVE_KID            @"UDKEY_HAVE_KID"    //是否有kid
#define UDKEY_NUM_FAV_PHOTO       @"UDKEY_NUM_FAV_PHOTO"
#define UDKEY_NUM_TOTAL_FLOWERS   @"UDKEY_NUM_TOTAL_FLOWERS"
#define UDKEY_NUM_TOTAL_LEAVES    @"UDKEY_NUM_TOTAL_LEAVES"

#define UDKEY_IS_HAVE_CLASS       @"UDKEY_IS_HAVE_CLASS"//是否有班级，是否有邀请和申请信息
#define UDKEY_IS_INVITE_CLASS     @"UDKEY_IS_INVITE_CLASS" //是否有邀请和申请信息

#define UDKEY_NOTIFICATION_TOKEN  @"UDKEY_NOTIFICATION_TOKEN" //推送token
#define UDKEY_HAS_UNREAD_NOTIFY   @"UDKEY_HAS_UNREAD_NOTIFY"
#define UDKEY_HAS_UNREAD_NOTICE   @"UDKEY_HAS_UNREAD_NOTICE"
#define UDKEY_HAS_UNREAD_STATUS   @"UDKEY_HAS_UNREAD_STATUS"
#define UDKEY_HAS_UNREAD_ACCELERATE  @"UDKEY_HAS_UNREAD_ACCELERATE"
#define UDKEY_HAS_UNREAD_PAYMENT  @"UDKEY_HAS_UNREAD_PAYMENT"
#define UDKEY_WIFIUPLOADSET       @"UDKEY_WIFIUPLOADSET"
#define UDKEY_ISWIFIUPLOADPHOTO   @"UDKEY_ISWIFIUPLOADPHOTO"

// VIP accounts
#define UDKEY_IS_VIP_ACCOUNT      @"UDKEY_IS_VIP_ACCOUNT"

// Reachability
#define UDKEY_NETWORK_REACHABLE   @"UDKEY_NETWORK_REACHABLE"
#define UDKEY_NETWORK_REACHLEVEL  @"UDKEY_NETWORK_REACHLEVEL"

// Debugging
#define UDKEY_ROUTE_HOST_GROUP    @"UDKEY_ROUTE_HOST_GROUP"

// PaymentState
#define UDKEY_PAYMENT_STATE_END   @"UDKEY_PAYMENT_STATE_END"

//通知 都以  NNKEY_  开头命名
#define NNKEY_NETWORK_HAVE_CHANGE_NOTIFICATION     @"NNKEY_NETWORK_HAVE_CHANGE_NOTIFICATION" //网络通知0为无网,1为2G/3G
#define NNKEY_UPDATE_HOMEMODEL_UNREAD_MESSAGE      @"NNKEY_UPDATE_HOMEMODEL_UNREAD_MESSAGE"  //更新模块未读消息数
#define NNKEY_CHANGE_PROFILE_LOCATION              @"NNKEY_CHANGE_PROFILE_LOCATION"//更换profile页的地区

// app delegate ref
#define AppDelegate_Ref ((HuivoSwiftParentAppDelegate *)[[UIApplication sharedApplication] delegate])

/*文件时保存的路径*/
#define vGlobalSocketIDSSavePath        ([ToolUtil getConfigFile:[NSString stringWithFormat:@"%@/SocketACK.plist",[defaults objectForKey:UDKEY_USER_ID]]])
#define noticeReceivedSavePath          ([ToolUtil getConfigFile:[NSString stringWithFormat:@"%@/ReceivedNotices.plist",[defaults objectForKey:UDKEY_USER_ID]]])

#define PUSH_ACCESS_ID 2200090303
#define PUSH_ACCESS_KEY @"I8V512YWI8GH"

// 用户行为统计
#define USER_TRACK(e, l)        [ToolUtil reportEvent:e label:l]
#define USER_TRACK_E(e)         [ToolUtil reportEvent:e]
#define USER_TRACK_P(e, l, p)   [ToolUtil reportEvent:e label:l parameter:p]
#define USER_TRACK_E_P(e, p)    [ToolUtil reportEvent:e parameter:p]

//统计模块  ----------------------------------------------
#define APPLICATION_FIRST_COUNTED  @"APPLICATION_FIRST_COUNTED" //app 首次启动次数

// Payment
enum HVPaymentResult {
    HVPR_SUCCEEDED = 0,
    HVPR_FAILED = 1,
    HVPR_USER_CANCELED = 2,
};

/// constants
#define HV_GENDER_MALE          @"m"
#define HV_GENDER_FEMALE        @"f"

#define kHVLatestTimestamp      0x7FFFFFFFFFFFFFFF

/// Model properties
#define MODEL_KEY_NOTICE_IS_READ        @"is_read"
#define MODEL_KEY_STATUS                @"status"

#define I_WANT_PAY_ENTER_PAYVC                  @"me"
#define HOME_EXPERIENCE_PAY_ENTER_PAYVC         @"home_experience_pay"
#define HOME_DEADLINE_PAY_ENTER_PAYVC           @"home_deadline_pay"
#define HOME_FORCE_PAY_ENTER_PAYVC              @"home_force_pay"
#define ALERT_VIEW_PAY_ENTER_PAYVC              @"activity_detail_force_pay"

#define NEW_FUNCTION_USER_GUIDE                 @"new_function_user_guide"

#define FIRST_PRRIMARY_CLASS                    @"FIRST_PRIMARY_CLASS"
#define FIRST_MIDDLE_CLASS                      @"FIRST_MIDDLE_CLASS"
#define FIRST_HIGH_CLASS                        @"FIRST_HIGH_CLASS"

// remember index of kid
#define HV_CURRENT_KID                          @"HV_CURRENT_KID"

#endif
