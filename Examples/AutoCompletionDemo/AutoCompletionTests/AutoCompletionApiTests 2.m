//
//  AutoCompletionApiTest.m
//  AutoCompletion
//

@import AutoCompletion;
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "APIDataSource.h"

@interface AutoCompletionApiTests : XCTestCase
@property (nonatomic,strong) AutoCompletionTextField *autoCompletionTextField;
@property (nonatomic, strong) APIDataSource *apiDataSource;
@property (nonatomic, strong) XCTestExpectation *expectation;
@end

@implementation AutoCompletionApiTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _apiDataSource = [[APIDataSource alloc] init];
    _autoCompletionTextField = [[AutoCompletionTextField alloc] initWithFrame:CGRectMake(20, 20, 120 , 46)];
    _autoCompletionTextField.suggestionsResultDataSource = _apiDataSource;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testApiSearchResponse {
    XCTestExpectation *expectationTest = [self expectationWithDescription:@"Googe Api Search"];
    
    [_apiDataSource fetchSuggestionsForIncompleteString:@"test" withCompletionBlock:^(NSArray *items, NSString *textKey) {
        XCTAssertNotNil(items,@"Items are nil");
        NSLog(@"The search result is %lu items", (unsigned long)items.count);
        [expectationTest fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
}

- (void)testApiSearchForCancelledRequests{
    self.expectation = [self expectationWithDescription:@"Requests Cancelled"];
    
    [_apiDataSource fetchSuggestionsForIncompleteString:@"api" withCompletionBlock:^(NSArray *items, NSString *textKey) {
        XCTAssertNil(items , @"First search result was cancelled");
        
    }];
    

    [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(startSecondRequest) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(startThirdRequest) userInfo:nil repeats:NO];
    
    [self waitForExpectationsWithTimeout:20.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)startSecondRequest{
    
    [_apiDataSource fetchSuggestionsForIncompleteString:@"search" withCompletionBlock:^(NSArray *items, NSString *textKey) {
        XCTAssert(items != nil, @"Second search result was cancelled");
        
    }];
}

- (void)startThirdRequest{
    
    [_apiDataSource fetchSuggestionsForIncompleteString:@"success" withCompletionBlock:^(NSArray *items, NSString *textKey) {
        XCTAssert(items != nil);
        NSLog(@"Third search result succeded with %lu items", (unsigned long)items.count);
        [_expectation fulfill];
    }];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
