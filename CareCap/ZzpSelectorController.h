//
//  ZzpSelectorController.h
//  CareCap
//
//  Created by Gary.Gan on 11-7-29.
//  Copyright 2011 __The Beagle Armada__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZzpSelectorController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource> {
    IBOutlet UIButton *selectorBtn;
    IBOutlet UIView *pickerView;
    IBOutlet UIPickerView *picker;
    IBOutlet UIBarButtonItem *nextBtn;
    NSArray *data;
}

- (IBAction) next;
- (IBAction) flipView;

@property (nonatomic, retain) UIButton *selectorBtn;
@property (nonatomic, retain) UIView *pickerView;
@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) UIBarButtonItem *nextBtn;

@end
