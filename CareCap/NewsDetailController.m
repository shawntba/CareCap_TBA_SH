//
//  NewsDetailController.m
//  CareCap
//
//  Created by Ray Shawn on 10/6/11.
//  Copyright 2011 __The Beagle Armada__. All rights reserved.
//

#import "NewsDetailController.h"

@implementation NewsDetailController

@synthesize news;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withNews:(News *)anews
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.news = anews;
    }
    return self;
}

- (void)dealloc
{
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
    // Do any additional setup after loading the view from its nib.
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self setTitle:NSLocalizedString(@"News_Detail", nil)];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 93)];
    
    NSLog(@"<html><head><meta name=\"apple-mobile-web-app-capable\" content=\"yes\"></head><body>%@</body></html>",self.news.Content);
    
    [webview loadHTMLString:[NSString stringWithFormat:@"<html><head><meta name=\"apple-mobile-web-app-capable\" content=\"yes\"></head><body>%@</body></html>",self.news.Content] baseURL:nil];
    
    [self.view addSubview:webview];
    
    [webview release];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    //return YES;
}

#pragma mark - WebView lifecycle

@end
