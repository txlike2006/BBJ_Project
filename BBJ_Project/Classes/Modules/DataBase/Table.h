//
//  Table.h
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/10/18.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#ifndef Table_h
#define Table_h
#import "DBDefine.h"

#define ST_DB_CREATE_BOOKCHAPTERINFO          @"CREATE TABLE IF NOT EXISTS bookChapterProgressInfo (bookId INTEGER,primaty key,bookName text,Chapter integer,SecChapter integer,currentPageIdex integer)"
#define ST_TB_CREATE_CFG                      @"CREATE TABLE IF NOT EXISTS readerCfg (cfgId  text , state INTEGER ,fontSize Single)"
#define ST_TB_CREATE_BOOKINFO                 @"CREATE TABLE IF NOT EXISTS bookInfoTable (bookId text primary key,file_version text,hot_sort text,pic text,name text,path text,time double)"


#endif /* Table_h */
