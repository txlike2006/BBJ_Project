//
//  STDBTool.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/10/18.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "STDBTool.h"

@implementation STDBTool

//单例
+(STDBTool *)shareInstance
{
    static STDBTool *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[STDBTool alloc] init];
    });
    
    return shareManager;
}
 -(instancetype)init
{
    if (self = [super init]) {
        NSFileManager *fmManager = [NSFileManager defaultManager];
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dbPath = [NSString stringWithFormat:@"%@/BookData.db",[paths count] > 0 ?paths.firstObject:nil];
        if (![fmManager fileExistsAtPath:dbPath]) {
            [fmManager createFileAtPath:dbPath contents:nil attributes:nil];
        }
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        self.dbQueue2 = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        self.dbQueue3 = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [self updateDbVersion:ST_DB_NEWVEWSION];
    }
    
    return self;
}

- (void)updateDbVersion:(NSInteger)newVersion{
    //执行数据库更新
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [self getCurrentDbVersion:db withBlock:^(BOOL bRet, int version) {
            if (bRet && (newVersion > version || newVersion == 0) ) {
                //如果本地数据库版本需要升级
                [self executeSQLList:[self setSqlArray] db:db withBlock:^(BOOL bRet, NSString *msg) {
                    if (bRet) {
                        //设置数据库版本号
                        [self setNewDbVersion:newVersion db:db withBlock:^(BOOL bRet) {
                            if (bRet)
                            {
                                NSLog(@"set new db version successfully!");
                            }
                        }];
                    }
                }];
            }
        }];
    }];

}

- (void)getCurrentDbVersion:(FMDatabase *)db withBlock:(void(^)(BOOL bRet,int version))block{
    NSString *sql = [NSString stringWithFormat:@"PRAGMA user_version"];
    FMResultSet *rs = [db executeQuery:sql];
    int nVersion = 0;
    while ([rs next]) {
        nVersion = [rs intForColumn:@"user_version"];
    }
    [rs close];
    if ([db hadError]) {
        NSLog(@"get db version Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        block(NO,-1);
        return;
    }
    block(YES,nVersion);
}

- (void)setNewVersion:(NSInteger)newVersion withBlock:(void(^)(BOOL bRET))block
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"PRAGMA user_version = %ld",(long)newVersion];
        BOOL ret = [db executeQuery:sql];
        if ([db hadError]) {
            
        }
        block(ret);
    }];
}

- (void)setNewDbVersion:(NSInteger)newVersion db:(FMDatabase *)db withBlock:(void(^)(BOOL bRet))block
{
    NSString *sql = [NSString stringWithFormat:@"PRAGMA user_version = %ld",(long)newVersion];
    BOOL bRet = [db executeQuery:sql];
    if ([db hadError]) {
        
    }
    block(bRet);
}

- (NSArray *)setSqlArray{
    NSMutableArray *sqlList = @[].mutableCopy;
    [sqlList addObject:ST_TB_CREATE_BOOKINFO];
    [sqlList addObject:ST_DB_CREATE_BOOKCHAPTERINFO];
    [sqlList addObject:ST_TB_CREATE_CFG];
    
    return sqlList;

}

/**
 *  @brief             执行单个sql语句 不需要使用事务处理 根据类型确定是否返回记录集
 *
 *  @param sqlStr      sql语句 select、update或者insert into语句
 *  @param actionType  表示操作的类型，ST_DB_SELECT：查询；ST_DB_INSERT：插入；ST_DB_UPDATE：更新；ST_DB_DELETE：删除；
 *  @param block       返回执行结果
 */
-(void)executeSQL:(NSString *)sqlStr actionType:(ST_DB_ActionType)actionType withBlock:(void (^)(BOOL, FMResultSet *, NSString *))block
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        if (actionType == ST_DB_SELECT) {
            FMResultSet * rs = [db executeQuery:sqlStr];
            if ([db hadError]) {
                block(NO,rs,[db lastErrorMessage]);
            }else{
                block(YES,rs,nil);
            }
        }else{
            BOOL ret = [db executeUpdate:sqlStr];
            if ([db hadError]) {
                block(NO,nil,[db lastErrorMessage]);
            }else{
                block(ret,nil,nil);
            }
        }
    }];
}

/**
 *  @brief             执行单个sql语句 不需要使用事务处理 根据类型确定是否返回记录集 使用dbQueue3，用于直接调用（不是封装在其他方法中）
 *
 *  @param sqlStr      sql语句 select、update或者insert into语句
 *  @param actionType  表示操作的类型，ST_DB_SELECT：查询；ST_DB_INSERT：插入；ST_DB_UPDATE：更新；ST_DB_DELETE：删除；
 *  @param block       返回执行结果
 */
- (void)executeQueue3Sql:(NSString *)sqlStr actionType:(ST_DB_ActionType)actionType withBlock:(void(^)(BOOL bRet,FMResultSet *rs,NSString *msg))block
{
    [_dbQueue3 inDatabase:^(FMDatabase *db) {
        if (actionType == ST_DB_SELECT) {
            FMResultSet *rs = [db executeQuery:sqlStr];
            if ([db hadError]) {
                block(NO,nil,[db lastErrorMessage]);
            }else{
                block(YES,rs,nil);
            }
        }else{
            BOOL ret = [db executeUpdate:sqlStr];
            if ([db hadError]) {
                block(NO,nil,[db lastErrorMessage]);
            }else{
                block(ret,nil,nil);
            }
        }
    }];
}

/**
 *  @brief          根据查询结果 确定是更新还是新增操作，只需要知道是否操作成功，不关心结果集 只处理一
 个查询更新，不需要事务处理
 *
 *  @param sqlList  sql语句数组，sqlList[0]查询select语句 sqList[1]update更新语句 sqlList[2] insert into 插入语句
 *  @param block    返回执行结果block
 */
- (void)executeRelevanceSql:(NSArray *)sqlList withBlock:(void(^)(BOOL ret,NSString *errMsg))block
{
    __block BOOL ret;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sqlList[0]];
        if ([db hadError]) {
            block(NO,[db lastErrorMessage]);
        }
        int nCount = 0;
        if ([rs next]) {
            nCount = [rs intForColumnIndex:0];
        }
        [rs close];
        
        NSString *nextSqlString = nil;
        if (nCount > 0) {
            nextSqlString = sqlList[1];
        }else{
            nextSqlString = sqlList[2];
        }
        
        ret = [db executeUpdate:nextSqlString];
        if ([db hadError]) {
            block(NO,[db lastErrorMessage]);
        }else{
            block(ret,nil);
        }
    }];
}

/**
 *  @brief          sqlList 是一个二维数组，每一个成员包含三个sql语句，分别是查询，更新，插入，并且
 据查询结果返回是执行更新 还是 插入操 作。使用dbQueue2 用于直接调用。批量处理，使用事务
 *
 *  @param sqlList  sql语句数组，sqlArr[i][0]：查询语句；sqlArr[i][1]：update语句；sqlArr[i][2]：insert into语句
 *  @param block    返回执行结果的block
 */
- (void)executeDbQueue2RelevanceTransactionSqlList:(NSArray *)sqlList withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block
{
    __block BOOL ret = NO;
    [_dbQueue2 inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSArray *singleSqlList in sqlList) {
            FMResultSet *rs = [db executeQuery:singleSqlList[0]];
            if ([db hadError]) {
                block(NO,[db lastErrorMessage],rollback);
            }else{
                int nCount = 0;
                while ([rs next]) {
                    nCount = [rs intForColumnIndex:0];
                }
                [rs close];
                
                NSString *nextSqlString = nil;
                if (nCount > 0) {
                    nextSqlString = singleSqlList[1];
                }else{
                    nextSqlString = singleSqlList[2];
                }
                
                ret = [db executeUpdate:nextSqlString];
                if ([db hadError]) {
                    block(NO,[db lastErrorMessage],rollback);
                }else{
                    
                }
            }
        }
        block(ret,nil,rollback);
    }];
}

/*
 *   @brief                               sql语句数组中每个成员有2条语句，第一条是select语句，第二
 条是insert into语句，
 根据第一个sql的执行结果确定执行第二条语句是否执行。
 根据查询结果确定是否新增，批量处理，不需要返回记录集
 使用dbQueue2，用于程序中直接调用（非封装在其他方法中）
 *
 *  @param  sqlArray                      sql语句数组，sqlArr[i][0]：查询语句；sqlArr[i][1]：insert into语句
 *
 *  @param  block                         返回执行结果的block
 */
-(void)executeInsertTransactionSqlList:(NSArray *)sqlStrList withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block
{
    __block BOOL ret = NO;
    [_dbQueue2 inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSArray *sqlArray in sqlStrList) {
            FMResultSet *rs = [db executeQuery:[sqlArray objectAtIndex:0]];
            if ([db hadError]) {
                block(NO,[db lastErrorMessage],rollback);
            }
            
            int nCount = 0;
            while ([rs next]) {
                nCount = [rs intForColumnIndex:0];
            }
            [rs close];
            
            if (nCount <= 0) {
                ret = [db executeUpdate:sqlArray[1]];
                if ([db hadError]) {
                    block(NO,[db lastErrorMessage],rollback);
                }
            }
        }
        block(ret,nil,rollback);
    }];
}

/*
 *  @brief                              sql语句数组中每个成员有2条语句，第一条是select语句，第二条是update语句，
 *                                      根据第一个sql的执行结果确定执行第二条语句是否执行。
 *                                      根据查询结果确定是否更新，批量处理，不需要返回记录集
 *                                      使用dbQueue2，用于程序中直接调用（非封装在其他方法中）
 *
 *  @param  sqlArray                    sql语句数组，sqlArr[i][0]：查询语句；sqlArr[i][1]：update语句
 *
 *  @param  block                       返回执行结果的block
 */
-(void)executeUpdateTransactionSqlList:(NSArray *)sqlStrList withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block
{
    __block BOOL ret = NO;
    [_dbQueue2 inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        for (NSArray *sqlArray in sqlStrList) {
            FMResultSet *rs = [db executeQuery:sqlArray[0]];
            if ([db hadError]) {
                block(NO,[db lastErrorMessage],rollback);
            }
            
            int nCount = 0;
            while ([rs next]) {
                nCount = [[rs objectForColumnName:@"numbers"] intValue];
            }
            [rs close];
            if (nCount > 0) {
                ret = [db executeUpdate:sqlArray[1]];
                if ([db hadError]) {
                    block(NO,[db lastErrorMessage],rollback);
                }
            }
        }
        block(ret,nil,rollback);
    }];
}

/*
 *  @brief                              批量处理更新或者新增sql语句，并且不需要返回记录集，使用事务处理
 *
 *  @param  sqlStrList                  sql语句数组update或者insert into语句
 *
 *  @param  block                       返回执行结果的block
 */
-(void)executeTransactionSqlList:(NSArray *)sqlStrList withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block
{
    __block BOOL bRet = NO;
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSString *sqlStr in sqlStrList) {
            bRet = [db executeUpdate:sqlStr];
            if ([db hadError]) {
                block(bRet,[db lastErrorMessage],rollback);
                break;
            }
        }
        block(bRet,nil,rollback);
    }];
}

/*
 *  @brief                              批量处理更新或者新增sql语句，并且不需要返回记录集 使用dbQueue2 防止嵌套 死循环
 *
 *  @param  sqlStrArr                   sql语句数组update或者insert into语句
 *
 *  @param  block                       返回执行结果的block
 */
-(void)executeDbQueue2TransactionSqlList:(NSArray *)sqlStrArr withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block
{
    __block BOOL bRet = NO;
    [_dbQueue2 inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSString *sqlStr in sqlStrArr) {
            bRet = [db executeUpdate:sqlStr];
            if ([db hadError]) {
                block(bRet,[db lastErrorMessage],rollback);
                break;
            }
        }
        
        block(bRet,nil,rollback);
    }];
}

/**
 *  @brief                  批量处理更新或者新增sql语句，不需要返回记录集  无事务处理
 *
 *  @param sqlStrList       sql语句数组update或者insert into语句
 *  @param db               FMDatabase数据库对象
 *  @param block            返回执行结果的block
 */

- (void)executeSQLList:(NSArray *)sqlStrList db:(FMDatabase *)db withBlock:(void(^)(BOOL bRet, NSString *msg))block
{
    __block BOOL bRet = NO;
    for (NSString * sqlString in sqlStrList) {
        bRet = [db executeUpdate:sqlString];
        if ([db hadError]) {
            block(bRet,[db lastErrorMessage]);
            NSLog(@"executeSQLList Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            break;
        }
    }
    block(bRet,nil);
}

/**
 *  @brief                  批量处理更新或者新增sql语句，不需要返回记录集  无事务处理
 *
 *  @param sqlStrList       sql语句数组update或者insert into语句
 *  @param block            返回执行结果的block
 */
- (void)executeSQLList:(NSArray *)sqlStrList  withBlock:(void(^)(BOOL bRet, NSString *msg))block
{
    __block BOOL bRet = NO;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        for (NSString *sqlStr in sqlStrList) {
            bRet = [db executeUpdate:sqlStr];
            if ([db hadError]) {
                block(bRet,[db lastErrorMessage]);
                break;
            }
        }
    }];
    block(bRet,nil);
}

@end
