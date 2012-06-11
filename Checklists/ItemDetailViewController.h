//
//  AddItemViewController.h
//  Checklists
//
//  Created by Calvin Cheng on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistItem.h"
#import "DatePickerViewController.h"

@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate <NSObject>

- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;

@end

@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate, DatePickerViewControllerDelegate>
// UITextFieldDelegate is a pre-written protocol so we just have to make it
// available to our AddItemViewController.m by specifying < >, so we have
// access to UITextFieldDelegate's methods.

@property (nonatomic, weak) id <ItemDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) ChecklistItem *itemToEdit;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, strong) IBOutlet UISwitch *switchControl;
@property (nonatomic, strong) IBOutlet UILabel *dueDateLabel;

- (IBAction)cancel;
- (IBAction)done;

@end

