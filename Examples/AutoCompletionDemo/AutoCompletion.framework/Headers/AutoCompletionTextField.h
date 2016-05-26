//
//  AutoCompletionTextField.h
//  AutoCompletion
//

#import <UIKit/UIKit.h>
#import "AutoCompletionTextFieldDataSource.h"
#import "AutoCompletionTextFieldDelegate.h"
#import "AutoCompletionAnimator.h"


IB_DESIGNABLE
@interface AutoCompletionTextField : UITextField



/// The width of the suggestion table. The default value is text field width
@property(nonatomic,assign) IBInspectable CGFloat tableWidth;

/// The height of the suggestion table. The default value is 216
@property(nonatomic,assign) IBInspectable NSInteger tableHeight;

/// The suggestion table border color. The default value is [UIColor lightGrayColor]
@property(nonatomic,strong) IBInspectable UIColor *tableBorderColor;

/// The suggestion table corner radius. The default value is 0.0f
@property(nonatomic,assign) IBInspectable CGFloat tableCornerRadius;

/// The suggestion table border width. The default value is 1.0f
@property(nonatomic,assign) IBInspectable CGFloat tableBorderWidth;

/// This will add a vertical and horizontal offset to the suggestion table. The default value is UIOffsetMake(0, 5)
@property(nonatomic,assign) IBInspectable UIOffset tableOffset;

/// Set this in case you make your custom data source and need a different value than the default one. The default value is 44.0f
@property(nonatomic,assign) IBInspectable CGFloat tableRowHeight;

/// Change this value to choose if there will be a separator on the tableview. The default value is YES
@property(nonatomic,assign) IBInspectable BOOL showTableSeparator;

/// The text field border color
@property(nonatomic,strong) IBInspectable UIColor*  borderColor;

/// The text field border width
@property(nonatomic,assign) IBInspectable CGFloat   borderWidth;

/// The text field selected border color
@property(nonatomic,strong) IBInspectable UIColor*  selectedBorderColor;

/// The text field selected border width
@property(nonatomic,assign) IBInspectable CGFloat   selectedBorderWidth;

/// If you want to hide the table view when there is a selection. The default value is YES
@property(nonatomic,assign) IBInspectable BOOL shouldHideTableOnSelection;

/// Set this
@property(nonatomic, strong) id<AutoCompletionTextFieldDataSource> suggestionsResultDataSource;

/// Set this
@property(nonatomic, strong) id<AutoCompletionTextFieldDelegate> suggestionsResultDelegate;

/// Set this
@property(nonatomic, strong) id<AutoCompletionAnimator> animationDelegate;

/// Set this if you need to show the suggestion table directly on the window(for example in case of a table it will look better on the window). The default value is NO
@property(assign) IBInspectable BOOL showOnWindow;


- (CGRect)getAutoCompleteInitialFrame;

- (CGRect)getAutoCompleteTableViewFrameForNumberOfRows:(NSInteger)rows;

- (CGRect)textAbsoluteFrame;

@end

