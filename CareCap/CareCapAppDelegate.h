//
//  CareCapAppDelegate.h
//  CareCap
//
//  Created by Tba-Sh-Apple on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CareCapAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> 
{
    NSString *unreadCountString;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSString *unreadCountString;

@end
