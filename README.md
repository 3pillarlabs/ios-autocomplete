# AutoCompletion


## Description

A framework which provides text field suggestions as a dropdown list. It is available with iOS 8 and later, Objective-C or Swift.

**Project Rationale**

The purpose of this framework is to provide a simple, yet very useful feature - autocomplete textfield. IOS autocomplete is an iOS module that behaves like a normal text field with the added functionality that it provides suggestions to the user in a dropdown. 

![](screenshots/Autocompletion.gif)

## Installation

Add the "AutoCompletion.framework" to your project. Make sure the framework is added to 'Embedded Binaries' list from the General Tab of the Project Settings.

## Usage

1\. Import **AutoCompletion** framework.
**Objective-C**

```objective-c
@import AutoCompletion; 
```

**Swift**

```swift
import AutoCompletion 
```

2\. Add an autocompletion instance inside a view:

2.1 Drag and drop a UITextField instance in Interface Builder.

![](screenshots/ac_3pg_1.png)

2.2 Change it's class to AutoCompletionTextField.

![](screenshots/ac_3pg_2.png)

2.3 Aditionally, you can customize the text field from Interface Builder.

![](screenshots/ac_3pg_3.png)

2.4 Create a reference of the AutoCompletionTextField.

![](screenshots/ac_3pg_4.png)
<br />
<br />

3\. Set the **suggestionsResultDataSource**. The data source needs to conform to the **AutoCompletionTextFieldDataSource** protocol:

**Swift**

```swift
class AutoCompletionDataSource: NSObject, AutoCompletionTextFieldDataSource {
    func fetchSuggestionsForIncompleteString(incompleteString: String!, withCompletionBlock completion: FetchCompletionBlock!) {
        ...code...
    }
}

...

autoCompletionTextField.suggestionsResultDataSource = AutoCompletionDataSource()
```

**Objective-C**

```objective-c
@interface AutoCompletionDataSource: NSObject <AutoCompletionTextFieldDataSource>
@end

@implementation AutoCompletionDataSource
- (void)fetchSuggestionsForIncompleteString:(NSString*)incompleteString
                        withCompletionBlock:(FetchCompletionBlock)completion {
    ...code...
}
@end

...

autoCompletionTextField.suggestionsResultDataSource = [AutoCompletionDataSource new];
```

4\. Optionally, you can set the **suggestionsResultDelegate** in order to handle the suggestion selection. 

**Swift**

```swift
class ViewController: UIViewController, AutoCompletionTextFieldDelegate {    
    @IBOutlet weak var autoCompletionTextField: AutoCompletionTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        autoCompletionTextField.suggestionsResultDelegate = self
    }
    
    // MARK: Delegate
    
    func textField(textField: AutoCompletionTextField!, didSelectItem selectedItem: AnyObject!) {
		...code...
    }
}
```

**Objective-C**

```objective-c
@interface ViewController: UIViewController <AutoCompletionTextFieldDelegate>

@property (weak, nonatomic) IBOutlet AutoCompletionTextField *autoCompletionTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.autoCompletionTextField.suggestionsResultDelegate = self;
}

#pragma mark - Delegate

- (void)textField:(AutoCompletionTextField*)textField didSelectItem:(id)selectedItem {
	...code...
}
```

5\. Also, you can set the **animationDelegate** in order to provide a custom animation to displaying of the results. It needs to conform to the **AutoCompletionAnimator** protocol:

**Swift**

```swift
class AutoCompletionAnimation: NSObject, AutoCompletionAnimator {
    
    func showSuggestionsForTextField(textField: AutoCompletionTextField!, table: UITableView!, numberOfItems count: Int) {
    	...code...    
   	 }
    
    func hideSuggestionsForTextField(textField: AutoCompletionTextField!, table: UITableView!) {
    	...code...
    }
}

...

autoCompletionTextField.animationDelegate = AutoCompletionAnimation()
```

**Objective-C**

```objective-c
@interface AutoCompletionAnimation: NSObject<AutoCompletionAnimator>
@end

@implementation AutoCompletionAnimation

- (void)showSuggestionsForTextField:(AutoCompletionTextField*)textField
                              table:(UITableView*)table
                      numberOfItems:(NSInteger)count {
	...code...
}
- (void)hideSuggestionsForTextField:(UITextField*)textField
                              table:(UITableView*)table {
	...code...
}

@end

...

autoCompletionTextField.animationDelegate = [AutoCompletionAnimation new];
```
<br />

In the demo project you're able to see a workable example for AutoCompletion where the suggestions results come from three different scenarios: CoreData, JSON, and API.

## License

**AutoCompletion** is released under MIT license. See [LICENSE](LICENSE) for details.  

## About this project
![3Pillar Global] (http://www.3pillarglobal.com/wp-content/themes/base/library/images/logo_3pg.png)

**AutoCompletion** is developed and maintained by [3Pillar Global](http://www.3pillarglobal.com/).


