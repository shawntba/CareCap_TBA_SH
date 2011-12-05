//
//  ZzpSelectorController.h
//  CareCap
//
//  Created by J on 11-7-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZzpSelectorController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource> {
    IBOutlet UIButton *selectorBtn;
    IBOutlet UIView *pickerView;
    IBOutlet UIPickerView *picker;
    NSArray *data;
}

- (IBAction) next;

@property (nonatomic, retain) UIButton *selectorBtn;
@property (nonatomic, retain) UIView *pickerView;
@property (nonatomic, retain) UIPickerView *picker;
@end
