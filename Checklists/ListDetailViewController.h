//
//  ListDetailViewController.h
//  Checklists
//
//  Created by Calvin Cheng on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListDetailViewController;
@class Checklist; // we understand that this is a forward declaration of the class Checklist which will be resolved at runtime. But why don't we simpy #import "Checklist.h" - won't that be better? Understanding this helps us to know when to use #import and when to use @class.

@protocol ListDetailViewControllerDelegate <NSObject>

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist;

@end

@interface ListDetailViewController : UITableViewController

@property (nonatomic, strong) IBOutlet UITextField *textField;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneBarButton;

@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) Checklist *checklistToEdit;

@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

- (IBAction)cancel;
- (IBAction)done;

@end
