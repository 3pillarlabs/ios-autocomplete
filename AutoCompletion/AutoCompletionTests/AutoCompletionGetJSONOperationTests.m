//
//  AutoCompletionGetJSONOperationTest.m
//  AutoCompletion
//


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Constants.h"
#import "AutoCompletionTextField.h"
#import "APIDataSource.h"
#import "GetJSONOperation.h"

//typedef void (^FetchCompletionBlock)(NSArray *items);

@interface AutoCompletionGetJSONOperationTests : XCTestCase

@end

@implementation AutoCompletionGetJSONOperationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testJSONOperation {
    NSString *urlString = [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?key=%@&q=%@&cx=%@",apiKey,@"exemple", engineID];
    NSURL *downloadURL = [NSURL URLWithString:urlString];
    
    
    // This is an example of a functional test case.
    XCTestExpectation *openExpectation = [self expectationWithDescription:@"search open"];
    
    APIDataSource *apiDataSource = [[APIDataSource alloc] init];
    AutoCompletionTextField *autoCompletionTextField = [[AutoCompletionTextField alloc] initWithFrame:CGRectMake(20, 20, 120 , 46)];
    autoCompletionTextField.suggestionsResultDataSource = apiDataSource;
    
    void (^FetchCompletionBlock)(NSArray *items, NSString *textKey);
      __block __weak void (^CompletionBlock)(NSArray *data, NSString *textKey) = FetchCompletionBlock;
    [apiDataSource fetchSuggestionsForIncompleteString:@"api" withCompletionBlock:^(NSArray *items, NSString *textKey) {
        
        GetJSONOperation *operation = [[GetJSONOperation alloc] initWithDownloadURL:downloadURL withCompletionBlock:CompletionBlock];
        [[NSOperationQueue mainQueue] addOperation:operation];
        XCTAssertNotNil(operation,@"GetJSONOperation is nil");
        XCTAssert([items count] > 0, @"Number of items returned is not what should be");
        [openExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
