//
//  ListDetailViewController.m
//  Checklists
//
//  Created by Calvin Cheng on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// TODO: ListDetailViewController has a problem if we are inside the Icon Picker and a low memory warning occurs. 
//       Fix it using the design pattern seen in ItemDetailViewController -> DatePickerViewController

#import "ListDetailViewController.h"
#import "IconPickerViewController.h"
#import "Checklist.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController {
    NSString *iconName;
    NSString *name;
}

@synthesize textField;
@synthesize doneBarButton;
@synthesize delegate;
@synthesize checklistToEdit;
@synthesize iconImageView;

- (void)updateDoneBarButton
{
    self.doneBarButton.enabled = ([name length] > 0);
}

- (void)updateIconName
{
    self.iconImageView.image = [UIImage imageNamed:iconName];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.checklistToEdit !=nil) {
        self.title = @"Edit Checklist";
    }

    self.textField.text = name;
    [self updateDoneBarButton];
    [self updateIconName];
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setDoneBarButton:nil];
    [self setIconImageView:nil];
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{   
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel
{
    [self.delegate listDetailViewControllerDidCancel:self];
    NSLog(@"%@, %@", self.delegate, self);
}

- (IBAction)done
{
    if (self.checklistToEdit == nil) {
        Checklist *checklist = [[Checklist alloc] init];
        checklist.name = self.textField.text;
        checklist.iconName = iconName;
        
        [self.delegate listDetailViewController:self didFinishAddingChecklist:checklist];
    } else {
        self.checklistToEdit.name = self.textField.text;
        self.checklistToEdit.iconName = iconName;
        
        [self.delegate listDetailViewController:self didFinishEditingChecklist:self.checklistToEdit];
    }
    
    
}


- (BOOL)textField:(UITextField *)theTextfield shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    name = [theTextfield.text stringByReplacingCharactersInRange:range withString:string];
    [self updateDoneBarButton];
    return YES;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        iconName = @"Folder";
    }
    return self;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return indexPath;        
    } else {
        return nil;        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickIcon"]) {
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)theIconName
{
    iconName = theIconName;
    self.iconImageView.image = [UIImage imageNamed:iconName];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)theTextField
{
    name = theTextField.text;
    [self updateDoneBarButton];
}

@end