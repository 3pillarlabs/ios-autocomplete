//
//  AutoCompletionAnimator.h
//  AutoCompletion
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

