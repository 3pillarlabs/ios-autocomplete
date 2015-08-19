//
//  JSONManager.h
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 08/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONManager : NSObject

+ (NSArray*) items;
+ (NSArray *)getItemsFromApiResponseDataObject:(NSData *)responseData;

@end
