//
//  ChecklistItem.m
//  Checklists
//
//  Created by Calvin Cheng on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem

@synthesize text, checked;

- (void)toggleChecked
{
    self.checked = !self.checked;
}

@end
