//
//  DBController.h
//  SelectCity
//
//  Created by MoJolt on 10/22/13.
//  Copyright (c) 2013 SVAPAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DBController : NSObject{
    sqlite3 *db;
    sqlite3_stmt *stmt;
}
-(NSArray *)retriveCity;
-(NSArray *)retriveNearByLocation:(NSString *)city;
-(BOOL)saveUserInfo:(NSMutableDictionary *)userInfo;
-(BOOL)saveFeedback:(NSString *)feedBack AndRating:(NSString *)rating;
@end
