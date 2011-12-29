//
//  VlionActionSheet.h
//  TestActionSheet
//
//  Created by Cui Lionel on 10-12-8.
//  Copyright 2010 vlion. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HelperSheet : UIActionSheet 
{
	UIToolbar* toolBar;
	UIView* view;
}

@property(nonatomic,retain)UIView* view;
@property(nonatomic,retain)UIToolbar* toolBar;

-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title;
/*因为是通过给ActionSheet 加 Button来改变ActionSheet, 所以大小要与actionsheet的button数有关
height = 84, 134, 184, 234, 284, 334, 384, 434, 484
 如果要用self.view = anotherview.  那么another的大小也必须与view的大小一样
*/
@end
