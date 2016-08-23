//
//  BBJHttpTool.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/4.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "BBJHttpTool.h"

@interface BBJHttpTool()
@property (strong,nonatomic) AFHTTPSessionManager *mgr;
@property (strong,nonatomic) AFNetworkReachabilityManager *ability;
@property (assign,nonatomic) BOOL returnStatus;
@end

@implementation BBJHttpTool

static NSString * const BaseURLString = @"";
static BBJHttpTool *instance = nil;

+ (instancetype)sharedNetWorkManager
{
    @synchronized (self) {
        if (instance == nil) {
            instance = [[super allocWithZone:nil]init];
            instance.mgr = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:BaseURLString]];
            instance.mgr.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
            instance.ability = [AFNetworkReachabilityManager sharedManager];
            instance.returnStatus = NO;
            instance.mgr.responseSerializer = [AFJSONResponseSerializer serializer];
            instance.mgr.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html",@"application/json", nil];
            [instance addListener];
        }
    }
    return instance;
    
}

/// Post object and get response to server api
- (void)postObject:(NSDictionary *)object
            toPath:(NSString *)path
         succeeded:(SucceededCallback)succeeded
            failed:(FailedCallback)failed
{
   
}
/// Get object and get response to server api
- (void)getObject:(NSString *)url
        succeeded:(SucceededCallback)succeeded
           failed:(FailedCallback)failed
{
   
    //send get request
    [self.mgr GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeeded(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
    
}

/// Get object with parameter
- (void)getObject:(NSString *)url
        parameter:(NSDictionary *)parameter
        succeeded:(SucceededCallback)succeeded
           failed:(FailedCallback)failed
{
    //send get request
    [self.mgr GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeeded(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}


///Delete object and get response to server api
- (void)deleteObject:(NSString *)url
           succeeded:(SucceededCallback)succeeded
              failed:(FailedCallback)failed
{
    
}

/// Download file from server
- (void)downloadFile:(NSString *)savingPath
            fromPath:(NSString *)webPath
           succeeded:(void (^)(void))succeeded
              failed:(void (^)(void))failed
{
    
}

- (void)addListener{
    [self.ability startMonitoring];
    __weak typeof(self) weakSelf = self;
    [instance.ability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                weakSelf.returnStatus = false;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                weakSelf.returnStatus = false;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                weakSelf.returnStatus = true;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                weakSelf.returnStatus = true;
                break;
            default:
                break;
        }
    }];
}


@end
