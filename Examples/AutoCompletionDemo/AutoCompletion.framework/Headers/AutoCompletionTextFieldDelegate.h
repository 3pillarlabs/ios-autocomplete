//
//  AutoCompletionTextFieldDelegate.h
//  AutoCompletion
//


#import <Foundation/Foundation.h>

@class AutoCompletionTextField;
@protocol AutoCompletionTextFieldDelegate <NSObject>

- (void)textField:(AutoCompletionTextField *)textField didSelectItem:(id)selectedItem;

@end
