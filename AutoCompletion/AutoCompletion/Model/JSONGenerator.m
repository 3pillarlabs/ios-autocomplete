//
//  JSONGenerator.m
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 08/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "JSONGenerator.h"

@implementation JSONGenerator

- (instancetype)init
{
    if (self = [super init])
    {
        [self generateFile];
    }
    return self;
}

- (void)generateFile
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 50000; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[NSString stringWithFormat:@"Item %d",i] forKey:@"title"];
        [array addObject:dict];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *path = [basePath stringByAppendingPathExtension:@"file.json"];
    NSLog(@"path:%@",path);
    [data writeToFile:path atomically:YES];
}

@end
