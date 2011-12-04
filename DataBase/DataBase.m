//
//  DataBase.m
//  CareCap
//
//  Created by Shawn Ray on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DataBase.h"
#import <PlausibleDatabase/PlausibleDatabase.h>

static PLSqliteDatabase * dbPointer;

@implementation DataBase

//Singlton

+ (PLSqliteDatabase *) setup{
    if(dbPointer) {
        return dbPointer;
    }
    
    NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES));
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *realPath = [documentPath stringByAppendingPathComponent:@"storedNews.sqlite"];
    
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"storedNews" ofType:@"sqlite"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:realPath]){
        NSError *error;
        
        if (![fileManager copyItemAtPath:sourcePath toPath:realPath error:&error]) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    
    NSLog(@"Sucessfully copy sqlite to direction: %@", realPath);
    
    //Change the address of dbpointer to changable realPath.
    dbPointer = [[PLSqliteDatabase alloc] initWithPath:realPath];
    
    [dbPointer open];
    
    return dbPointer;
}

+ (void) close{
    if (dbPointer) {
        [dbPointer close];
        dbPointer = NULL;
    }
}

@end
