//
//  JSONDataSourceTests.m
//  AutoCompletion
//


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "JSONDataSource.h"

@interface JSONDataSourceTests : XCTestCase

@end

@implementation JSONDataSourceTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - integration Testing

- (void)testJSONFetch {
    XCTestExpectation *openExpectation = [self expectationWithDescription:@"search open"];
    
    JSONDataSource *jsonDataSource = [[JSONDataSource alloc] init];
    
    [jsonDataSource fetchSuggestionsForIncompleteString:@"12345" withCompletionBlock:^(NSArray *items, NSString *textKey) {
        XCTAssertNotNil(items,@"Item is nil");
        XCTAssert([items count] == 1, @"Number of items returned is not what should be");
        [openExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
