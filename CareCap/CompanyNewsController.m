//
//  CompanyNewsController.m
//  CareCap
//
//  Created by Tba-Sh-Apple on 11/29/11.
//  Copyright (c) 2011 __The Beagle Armada__. All rights reserved.
//

#import "CompanyNewsController.h"
#import "NewsDetailController.h"
#import "News.h"
#import "LoadingView.h"

@implementation CompanyNewsController

@synthesize listOfNews;
@synthesize queue;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSLog(@"Start init News controller:");
        
        [self setTitle:NSLocalizedString(@"News_Title", nil)];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        if([listOfNews count] == 0)
        {
            NSLog(@"Load data while init News controller.");
            
            [self loadData];
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
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
    queue = nil;
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
    
    self.navigationItem.leftBarButtonItem = nil;
    
    //[self setTitle:NSLocalizedString(@"News_Title", nil)];
    
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
//    NSLog(@"Load Data while View Did load;");
//    NSLog(@"%d", [listOfNews count]);
//    if([listOfNews count] == 0)
//    {
//        [self loadData];
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    }
}

- (void) loadDataWithOperation {
	//Initialize the array.
    listOfNews = [[NSMutableArray alloc] init];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]){
        NSMutableArray *cachedNews = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]];
        
        NSLog(@"%d", [cachedNews count]);
        NSLog(@"%d", [listOfNews count]);
        
        if([cachedNews count] > 0 && [cachedNews count] >= [listOfNews count])
        {
            NSLog(@"Temp list Count: %d", [listOfNews count]);
            //            for(NSData *data in cachedNews){
            //                News *news = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            //
            //                NSPredicate *idPredicate = [NSPredicate predicateWithFormat:@"ID == %d", news.ID];
            //
            //                NSArray *test = [listOfNews filteredArrayUsingPredicate:idPredicate];
            //
            //                NSLog (@"%@", [test valueForKey:@"ID"]);
            //
            //                if ([listOfNews filteredArrayUsingPredicate:idPredicate])
            //                {
            //                    [listOfNews addObject:news];
            //                }
            //            }
            
            for(NSData *data in cachedNews){
                News *news = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [listOfNews addObject:news];
            }
        }
        
        NSLog(@"Cached Count: %d", [cachedNews count]);
        NSLog(@"List Count: %d", [listOfNews count]);
        
        [cachedNews release];
    }
	
	//[self.tableView reloadData];
    
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    //End Animation
    //UIActivityIndicatorView *tmpimg = (UIActivityIndicatorView *)[self.view viewWithTag:1];
    //[tmpimg removeFromSuperview];
}

- (void) loadData {
    queue = [[NSOperationQueue alloc] init];
	
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self 
																			selector:@selector(loadDataWithOperation) 
																			  object:nil];
	[queue addOperation:operation];
    
    [operation release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Start Animation
    //UIActivityIndicatorView *av = [[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    //av.frame = CGRectMake(0, 0, 320, 160);
    //av.tag  = 1;
    
    //[self.view addSubview:av];
    //[av startAnimating];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //End Animation
    //UIActivityIndicatorView *tmpimg = (UIActivityIndicatorView *)[self.view viewWithTag:1];
    //[tmpimg removeFromSuperview];
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
    NSLog(@"Table row count: %d", [listOfNews count]);
    
    return [listOfNews count] > 0 ? [listOfNews count] : 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellValue = [listOfNews count] > 0 ? [((News *)[listOfNews objectAtIndex:indexPath.row]) Title] : NSLocalizedString(@"Load_Lable", nil);
    
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
    
    // Configure the cell...
    NSString *cellValue = [listOfNews count] > 0 ? [((News *)[listOfNews objectAtIndex:indexPath.row]) Title] : NSLocalizedString(@"Load_Lable", nil);
    
    CGSize size = [cellValue sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(270, 400) lineBreakMode:UILineBreakModeWordWrap];
    
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setNeedsDisplayInRect:CGRectMake(30, 10, size.width, size.height)];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    
    if([listOfNews count] == 0)
    {
        [cell.textLabel setTextColor:[UIColor grayColor]];
    }
    else
    {
        [cell.textLabel setTextColor:[UIColor blackColor]];
    }
    
    cell.textLabel.text = cellValue;
    
    if([listOfNews count] > 0)
    {
        NSNumber *newStatus = [((News *)[listOfNews objectAtIndex:indexPath.row]) IsRead];
        
        if ([newStatus isEqualToNumber:[NSNumber numberWithInt:0]]) {
            cell.imageView.image = [UIImage imageNamed:@"UnreadIndicator.png"];
        }else {
            cell.imageView.image = [UIImage imageNamed:@"ReadIndicator.png"];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setTextAlignment:UITextAlignmentLeft];
    } else if([listOfNews count] == 0) {
        [cell.textLabel setTextAlignment:UITextAlignmentCenter];
        //cell.imageView.image = [UIImage imageNamed:@"newsloader.gif"];
        //UIActivityIndicatorView *activityIndicatorView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        
        //[cell addSubview:activityIndicatorView];
        
        //activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        //[activityIndicatorView startAnimating];
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
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cachedNews"];
    }
    
    NSMutableArray *cachedNews = [[NSMutableArray alloc] init];
    
    for(News *storedNews in listOfNews){
        News *restoreNews = [News new];
        
        if([storedNews.ID isEqualToNumber:news.ID])
        {
            restoreNews.ID = news.ID;
            restoreNews.Title = news.Title;
            restoreNews.Content = news.Content;
            restoreNews.IsRead = news.IsRead;
            restoreNews.PublishDate = news.PublishDate;
            restoreNews.FullContent = news.FullContent;
        } else {
            restoreNews.ID = storedNews.ID;
            restoreNews.Title = storedNews.Title;
            restoreNews.Content = storedNews.Content;
            restoreNews.IsRead = storedNews.IsRead;
            restoreNews.PublishDate = storedNews.PublishDate;
            restoreNews.FullContent = storedNews.FullContent;
        }
        
        [cachedNews addObject:[NSKeyedArchiver archivedDataWithRootObject:restoreNews]];
        
        [restoreNews release];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:cachedNews forKey:@"cachedNews"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [cachedNews release];
    [self.tableView reloadData];
    
    //[newStatus autorelease];
    NewsDetailController *controller = [[NewsDetailController alloc] initWithNibName:@"NewsDetailController" bundle:nil withNews:news];
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

@end
