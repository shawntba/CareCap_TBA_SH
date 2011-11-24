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

    
//    self.tabBarController.tabBarItem
    
    NSLog(@"%d", [UIApplication sharedApplication].applicationIconBadgeNumber);
    
    //[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //[(UIViewController *)[_tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = nil;
    
    if([UIApplication sharedApplication].applicationIconBadgeNumber == 0)
    {
        [(UIViewController *)[_tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = nil;
    }
    else
    {
        [(UIViewController *)[_tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = [NSString stringWithFormat:@"%d", [UIApplication sharedApplication].applicationIconBadgeNumber];
    }
    
    //    [self alertNotice:@"" withMSG:@"Initiating Remote Noticationss Are Active" cancleButtonTitle:@"Ok" otherButtonTitle:@""];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"devToken=%@",deviceToken);
    //[self alertNotice:@"" withMSG:[NSString stringWithFormat:@"devToken=%@",deviceToken] cancleButtonTitle:@"Ok" otherButtonTitle:@""];
    NSString *deviceString = [NSString stringWithFormat:@"%@",deviceToken];
    deviceString = [[[deviceString stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.166.16:6060/api/news/Device/%@", deviceString];
//    NSString *urlString = [NSString stringWithFormat:@"http://nfs.azrlive.nl/api/news/Device/%@", deviceString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Store the data
    NSUserDefaults *cachedDeviceToken = [NSUserDefaults standardUserDefaults];
    [cachedDeviceToken setObject:deviceString forKey:@"cachedDeviceToken"];
    [cachedDeviceToken synchronize];
    
    NSLog(@"Data saved");
    
    NSLog(@"url=%@",urlString);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(sucessRegDevice:)];
    [request setDidFailSelector:@selector(failedRegDevice:)];
    
    [request startAsynchronous];
}

- (void) sucessRegDevice:(ASIHTTPRequest *) request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);
    // Use when fetching binary data
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    //    NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
    //    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[jsonDictionary valueForKey:@"Title"]];
    //
    //    self.listOfItems = items;
    //    [items release];
    
    //    NSLog(@"Response %d ===> %@", request.responseStatusCode, listOfItems);
    
    NSMutableArray *jsonArray = [parser objectWithString:responseString];
    NSMutableArray *cachedNews;
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]){
        cachedNews = [[NSMutableArray alloc] init];
    }else{
        cachedNews = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]];
    }
    
    for(NSMutableDictionary *dict in jsonArray){
        News *news = [News new];
        news.ID = [NSNumber numberWithInt:[[dict objectForKey:@"ID"] intValue]];
        news.Title = [dict objectForKey:@"Title"];
        news.Content = [dict objectForKey:@"NewsContent"];
        news.IsRead = [NSNumber numberWithBool:[[dict objectForKey:@"IsRead"] boolValue]];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        news.PublishDate = [formater dateFromString:[dict objectForKey:@"PublishTime"]];
        [formater release];
        
        [cachedNews addObject:[NSKeyedArchiver archivedDataWithRootObject:news]];
        
        [news autorelease];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:cachedNews forKey:@"cachedNews"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [cachedNews release];
    [parser release];
    
    NSLog(@"RESPONSE %d ==> %@", request.responseStatusCode, request.responseString);
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
    //[self alertNotice:@"" withMSG:[NSString stringWithFormat:@"Error in registration. Error: %@", err] cancleButtonTitle:@"Ok" otherButtonTitle:@""];
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


// Optional UITabBarControllerDelegate method.
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{   
//    // Get views. controllerIndex is passed in as the controller we want to go to.
//    UIView * fromView = tabBarController.selectedViewController.view;
//    UIView * toView;
//    
//    if(tabBarController.selectedIndex == 0)
//    {
//        toView = [[tabBarController.viewControllers objectAtIndex:1] view];
//        
//        // Transition using a page curl.
//        [UIView transitionFromView:fromView 
//                            toView:toView 
//                          duration:0.5 
//                           options:UIViewAnimationOptionTransitionCurlUp
//                        completion:^(BOOL finished) {
//                            if (finished) {
//                                tabBarController.selectedIndex = 1;
//                            }
//                        }];
//    }
//    
//    if(tabBarController.selectedIndex == 1)
//    {
//        toView = [[tabBarController.viewControllers objectAtIndex:0] view];
//        // Transition using a page curl.
//        [UIView transitionFromView:fromView 
//                            toView:toView 
//                          duration:0.5 
//                           options:UIViewAnimationOptionTransitionCurlDown
//                        completion:^(BOOL finished) {
//                            if (finished) {
//                                tabBarController.selectedIndex = 0;
//                            }
//                        }];
//    }
//}

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

@end
