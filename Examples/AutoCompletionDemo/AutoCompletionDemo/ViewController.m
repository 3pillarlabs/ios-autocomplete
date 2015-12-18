//
//  ViewController.m
//  AutoCompletion
//

@import AutoCompletion;
#import "ViewController.h"
#import "JSONGenerator.h"
#import "CoreDataDataSource.h"
#import "JSONDataSource.h"
#import "APIDataSource.h"
#import "AutoCompletionUIKitDynamicsAnimation.h"
#import "Items.h"
#import "JSONItem.h"
#import "CoreDataOperation.h"

@interface ViewController ()<AutoCompletionTextFieldDelegate>

@property (weak, nonatomic) IBOutlet AutoCompletionTextField *coreDataTextField;
@property (weak, nonatomic) IBOutlet AutoCompletionTextField *jsonTextField;
@property (weak, nonatomic) IBOutlet AutoCompletionTextField *apiTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AutoCompletionUIKitDynamicsAnimation *animation = [[AutoCompletionUIKitDynamicsAnimation alloc] init];
    CoreDataDataSource *coreDataDataSource = [[CoreDataDataSource alloc] init];
    _coreDataTextField.suggestionsResultDataSource = coreDataDataSource;
    _coreDataTextField.animationDelegate = animation;
    _coreDataTextField.suggestionsResultDelegate = self;
    
    JSONDataSource *jsonDataSource = [[JSONDataSource alloc] init];
    _jsonTextField.suggestionsResultDataSource = jsonDataSource;
    _jsonTextField.suggestionsResultDelegate = self;
    
    APIDataSource *apiDataSource = [[APIDataSource alloc] init];
    _apiTextField.suggestionsResultDataSource = apiDataSource;
    _apiTextField.suggestionsResultDelegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate

- (void)textField:(AutoCompletionTextField*)textField didSelectItem:(id)selectedItem
{
    if ([textField isEqual:_coreDataTextField]) {
        Items *item = selectedItem;
        [textField setText:item.title];
    }
    else if ([textField isEqual:_jsonTextField] || [textField isEqual:_apiTextField]) {
        JSONItem *item = selectedItem;
        [textField setText:item.title];
    }
}

- (void)placeholderTextField:(UITextField *)placeholderTextField didSelectItem:(id)selectedItem {
    Items *item = selectedItem;
    [placeholderTextField setText:item.title];
}

@end
