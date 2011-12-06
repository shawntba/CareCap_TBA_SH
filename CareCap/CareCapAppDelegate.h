//
//  CareCapAppDelegate.h
//  CareCap
//
//  Created by Tba-Sh-Apple on 8/30/11.
//  Copyright 2011 __The Beagle Armada__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface CareCapAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> 
{
    NSString *unreadCountString;
    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
    
    BOOL appConnectionRequired;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSString *unreadCountString;

- (void) updateInterfaceWithReachability: (Reachability*)curReach;
- (void) intialNewsandDevice: (NSURL *)url;
- (void) getNewsList: (NSURL *)url;

@end
