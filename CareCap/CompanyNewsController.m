//
//  CompanyNewsController.m
//  CareCap
//
//  Created by Tba-Sh-Apple on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CompanyNewsController.h"
#import "NewsDetailController.h"
#import "SBJSON.h"
#import "News.h"

@implementation CompanyNewsController

@synthesize listOfNews;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [listOfNews release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Initialize the array.
    listOfNews = [[NSMutableArray alloc] init];
    
    //    if([[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]){
    //        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cachedNews"];
    //    }
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]){
        //        NSURL *url = [NSURL URLWithString:@"http://nfs.azrlive.nl/api/news/News/count/11"];
        
        // Will limit bandwidth to the predefined default for mobile applications when WWAN is active.
        // Wi-Fi requests are not affected
        // This method is only available on iOS
        //        [ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
        
        // Will throttle bandwidth based on a user-defined limit when when WWAN (not Wi-Fi) is active
        // This method is only available on iOS
        //        [ASIHTTPRequest throttleBandwidthForWWANUsingLimit:14800];
        
        // Will prevent requests from using more than the predefined limit for mobile applications.
        // Will limit ALL requests, regardless of whether Wi-Fi is in use or not - USE WITH CAUTION
        //        [ASIHTTPRequest setMaxBandwidthPerSecond:ASIWWANBandwidthThrottleAmount];
        
        // Log how many bytes have been received or sent per second (average from the last 5 seconds)
        //        NSLog(@"%lu",[ASIHTTPRequest averageBandwidthUsedPerSecond]);
        
        // Get the stored data before the view loads
        //        NSUserDefaults *cachedDeviceToken = [NSUserDefaults standardUserDefaults];        
        //        NSString *currentDeviceToken = [cachedDeviceToken stringForKey:@"cachedDeviceToken"];
        
        //        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.166.16:6060/api/news/NewsDevice/NewsByDevice/%@", currentDeviceToken]];
        //        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        //        [request setDelegate:self];
        //        [request startSynchronous];
    }else{
        NSMutableArray *cachedNews = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]];
        
        if([cachedNews count] > 0)
        {
            for(NSData *data in cachedNews){
                News *news = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [listOfNews addObject:news];
            }
        }
        [cachedNews release];
    }
    
    [self setTitle:NSLocalizedString(@"News_Title", nil)];
}

//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    // Use when fetching text data
//    NSString *responseString = [request responseString];
//    NSLog(@"%@",responseString);
//    // Use when fetching binary data
//    SBJsonParser *parser = [[SBJsonParser alloc] init];
//    
//    //    NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
//    //    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[jsonDictionary valueForKey:@"Title"]];
//    //
//    //    self.listOfItems = items;
//    //    [items release];
//    
//    //    NSLog(@"Response %d ===> %@", request.responseStatusCode, listOfItems);
//    
//    NSMutableArray *jsonArray = [parser objectWithString:responseString];
//    NSMutableArray *cachedNews;
//    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]){
//        cachedNews = [[NSMutableArray alloc] init];
//    }else{
//        cachedNews = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]];
//    }
//    
//    if([cachedNews count] > 0)
//    {
//        for(NSMutableDictionary *dict in jsonArray){
//            News *news = [News new];
//            news.ID = [NSNumber numberWithInt:[[dict objectForKey:@"ID"] intValue]];
//            news.Title = [dict objectForKey:@"Title"];
//            news.Content = [dict objectForKey:@"NewsContent"];
//            news.IsRead = [NSNumber numberWithBool:[[dict objectForKey:@"IsRead"] boolValue]];
//        
//            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
//            [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            news.PublishDate = [formater dateFromString:[dict objectForKey:@"PublishTime"]];
//            [formater release];
//        
//            [listOfNews addObject:news];
//            [cachedNews addObject:[NSKeyedArchiver archivedDataWithRootObject:news]];
//        
//            [news autorelease];
//        }   
//    
//        [[NSUserDefaults standardUserDefaults] setObject:cachedNews forKey:@"cachedNews"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//    
//    [cachedNews release];
//    [self.tableView reloadData];
//    [parser release];
//}
//
//- (void)requestFailed:(ASIHTTPRequest *)request
//{
//    NSError *error = [request error];
//    
//    if (error) {
//        NSLog(@"Response %d ===> %@", request.responseStatusCode, request.responseString);
//    }
//}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listOfNews count] > 0 ? [listOfNews count] : 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellValue = [listOfNews count] > 0 ? [((News *)[listOfNews objectAtIndex:indexPath.row]) Title] : @"";
    
    CGSize size = [cellValue sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(270, 400) lineBreakMode:UILineBreakModeWordWrap];
    return size.height+20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if([listOfNews count] > 0)
    {
        // Configure the cell...
        NSString *cellValue = [((News *)[listOfNews objectAtIndex:indexPath.row]) Title];
        NSNumber *newStatus = [((News *)[listOfNews objectAtIndex:indexPath.row]) IsRead];
        
        CGSize size = [cellValue sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(270, 400) lineBreakMode:UILineBreakModeWordWrap];
        
        [cell.textLabel setNumberOfLines:0];
        [cell.textLabel setNeedsDisplayInRect:CGRectMake(30, 10, size.width, size.height)];
        [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
        
        cell.textLabel.text = cellValue;
        
        if ([newStatus isEqualToNumber:[NSNumber numberWithInt:0]]) {
            cell.imageView.image = [UIImage imageNamed:@"UnreadIndicator.png"];
        }else {
            cell.imageView.image = [UIImage imageNamed:@"ReadIndicator.png"];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    News *news = (News *)[listOfNews objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSNumber *newStatus = [((News *)[listOfNews objectAtIndex:indexPath.row]) IsRead];
    
    if ([newStatus isEqualToNumber:[NSNumber numberWithInt:0]]) {
        [news setIsRead:[NSNumber numberWithInt:1]];
        [cell.imageView setImage:[UIImage imageNamed:@"ReadIndicator.png"]];
        [self.tableView reloadData];
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber - 1;
        
        if([UIApplication sharedApplication].applicationIconBadgeNumber > 0)
        {
            self.tabBarController.selectedViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [UIApplication sharedApplication].applicationIconBadgeNumber];
        }
        else
        {
            self.tabBarController.selectedViewController.tabBarItem.badgeValue = nil;
        }
    }
    
    //[newStatus autorelease];
    NewsDetailController *controller = [[NewsDetailController alloc] initWithNibName:@"NewsDetailController" bundle:nil withNews:news];
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
