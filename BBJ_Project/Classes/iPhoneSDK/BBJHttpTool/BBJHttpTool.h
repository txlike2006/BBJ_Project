//
//  BBJHttpTool.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/4.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SucceededCallback)(NSDictionary *resultOject);
typedef void(^SucceededArrayCallback) (NSDictionary *resultOject);
typedef void(^FailedCallback) (NSError *error);

@interface BBJHttpTool : NSObject

+ (instancetype)sharedNetWorkManager;

/// Post object and get response to server api
- (void)postObject:(NSDictionary *)object
            toPath:(NSString *)path
         succeeded:(SucceededCallback)succeeded
            failed:(FailedCallback)failed;

/// Get object and get response to server api
- (void)getObject:(NSString *)url
        succeeded:(SucceededCallback)succeeded
           failed:(FailedCallback)failed;

/// Get object with parameter
- (void)getObject:(NSString *)url
        parameter:(NSDictionary *)parameter
        succeeded:(SucceededCallback)succeeded
           failed:(FailedCallback)failed;

///Delete object and get response to server api
- (void)deleteObject:(NSString *)url
           succeeded:(SucceededCallback)succeeded
              failed:(FailedCallback)failed;

/// Download file from server
- (void)downloadFile:(NSString *)savingPath
            fromPath:(NSString *)webPath
           succeeded:(void (^)(void))succeeded
              failed:(void (^)(void))failed;


@end
