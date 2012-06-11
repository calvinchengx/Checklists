//
//  AddItemViewController.m
//  Checklists
//
//  Created by Calvin Cheng on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController {
    BOOL shouldRemind;
    NSDate *dueDate;
    NSString *text;
}

@synthesize delegate;
@synthesize textField;
@synthesize doneBarButton;
@synthesize itemToEdit;
@synthesize switchControl;
@synthesize dueDateLabel;

- (IBAction)cancel
{
    [self.delegate itemDetailViewControllerDidCancel:self];
}

- (IBAction)done
{
    if (self.itemToEdit == nil) {
        // Adding a new item if it is not an item that is being edited.
        ChecklistItem *item = [[ChecklistItem alloc] init];
        item.text = self.textField.text;
        item.checked = NO;
        item.shouldRemind = self.switchControl.on;
        item.dueDate = dueDate;
        
        [item scheduleNotification];
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];        
    } else {
        self.itemToEdit.text = self.textField.text;
        self.itemToEdit.shouldRemind = self.switchControl.on;
        self.itemToEdit.dueDate = dueDate;
        
        [self.itemToEdit scheduleNotification];
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
}

- (void)setItemToEdit:(ChecklistItem *)newItem
{
    // writing our custom setter so that we invoke this method whenever we do `controller.itemToEdit = anItem;`
    // This caters to the scenario where a cancelled DatePickerViewController permits us to retrieve the in-memory
    // data sources for the item currently being edited
    if (itemToEdit != newItem) {
        itemToEdit = newItem;
        text = itemToEdit.text;
        shouldRemind = itemToEdit.shouldRemind;
        dueDate = itemToEdit.dueDate;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return indexPath;
    } else {
        return nil;
    }
}

- (void)updateDoneBarButton
{
    self.doneBarButton.enabled = ([text length] > 0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item"; 
    }
    
    self.textField.text = text;
    self.switchControl.on = shouldRemind;
    
    [self updateDoneBarButton];
    [self updateDueDateLabel];
}

- (void)viewDidUnload 
{
    [self setTextField:nil];
    [self setDoneBarButton:nil];
    [self setSwitchControl:nil];
    [self setDueDateLabel:nil];
    [super viewDidUnload];
}

// CUSTOM METHODS //

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
    // giving the text field the control focus. the control
    // becomes the first responder
}


- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    text = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    [self updateDoneBarButton];
    return YES;
}

- (void)updateDueDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.dueDateLabel.text = [formatter stringFromDate:dueDate];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
// sets up connection with the PickDateViewControllerDelegate and pass the current date to the DatePickerViewController
{
    if ([segue.identifier isEqualToString:@"PickDate"]) {
        DatePickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.date = dueDate;
    }
}

- (void)datePickerDidCancel:(DatePickerViewController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date
{
    dueDate = date;
    [self updateDueDateLabel];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)theTextField
{
    text = theTextField.text;
    [self updateDoneBarButton];
}

- (IBAction)switchChanged:(UISwitch *)sender
{
    shouldRemind = sender.on;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        text = @"";
        shouldRemind = NO;
        dueDate = [NSDate date];
    }
    return self;
}

@end