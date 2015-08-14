//
//  AutoCompletionDataSource.h
//  TextFieldSearch
//
//  Created by Flaviu Silaghi on 29/06/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AutoCompletionTextField.h"

@interface AutoCompletionDataSource : NSObject<UITableViewDataSource>

/// The items represented by this data source.
@property (nonatomic, copy) NSArray *suggestItems;

@end
