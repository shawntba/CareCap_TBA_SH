//
//  NewsFullContentController.h
//  CareCap
//
//  Created by Tba-Sh-Apple on 8/10/12.
//
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsFullContentController : UIViewController<UIWebViewDelegate> {
    News *news;
}

@property (nonatomic, retain) News *news;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withNews:(News *)anews;

@end
