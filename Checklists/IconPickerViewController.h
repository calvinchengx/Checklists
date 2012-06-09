//
//  IconPickerViewController.h
//  Checklists
//
//  Created by Calvin Cheng on 9/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate <NSObject>
- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName;
@end

@interface IconPickerViewController : UITableViewController
@property (nonatomic, weak)id <IconPickerViewControllerDelegate> delegate;
@end
