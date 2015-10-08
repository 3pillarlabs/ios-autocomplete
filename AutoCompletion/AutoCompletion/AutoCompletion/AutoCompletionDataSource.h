//
//  AutoCompletionDataSource.h
//  AutoCompletion
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AutoCompletionTextField.h"

@interface AutoCompletionDataSource : NSObject<UITableViewDataSource>

/// The items represented by this data source.
@property (nonatomic, copy) NSArray *suggestItems;

@end
