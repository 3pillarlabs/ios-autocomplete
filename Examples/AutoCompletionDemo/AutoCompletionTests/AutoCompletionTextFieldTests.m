//
//  AutoCompletionTextFieldTests.m
//  AutoCompletion
//


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AutoCompletionTextField.h"
#import "AutoCompletionUIKitDynamicsAnimation.h"
#import "CoreDataDataSource.h"
#import "JSONDataSource.h"
#import "APIDataSource.h"
#import "Items.h"

@interface AutoCompletionTextField (Test)

@property(strong,nonatomic) UITableView *autocompleteTableView;

@end

@interface AutoCompletionTextFieldTests : XCTestCase<AutoCompletionTextFieldDelegate>

@property(nonatomic,strong) AutoCompletionTextField *textField;

@end

@implementation AutoCompletionTextFieldTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _textField = [[AutoCompletionTextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTableWidth {
    [_textField setTableWidth:500];
    CGRect frame = [_textField getAutoCompleteInitialFrame];
    XCTAssertTrue(frame.size.width == 500,@"Table width is not set correctly");
}

- (void)testTableBorderColor {
    [_textField setTableBorderColor:[UIColor blueColor]];
    UIColor *color = [UIColor colorWithCGColor:_textField.autocompleteTableView.layer.borderColor];
    XCTAssertTrue([color isEqual:[UIColor blueColor]], @"Table border color is not set correctly");
}

- (void)testTableCornerRadius {
    [_textField setTableCornerRadius:3];
    float radius = _textField.autocompleteTableView.layer.cornerRadius;
    XCTAssertTrue(radius == 3,@"Table corner radius is not set correctly");
}

- (void)testTableBorderWidth {
    [_textField setTableBorderWidth:2];
    float width = _textField.autocompleteTableView.layer.borderWidth;
    XCTAssertTrue(width == 2,@"Table border width is not set correctly");
}

- (void)testTableSeparator {
    [_textField setShowTableSeparator:YES];
    UITableViewCellSeparatorStyle style =  _textField.autocompleteTableView.separatorStyle;
    XCTAssertEqual(style, UITableViewCellSeparatorStyleSingleLine,@"Separator style is not set correctly");
}

- (void)testBorderColor {
    [_textField setBorderColor:[UIColor blueColor]];
    UIColor *color = [UIColor colorWithCGColor:_textField.layer.borderColor];
    XCTAssertTrue([color isEqual:[UIColor blueColor]], @"Border color is not set correctly");
}

- (void)testBorderWidth {
    [_textField setBorderWidth:2.0];
    float width = _textField.layer.borderWidth;
    XCTAssertTrue(width == 2.0, @"Border width is not set correctly");
}

- (void)testSuggestedResultDataSource {
    CoreDataDataSource *dataSource = [[CoreDataDataSource alloc] init];
    _textField.suggestionsResultDataSource = dataSource;
    XCTAssertNotNil(_textField.suggestionsResultDataSource,@"Data source failed to be assigned");
}

- (void)testSuggestedResultDelegate {
    _textField.suggestionsResultDelegate = self;
    XCTAssertNotNil(_textField.suggestionsResultDelegate,@"Delegate failed to be assigned");
}

@end
