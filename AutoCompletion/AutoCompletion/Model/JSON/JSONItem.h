//
//  JSONItem.h
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 08/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONItem : NSObject

@property (nonatomic, retain) NSString * title;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
