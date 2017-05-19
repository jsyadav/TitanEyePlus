//
//  DBController.m
//  SelectCity
//
//  Created by MoJolt on 10/22/13.
//  Copyright (c) 2013 SVAPAS. All rights reserved.
//

#import "DBController.h"

@implementation DBController

-(NSArray *)retriveCity{
    NSLog(@"retrive city");
    NSMutableArray *retriveCity = [[NSMutableArray alloc]init];
    
    NSMutableString *sql = [[NSMutableString alloc]initWithFormat:@"SELECT City_Name FROM City"];
    
    [self connection];
    [self openDb];
    
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    while (sqlite3_step(stmt)==SQLITE_ROW)
    {
        
        [retriveCity addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(stmt, 0)]];
        
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    
    return retriveCity;
}
-(NSArray *)retriveNearByLocation:(NSString *)city{
    NSLog(@"retive nearby");
    NSMutableArray *nearBy = [[NSMutableArray alloc]init];
    
    NSMutableString *sql = [[NSMutableString alloc]initWithFormat:@"select NearByName from NearBy where CityId in (select City_Id from City where City_Name='%@')",city];
    
    [self connection];
    [self openDb];
    
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    while (sqlite3_step(stmt)==SQLITE_ROW)
    {
        
        [nearBy addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(stmt, 0)]];
        
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    
    return nearBy;
    
}
-(void)connection;
{
    NSString *pathForDocumentDirectory = [NSString stringWithFormat:@"%@/TitanEyePlus.sqlite",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    //NSString *pathForDocumentDirectory = [[NSBundle mainBundle]pathForResource:@"Srini" ofType:@"sqlite"];
    
    NSLog(@"%@",pathForDocumentDirectory);
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:pathForDocumentDirectory])
    {
        NSLog(@"file not exists at path");
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"TitanEyePlus" ofType:@"sqlite" ] toPath:pathForDocumentDirectory error:&error];
    }
    
}

-(NSString *)path;
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"TitanEyePlus.sqlite"];
    return path;
}

-(BOOL)openDb
{
    if(sqlite3_open([[self path] UTF8String], &db)==SQLITE_OK)
        return YES;
    else
        return NO;
}

-(BOOL)saveUserInfo:(NSMutableDictionary *)userInfo{
    NSMutableString *sql = [[NSMutableString alloc]initWithFormat:@"INSERT INTO  UserInfo ( name, email, age , mobile_num ,code, city , near_by )  VALUES('%@','%@','%@','%@','%@','%@','%@')",[userInfo valueForKey:@"name"],[userInfo valueForKey:@"email"],[userInfo valueForKey:@"age"],[userInfo valueForKey:@"mobile"],[userInfo valueForKey:@"code"],[userInfo valueForKey:@"city"],[userInfo valueForKey:@"nearby"]];
    [self connection];
    
    if([self openDb]){
        sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        sqlite3_close(db);
        return YES;
    }
    else
        return NO;
    
}
-(BOOL)saveFeedback:(NSString *)feedBack AndRating:(NSString *)rating{
    NSMutableString *sql = [[NSMutableString alloc]initWithFormat:@"INSERT INTO Feedback (rating,uid,feedback) VALUES('%@',(SELECT MAX(id) from UserInfo),%@)",rating,feedBack];
    [self connection];
    
    if([self openDb]){
        sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        sqlite3_close(db);
        return YES;
    }
    else
        return NO;
    
}
@end
