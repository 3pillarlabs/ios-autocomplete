//
//  JSONItem.m
//  AutoCompletion
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
