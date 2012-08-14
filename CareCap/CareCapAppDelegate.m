//
//  CareCapAppDelegate.m
//  CareCap
//
//  Created by Tba-Sh-Apple on 8/30/11.
//  Copyright 2011 The Beagle Armada. All rights reserved.
//

#import "CareCapAppDelegate.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "News.h"
#import "SBJsonParser.h"
#import "Reachability.h"
#import "CompanyNewsController.h"

@implementation UINavigationBar (UINavigationBarCategory)

-(void)setBackgroundImage:(UIImage*)image
{    
    UIImageView *backgroundView = (UIImageView *)[self viewWithTag:navbarImageTag];
    
    if(backgroundView)
	{
		[backgroundView removeFromSuperview];
	}
	else
	{
		backgroundView = [[UIImageView alloc] initWithImage:image];
		backgroundView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height);
		backgroundView.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self addSubview:backgroundView];
		[self sendSubviewToBack:backgroundView];
		[backgroundView release];
	}
}

//for other views
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{    
    UIImageView *backgroundView = (UIImageView *)[self viewWithTag:navbarImageTag];
    
    [super insertSubview:view atIndex:index];
    
    if(backgroundView)
    {
        [self sendSubviewToBack:backgroundView];
    }
}
@end

@implementation CareCapAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize unreadCountString;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [unreadCountString release];
    //[listOfNews release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

-(void)alertNotice:(NSString *)title withMSG:(NSString *)msg cancleButtonTitle:(NSString *)cancleTitle otherButtonTitle:(NSString *)otherTitle
{
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
    // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
    // method "reachabilityChanged" will be called. 
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    //Change the host name here to change the server your monitoring
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
	[internetReach startNotifier];
	[self updateInterfaceWithReachability: internetReach];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)];
    
    //Test fetch news content
    //[self FetchNewsByDeviceToken:nil];
    
    NSLog(@"%d", [UIApplication sharedApplication].applicationIconBadgeNumber);
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cachedNews"];
    }
    
    if(appConnectionRequired)
    {
        if([UIApplication sharedApplication].applicationIconBadgeNumber > 0)
        {
            [(UIViewController *)[_tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = [NSString stringWithFormat:@"%d", [UIApplication sharedApplication].applicationIconBadgeNumber];
        }
        else
        {
            [(UIViewController *)[_tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = nil;
        }
    }
    else
    {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        [(UIViewController *)[_tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = nil;
        
    }
    
//    [NSThread sleepForTimeInterval:2.0f];
    //sleep(10);
    
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
	[_window addSubview:_tabBarController.view];
    [self.window makeKeyAndVisible];
    
    [self.tabBarController setDelegate:self];
    
    return YES;
}

#pragma mark - Check reachablity

- (void) configureNotice: (Reachability*) curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    appConnectionRequired = [curReach connectionRequired];
    NSString* statusString= @"";
    
    switch (netStatus)
    {
        case NotReachable:
        {
            statusString = @"Network Access Not Available";
            //Minor interface detail- connectionRequired may return yes, even when the host is unreachable.  We cover that up here...
            appConnectionRequired = NO;  
            break;
        }
            
        case ReachableViaWWAN:
        {
            statusString = @"Reachable WWAN";
            appConnectionRequired = YES;
            break;
        }
        case ReachableViaWiFi:
        {
            statusString= @"Reachable WiFi";
            appConnectionRequired = YES;
            break;
        }
    }
    
    if(appConnectionRequired)
    {
        statusString= [NSString stringWithFormat: @"%@, Connection Required", statusString];
    }
    else
    {
        [self alertNotice:@"" withMSG:statusString cancleButtonTitle:@"OK" otherButtonTitle:@""];
    }
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    if(curReach == hostReach)
	{
        [self configureNotice: curReach];
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
        appConnectionRequired = [curReach connectionRequired];
        
        if(netStatus == ReachableViaWWAN)
        {
            NSString* baseLabel=  @"";
            if(appConnectionRequired)
            {
                baseLabel=  @"Cellular data network is available.\n  Internet traffic will be routed through it after a connection is established.";
            }
            else
            {
                baseLabel=  @"Cellular data network is active.\n  Internet traffic will be routed through it.";
            }
            
            [self alertNotice:@"" withMSG:baseLabel cancleButtonTitle:@"OK" otherButtonTitle:@""];
        }
    }
    
	if(curReach == internetReach)
	{	
        [self configureNotice: curReach];
	}
	if(curReach == wifiReach)
	{
        [self configureNotice: curReach];
	}
	
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
}

#pragma mark - Fetch News

- (void) FetchNewsByDeviceToken: (NSData *)deviceToken
{
    NSString *deviceString = [NSString stringWithFormat:@"%@",deviceToken];
    deviceString = [[[deviceString stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.166.16:6060/api/news/NewsDevice/SummaryOfNewsDevice/%@", deviceString];
    //NSString *urlString = [NSString stringWithFormat:@"http://nfs.azrlive.nl/api/news/NewsDevice/SummaryOfNewsDevice/%@", deviceString];
    //NSString *urlString = [NSString stringWithFormat:@"http://apn.azrlive.nl/api/news/NewsDevice/SummaryOfNewsDevice/%@", deviceString];
    
    NSLog(@"url=%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Store the device Token
    NSUserDefaults *cachedDeviceToken = [NSUserDefaults standardUserDefaults];
    [cachedDeviceToken setObject:deviceString forKey:@"cachedDeviceToken"];
    [cachedDeviceToken synchronize];
    
    NSLog(@"Data saved");
    
    // Intial the news list
    [self getNewsList:url];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"devToken=%@",deviceToken);
    
    if(appConnectionRequired)
    {
        [self FetchNewsByDeviceToken:deviceToken];
    }
}

- (void) getNewsList: (NSURL *)url
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // Will limit bandwidth to the predefined default for mobile applications when WWAN is active.
    // Wi-Fi requests are not affected
    // This method is only available on iOS
    [ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
    
    // Will throttle bandwidth based on a user-defined limit when when WWAN (not Wi-Fi) is active
    // This method is only available on iOS
    [ASIHTTPRequest throttleBandwidthForWWANUsingLimit:14800];
    
    // Will prevent requests from using more than the predefined limit for mobile applications.
    // Will limit ALL requests, regardless of whether Wi-Fi is in use or not - USE WITH CAUTION
    [ASIHTTPRequest setMaxBandwidthPerSecond:ASIWWANBandwidthThrottleAmount];
    
    // Log how many bytes have been received or sent per second (average from the last 5 seconds)
    NSLog(@"%lu",[ASIHTTPRequest averageBandwidthUsedPerSecond]);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setDelegate:self];
    
    [request setDidFinishSelector:@selector(sucessGetList:)];
    [request setDidFailSelector:@selector(failedGetList:)];
    
    [request startAsynchronous];
}

- (void) sucessGetList:(ASIHTTPRequest *) request
{
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);
    // Use when fetching binary data
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSMutableDictionary *jsonArray = [parser objectWithString:responseString];
    
    int serverNewsCount = 0;
    
    serverNewsCount = [[jsonArray objectForKey:@"Count_All"] intValue];
    unreadCountString = [jsonArray objectForKey:@"Count_NotRead"];
    
    int currentNewsCount = 0;
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]) {
        NSMutableArray *cachedNews = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]];
    
        currentNewsCount = [cachedNews count];
        [cachedNews release];
    }
    
    if (serverNewsCount != currentNewsCount || currentNewsCount == 0) {
        NSUserDefaults *cachedDeviceToken = [NSUserDefaults standardUserDefaults];        
        NSString *currentDeviceToken = [cachedDeviceToken stringForKey:@"cachedDeviceToken"];
        
        NSString *urlString = [NSString stringWithFormat:@"http://192.168.166.16:6060/api/news/Device/%@", currentDeviceToken];
        //NSString *urlString = [NSString stringWithFormat:@"http://nfs.azrlive.nl/api/news/Device/%@", currentDeviceToken];
        //NSString *urlString = [NSString stringWithFormat:@"http://apn.azrlive.nl/api/news/Device/%@", currentDeviceToken];
        
        NSLog(@"url=%@",urlString);
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        [self intialNewsandDevice:url];
    }
    
    [parser release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void) failedGetList:(ASIHTTPRequest *) request
{
    NSError *error = [request error];
        
    if (error) {
        NSLog(@"Response %d ===> %@", request.responseStatusCode, request.responseString);
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void) intialNewsandDevice: (NSURL *)url
{
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

- (void) sucessRegDevice:(ASIHTTPRequest *) request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);
    // Use when fetching binary data
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSMutableArray *jsonArray = [parser objectWithString:responseString];
    NSMutableArray *cachedNews;
    
    cachedNews = [[NSMutableArray alloc] init];
//    listOfNews = [[NSMutableArray alloc] init];
    
    int unreadCount = 0;
    
    for(NSMutableDictionary *dict in jsonArray){
        News *news = [News new];
        news.ID = [NSNumber numberWithInt:[[dict objectForKey:@"Id"] intValue]];
        news.Title = [dict objectForKey:@"Title"];
        news.Content = [dict objectForKey:@"NewsContent"];
        news.IsRead = [NSNumber numberWithBool:[[dict objectForKey:@"IsRead"] boolValue]];
//        news.IsRead = [NSNumber numberWithInt:0];
        
        if ([news.IsRead isEqualToNumber:[NSNumber numberWithInt:0]])
        {
            unreadCount++;
        }
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        news.PublishDate = [formater dateFromString:[dict objectForKey:@"PublishTime"]];
        [formater release];
        
        news.FullContent = [dict objectForKey:@"NewsFullContent"];
        
        [cachedNews addObject:[NSKeyedArchiver archivedDataWithRootObject:news]];
//        [listOfNews addObject:news];
        
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
        unreadCountString = [NSString stringWithFormat:@"%d", unreadCount];
    }
    else
    {
        [(UIViewController *)[_tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = nil;
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        unreadCountString = [NSString stringWithFormat:@"%d", 0];
    }
    
    [cachedNews release];
    [parser release];
    
    return;
}

- (void) failedRegDevice:(ASIHTTPRequest *) request
{
    NSError *error = [request error];
    
    if (error) {
        NSLog(@"Response %d ===> %@", request.responseStatusCode, request.responseString);
    }
}

#pragma mark - Tab bar life cycle

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"Swithed tabs.");
    CompanyNewsController *newsViewController = [[CompanyNewsController alloc] initWithStyle:UITableViewStylePlain];
    
    [[self.tabBarController.viewControllers objectAtIndex:1] pushViewController: newsViewController animated:YES];
    [newsViewController release];
}

#pragma mark - Additional auto-generated application methods

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSLog(@"Error in SHIT apple APN registration. Error: %@", err);
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

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    NSLog(@"Swithed tabs.");
}
*/

@end
