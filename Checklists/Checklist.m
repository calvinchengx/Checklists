//
//  Checklist.m
//  Checklists
//
//  Created by Calvin Cheng on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Checklist.h"

@implementation Checklist

@synthesize name;
@synthesize items;


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
    }
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder 
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
}


@end
