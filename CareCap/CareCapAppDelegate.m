//
//  CareCapAppDelegate.m
//  CareCap
//
//  Created by Tba-Sh-Apple on 8/30/11.
//  Copyright 2011 The Beagle Armada. All rights reserved.
//

#import "CareCapAppDelegate.h"
#import "ASIFormDataRequest.h"
#import "News.h"
#import "SBJsonParser.h"

@implementation CareCapAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

-(void)alertNotice:(NSString *)title withMSG:(NSString *)msg cancleButtonTitle:(NSString *)cancleTitle otherButtonTitle:(NSString *)otherTitle{
    UIAlertView *alert;
    
    if([otherTitle isEqualToString:@""])
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:nil,nil];
    else
        alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:otherTitle,nil];
    
    [alert show];
    [alert release];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    //    self.window.rootViewController = self.tabBarController;
    
    //    [self.window makeKeyAndVisible];
    [self.window makeKeyAndVisible];
	[_window addSubview:_tabBarController.view];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)];
    
    NSLog(@"%d", [UIApplication sharedApplication].applicationIconBadgeNumber);
    
//    if([UIApplication sharedApplication].applicationIconBadgeNumber > 0)
//    {
//        [(UIViewController *)[_tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = [NSString stringWithFormat:@"%d", [UIApplication sharedApplication].applicationIconBadgeNumber];
//    }
//    else
//    {
//        [(UIViewController *)[_tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = nil;
//    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"devToken=%@",deviceToken);
    
    NSString *deviceString = [NSString stringWithFormat:@"%@",deviceToken];
    deviceString = [[[deviceString stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.166.16:6060/api/news/Device/%@", deviceString];
//    NSString *urlString = [NSString stringWithFormat:@"http://nfs.azrlive.nl/api/news/Device/%@", deviceString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Store the device Token
    NSUserDefaults *cachedDeviceToken = [NSUserDefaults standardUserDefaults];
    [cachedDeviceToken setObject:deviceString forKey:@"cachedDeviceToken"];
    [cachedDeviceToken synchronize];
    
    NSLog(@"Data saved");
    
    NSLog(@"url=%@",urlString);
    
//    if([[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]){
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cachedNews"];
//    }
    
    NSMutableArray *cachedAppNews = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]];
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"] || [cachedAppNews count] == 0){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        // Will limit bandwidth to the predefined default for mobile applications when WWAN is active.
        // Wi-Fi requests are not affected
        // This method is only available on iOS
        [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
        
        // Will throttle bandwidth based on a user-defined limit when when WWAN (not Wi-Fi) is active
        // This method is only available on iOS
        [ASIFormDataRequest throttleBandwidthForWWANUsingLimit:14800];
        
        // Will prevent requests from using more than the predefined limit for mobile applications.
        // Will limit ALL requests, regardless of whether Wi-Fi is in use or not - USE WITH CAUTION
        [ASIFormDataRequest setMaxBandwidthPerSecond:ASIWWANBandwidthThrottleAmount];
        
        // Log how many bytes have been received or sent per second (average from the last 5 seconds)
        NSLog(@"%lu",[ASIFormDataRequest averageBandwidthUsedPerSecond]);
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
        
        [request setDelegate:self];
        [request setTimeOutSeconds:10];
        [request setDidFinishSelector:@selector(sucessRegDevice:)];
        [request setDidFailSelector:@selector(failedRegDevice:)];
        
        [request startAsynchronous];
    }
    
    [cachedAppNews release];
}

- (void) sucessRegDevice:(ASIHTTPRequest *) request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);
    // Use when fetching binary data
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
//    if([[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]){
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cachedNews"];
//    }
    
    NSMutableArray *jsonArray = [parser objectWithString:responseString];
    NSMutableArray *cachedNews;
    
    cachedNews = [[NSMutableArray alloc] init];
    
//    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]){
//        cachedNews = [[NSMutableArray alloc] init];
//    }else{
//        cachedNews = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]];
//    }
    
    int unreadCount = 0;
    
    for(NSMutableDictionary *dict in jsonArray){
        News *news = [News new];
        news.ID = [NSNumber numberWithInt:[[dict objectForKey:@"ID"] intValue]];
        news.Title = [dict objectForKey:@"Title"];
        news.Content = [dict objectForKey:@"NewsContent"];
        news.IsRead = [NSNumber numberWithBool:[[dict objectForKey:@"IsRead"] boolValue]];
        
        if ([news.IsRead isEqualToNumber:[NSNumber numberWithInt:0]])
        {
            unreadCount++;
        }
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        news.PublishDate = [formater dateFromString:[dict objectForKey:@"PublishTime"]];
        [formater release];
        
        [cachedNews addObject:[NSKeyedArchiver archivedDataWithRootObject:news]];
        
        [news autorelease];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:cachedNews forKey:@"cachedNews"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"RESPONSE %d ==> %@", request.responseStatusCode, request.responseString);
    
    NSLog(@"%d", [UIApplication sharedApplication].applicationIconBadgeNumber);
    
    if(unreadCount > 0)
    {
        [(UIViewController *)[_tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = [NSString stringWithFormat:@"%d", unreadCount];
        [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount;
    }
    else
    {
        [(UIViewController *)[_tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = nil;
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
    
    [cachedNews release];
    [parser release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    return;
}

- (void) failedRegDevice:(ASIHTTPRequest *) request
{
    NSError *error = [request error];
    
    if (error) {
        NSLog(@"Response %d ===> %@", request.responseStatusCode, request.responseString);
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

@end
