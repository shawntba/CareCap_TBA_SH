//
//  DataBase.h
//  CareCap
//
//  Created by Shawn Ray on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PlausibleDatabase/PlausibleDatabase.h>

@interface DataBase : NSObject {
    
}

+ (PLSqliteDatabase *) setup;

+ (void) close;

@end
