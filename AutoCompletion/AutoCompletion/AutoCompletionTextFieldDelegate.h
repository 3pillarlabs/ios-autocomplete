//
//  AutoCompletionTextFieldDelegate.h
//  AutoCompletion
//
//  Created by Flaviu Silaghi on 08/07/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AutoCompletionTextField;
@protocol AutoCompletionTextFieldDelegate <NSObject>

- (void)textField:(AutoCompletionTextField *)textField didSelectItem:(id)selectedItem;
//- (void)placeholderTextField:(UITextField *)placeholderTextField didSelectItem:(id)selectedItem;

@end
