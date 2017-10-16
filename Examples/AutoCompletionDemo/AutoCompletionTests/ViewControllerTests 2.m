//
//  ViewControllerTests.m
//  AutoCompletion
//


@import AutoCompletion;
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface ViewController (Test)

@property (weak, nonatomic) IBOutlet AutoCompletionTextField *coreDataTextField;
@property (weak, nonatomic) IBOutlet AutoCompletionTextField *jsonTextField;
@property (weak, nonatomic) IBOutlet AutoCompletionTextField *apiTextField;

@end

@interface ViewControllerTests : XCTestCase

@property (strong,nonatomic) ViewController *vc;
@property (strong,nonatomic) UIStoryboard *mainStoryboard;

@end

@implementation ViewControllerTests

- (void)setUp {
    [super setUp];
    self.mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.vc = (ViewController *)[self.mainStoryboard instantiateInitialViewController];
    [self.vc.view subviews];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCoreDataTextFieldOutletShouldBeConnected {
    NSLog(@"coreDataTextField = %@",self.vc.coreDataTextField);
    XCTAssertNotNil(self.vc.coreDataTextField,@"CoreDataTextField is nil");
}

- (void)testJSONTextFieldOutletShouldBeConnected {
    XCTAssertNotNil(self.vc.jsonTextField,@"JSONTextField is nil");
}

- (void)testAPITextFieldOutletShouldBeConnected {
    XCTAssertNotNil(self.vc.apiTextField,@"APITextField is nil");
}

@end
