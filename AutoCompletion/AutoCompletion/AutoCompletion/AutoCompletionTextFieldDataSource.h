//
//  AutoCompletionTextFieldDataSource.h
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 08/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AutoCompletionTextField;
typedef void (^FetchCompletionBlock)(NSArray *items, NSString *textKey);

@protocol AutoCompletionTextFieldDataSource <NSObject>

@required
- (void)fetchSuggestionsForIncompleteString:(NSString*)incompleteString
                 withCompletionBlock:(FetchCompletionBlock)completion;

@end
