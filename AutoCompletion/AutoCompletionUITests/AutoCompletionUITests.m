//
//  AutoCompletionUITests.m
//  AutoCompletionUITests
//
//  Created by Ciprian Zapuc on 7/9/15.
//  Copyright © 2015 Flaviu Silaghi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface AutoCompletionUITests : XCTestCase
@property (nonatomic) XCUIApplication *app;
@property (nonatomic) XCUIElement *coreDataTextField;
@property (nonatomic) XCUIElement *clearTextButton;
@property (nonatomic) XCUIElement *jsonFileTextField;
@end

@implementation AutoCompletionUITests



- (void)setUp {
    [super setUp];
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
    self.coreDataTextField = self.app.textFields[@"coreDataTextField"];
    self.jsonFileTextField = self.app.textFields[@"textFieldJSON"];
    self.clearTextButton = self.app.buttons[@"Clear text"];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_validateTheCoreDataClearTextButton {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [self.coreDataTextField tap];
    [self.app typeText:@"Item 2332"];
    XCTAssert(self.clearTextButton.exists);
}

- (void)test_listOfItemsForCoreData{
    [self.coreDataTextField tap];
    [self.app typeText:@"Item 23328"];
    XCTAssertEqual([self.app.tables.cells elementBoundByIndex:0].exists, true);
}

- (void)test_dismissTheCoreDataClearTextButton{
    //XCUIApplication *app = [[XCUIApplication alloc] init];
    [self.coreDataTextField tap];
    [self.app typeText:@"Item 234"];
    [self.clearTextButton tap];
    XCTAssertEqual(self.clearTextButton.exists, false);
}

- (void)test_clearCoreDataTextField{
    [self.coreDataTextField tap];
    [self.app typeText:@"Item 234"];
    [self.clearTextButton tap];
    XCTAssertEqual([self.app.tables.cells elementBoundByIndex:0].exists, false);
}

- (void)test_selectTheFirstItemFromtheCoreDataList{
    [self.coreDataTextField tap];
    [self.app typeText:@"Item 111"];
    [[self.app.tables.cells elementBoundByIndex:0] tap];
}

- (void)test_validateTheJsonFileClearTextButton {
    [self.jsonFileTextField tap];
    [self.app typeText:@"Item 2332"];
    XCTAssert(self.clearTextButton.exists);
}

- (void)test_listOfItemsForJsonFile{
    [self.jsonFileTextField tap];
    [self.app typeText:@"Item 23328"];
    XCTAssertEqual([self.app.tables.cells elementBoundByIndex:0].exists, true);
}

- (void)test_dismissTheCoreJsonFileTextButton{
    [self.jsonFileTextField tap];
    [self.app typeText:@"Item 234"];
    [self.clearTextButton tap];
    XCTAssertEqual(self.clearTextButton.exists, false);
}

- (void)test_clearJsonFileTextField{
    [self.jsonFileTextField tap];
    [self.app typeText:@"Item 234"];
    [self.clearTextButton tap];
    XCTAssertEqual([self.app.tables.cells elementBoundByIndex:0].exists, false);
}

@end
