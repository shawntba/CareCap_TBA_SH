//
//  CompanyNewsController.m
//  CareCap
//
//  Created by Ray Shawn on 10/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompanyNewsController.h"
#import "NewsDetailController.h"
#import "ASIHTTPRequest.h"
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

- (void)dealloc
{
    [listOfNews release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    }else{
        NSMutableArray *cachedNews = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"cachedNews"]];
        for(NSData *data in cachedNews){
            News *news = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [listOfNews addObject:news];
        }
        [cachedNews release];
    }
    
    [self setTitle:@"News"];
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
    //return  YES;
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
    return [listOfNews count] > 0 ? [listOfNews count] : 0;
    //return [listOfNews count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([listOfNews count] == 0) {
        return 0;
    }
    
    NSString *cellValue =  [((News *)[listOfNews objectAtIndex:indexPath.row]) Title];
    
    NSLog(@"Initial height of row;");
    
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
    
    if ([listOfNews count] == 0) {
        return cell;
    }
    // Configure the cell...
    NSString *cellValue = [((News *)[listOfNews objectAtIndex:indexPath.row]) Title];
    NSNumber *newStatus = [((News *)[listOfNews objectAtIndex:indexPath.row]) IsRead];
    
    NSLog(@"Initial content");
    
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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     [detailViewController release];
//     */
//}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
