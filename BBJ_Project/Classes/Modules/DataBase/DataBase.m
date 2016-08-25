//
//  DataBase.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/8/24.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "DataBase.h"
#import "CollectModel.h"
#import "PhotoCollectModel.h"

@implementation DataBase

static FMDatabaseQueue *_queue;

#pragma mark - 初始化，创建表
+(void)initialize
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"News.sqlite"];
    
    //创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    //创表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_news (id integer primary key autoincrement,title text,docid text,time text)"];
    }];
    
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_photos (id integer primary key autoincrement,title text,image_url text,image_width real,image_height_real,time text)"];
    }];
}

#pragma mark - 存数据
+ (void)addNews:(NSString *)title docid:(NSString *)docid time:(NSString *)time
{
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into t_news (title,docid,time) values(?,?,?)"];
    }];
}

#pragma mark - 图片数据
+ (void)addPhotoWithTitle:(NSString *)title image_url:(NSString *)image_url image_with:(NSString *)image_width image_height:(NSString *)image_length time:(NSString *)time
{
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into t_photos(title,image_url,image_width,image_height,time) values(?,?,?,?,?)",title,image_url,image_width,image_length,time];
    }];
}

#pragma mark - 现实数据
+ (NSMutableArray *)display
{
    __block NSMutableArray *dicArray = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from t_news"];
        while (rs.next) {
            NSString *title = [rs stringForColumn:@"title"];
            NSString *docid = [rs stringForColumn:@"docid"];
            NSString *time = [rs stringForColumn:@"time"];
            
            CollectModel *collectModel = [[CollectModel alloc] init];
            collectModel.time = time;
            collectModel.title = title;
            collectModel.docid = docid;
            
            [dicArray addObject:collectModel];
        }
    }];
    
    return dicArray;
}

+ (NSMutableArray *)basePhotoDisplay
{
    __block NSMutableArray *dicArray = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        dicArray = [NSMutableArray array];
        
        FMResultSet *rs = [db executeQuery:@"select * from t_photos"];
        
        while (rs.next) {
            
            NSString *title = [rs stringForColumn:@"title"];
            NSString *image_url = [rs stringForColumn:@"image_url"];
            CGFloat image_width = [[rs stringForColumn:@"image_width"] floatValue];
            CGFloat image_height = [[rs stringForColumn:@"image_height"] floatValue];
            NSString *time = [rs stringForColumn:@"time"];
            
            PhotoCollectModel *photomodel = [[PhotoCollectModel alloc]init];
            photomodel.title = title;
            photomodel.image_url = image_url;
            photomodel.image_width = image_width;
            photomodel.image_height = image_height;
            photomodel.time = time;
            
            [dicArray addObject:photomodel];
        }
    }];
    
    return dicArray;
}


//读取数据是否收藏
+(NSString *)queryWithCollect:(NSString *)docid
{
    __block NSString *str = @"0";
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select *from t_news where docid = ?;",docid];
        while (rs.next) {
            NSString *docid = [rs stringForColumn:@"docid"];
            NSLog(@"%@",docid);
            str = @"1";
        }
    }];
    return str;
}

//读取图片是否收藏
+(NSString *)queryWithCollectPhoto:(NSString *)photourl
{
    __block NSString *str = @"0";
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from t_photos where image_url = ?",photourl];
        while (rs.next) {
            NSString *docid = [rs stringForColumn:@"image_url"];
            NSLog(@"%@",docid);
            str = @"1";
        }
    }];
    return str;
}
//删除表
+ (void)deletetable
{
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeQuery:@"delete from t_news"];
    }];
}

//删除单条数据
+(void)deletetable:(NSString *)docid
{
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeQuery:@"delete from t_news where docid = ?",docid];
    }];
}

//删除图片单条数据
+(void)deletetableViewPhoto:(NSString *)photourl
{
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeQuery:@"delete from t_photos where image_url = ?",photourl];
    }];
}

@end


















