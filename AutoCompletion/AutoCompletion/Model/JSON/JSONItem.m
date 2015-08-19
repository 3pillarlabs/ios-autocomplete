//
//  JSONItem.m
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 08/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "JSONItem.h"

@implementation JSONItem

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    
    
    if (self = [super init]) {
        self.title = [dictionary valueForKey:@"title"];
    }
    
    return self;
}

@end
