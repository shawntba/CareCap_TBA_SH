//
//  NewsDetailController.m
//  CareCap
//
//  Created by Ray Shawn on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailController.h"

@implementation NewsDetailController

@synthesize news;
@synthesize loadingIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        loadingIndicator = nil;
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
    
    [loadingIndicator release];
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
    
    loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(145, 190, 20,20)];
    [loadingIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [loadingIndicator setHidesWhenStopped:YES];
    
    [self setTitle:NSLocalizedString(@"News_Detail", nil)];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 93)];
    
    NSLog(@"<html><head><meta name=\"apple-mobile-web-app-capable\" content=\"yes\"></head><body>%@</body></html>",self.news.Content);
    
    [webview loadHTMLString:[NSString stringWithFormat:@"<html><head><meta name=\"apple-mobile-web-app-capable\" content=\"yes\"></head><body>%@</body></html>",self.news.Content] baseURL:nil];
    [webview addSubview:loadingIndicator];
    
    [self.view addSubview:webview];
    
    [webview release];
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

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [loadingIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [loadingIndicator stopAnimating];
}

@end
