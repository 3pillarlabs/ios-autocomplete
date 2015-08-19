//
//  AutoCompletionAnimator.h
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 10/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AutoCompletionTextField;
@protocol AutoCompletionAnimator <NSObject>

@required

- (void)showSuggestionsForTextField:(AutoCompletionTextField*)textField
                              table:(UITableView*)table
                      numberOfItems:(NSInteger)count;

- (void)hideSuggestionsForTextField:(AutoCompletionTextField*)textField
                              table:(UITableView*)table;

@end

