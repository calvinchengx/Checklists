//
//  Checklist.m
//  Checklists
//
//  Created by Calvin Cheng on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Checklist.h"
#import "ChecklistItem.h"

@implementation Checklist

@synthesize name;
@synthesize items;
@synthesize iconName;

- (id)init
{
    if ((self = [super init])) {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
        self.iconName = @"No Icon";
    }
    return self;
}

-(NSMutableArray *)items
{
    if(!items) {
        items = [[NSMutableArray alloc] init];
    }
    return items;
}

- (NSComparisonResult)compare:(Checklist *)otherChecklist
{
    return [self.name localizedCaseInsensitiveCompare:otherChecklist.name];
}

- (int)countUncheckedItems
{
    int count = 0;
    for (ChecklistItem *item in self.items) {
        if (!item.checked) {
            count += 1;
        }
    }
    return count;
}

// Equivalent code - (id)init and -(NSMutableArray *)items

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
        self.iconName = [aDecoder decodeObjectForKey:@"IconName"];
    }
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder 
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
}


@end
