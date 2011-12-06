//
//  ZzpCalculationController.h
//  CareCap
//
//  Created by J on 11-7-29.
//  Copyright 2011 __The Beagle Armada__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface ZzpCalculationController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    NSString *zzp;
    NSMutableArray *textFields;
    NSArray *listContent;
    IBOutlet UITableView *tbl;
    IBOutlet UIButton *BackgroundButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withZZP:(NSString *) zzp;
-(IBAction) backgroundClick;

@property (nonatomic, retain) NSString *zzp;
@property (nonatomic, retain) NSMutableArray *textFields;
@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) IBOutlet UITableView *tbl;

@end
