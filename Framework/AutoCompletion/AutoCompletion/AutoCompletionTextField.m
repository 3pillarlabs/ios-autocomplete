//
//  AutoCompletionTextField.m
//  AutoCompletion
//


#import "AutoCompletionTextField.h"
#import "AutoCompletionDataSource.h"
#import "QuartzCore/QuartzCore.h"

#define kDefaultDamping 0.2
#define kDefaultFrequency 3

@interface AutoCompletionTextField ()<UITableViewDelegate> {
}

@property (strong, nonatomic) UITableView *autocompleteTableView;
@property (strong, nonatomic) AutoCompletionDataSource *dataSource;
@property (strong, nonatomic) UITextField *placeholderTextField;

@end

@implementation AutoCompletionTextField

#pragma mark - Initialize

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _autocompleteTableView = [[UITableView alloc] initWithFrame:[self getAutoCompleteInitialFrame] style:UITableViewStylePlain];
    _autocompleteTableView.delegate = self;
    
    _dataSource = [[AutoCompletionDataSource alloc] init];
    _autocompleteTableView.dataSource = _dataSource;

    [self setDefaultValues];
    [self addSuggestionPlaceholderTextField];
}

- (void)setDefaultValues
{
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tableHeight = 216;
    _tableWidth = NSNotFound;
    self.tableBorderColor = [UIColor lightGrayColor];
    self.tableCornerRadius = 4.0f;
    self.tableBorderWidth = 0.5f;
    _tableOffset = UIOffsetMake(0, 5);
    _shouldHideTableOnSelection = YES;
    _tableRowHeight = 44.0;
    _showOnWindow = NO;
    CGRect frame = [self getAutoCompleteInitialFrame];
    _autocompleteTableView.frame = frame;
}

- (void)addSuggestionPlaceholderTextField {
    self.placeholderTextField = [[UITextField alloc]initWithFrame:self.bounds];
    self.placeholderTextField.font = self.font;
    self.placeholderTextField.adjustsFontSizeToFitWidth = YES;
    self.placeholderTextField.clipsToBounds = YES;
    self.placeholderTextField.backgroundColor = [UIColor clearColor];
    self.placeholderTextField.textColor = [UIColor lightGrayColor];
    self.placeholderTextField.textAlignment = self.textAlignment;
    self.placeholderTextField.userInteractionEnabled = NO;
    self.placeholderTextField.borderStyle = self.borderStyle;
    [self addSubview:self.placeholderTextField];
    self.backgroundColor = [UIColor clearColor];
}

- (NSString *)extractSubstringFromString:(NSString *)originalString
                      startingWithString:(NSString *)userInputString {
    
    if ([userInputString length] == 0) {
        return originalString;
    }
    
    if ([originalString rangeOfString:userInputString options:NSCaseInsensitiveSearch].location != NSNotFound) {
        NSRange range = [originalString rangeOfString:userInputString options:NSCaseInsensitiveSearch];
        return [originalString substringWithRange:NSMakeRange(range.location, [originalString length] - range.location)];
    } else {
        return @"";
    }
}

#pragma mark - Setters

- (void)setTableBorderColor:(UIColor *)tableBorderColor
{
    _tableBorderColor = tableBorderColor;
    _autocompleteTableView.layer.borderColor = tableBorderColor.CGColor;
}

- (void)setTableCornerRadius:(CGFloat)tableCornerRadius
{
    _tableCornerRadius = tableCornerRadius;
    _autocompleteTableView.layer.cornerRadius = tableCornerRadius;
}

- (void)setTableBorderWidth:(CGFloat)tableBorderWidth
{
    _tableBorderWidth = tableBorderWidth;
    _autocompleteTableView.layer.borderWidth = tableBorderWidth;
}

- (void)setTableWidth:(CGFloat)tableWidth
{
    if (tableWidth == 0)
    {
        _tableWidth = NSNotFound;
    }
    else
    {
        _tableWidth = tableWidth;
    }
}

- (void)setTableOffset:(UIOffset)tableOffset
{
    _tableOffset = tableOffset;
}

- (void)setShowSeparator:(BOOL)showSeparator
{
    if (showSeparator)
    {
        _autocompleteTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    else
    {
        _autocompleteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setSelectBorders
{
    self.layer.borderColor = _selectedBorderColor.CGColor;
    self.layer.borderWidth = _selectedBorderWidth;
}

- (void)setUnselectedBorders
{
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.borderWidth = _borderWidth;
}

- (void)setSuggestionsResultDataSource:(id<AutoCompletionTextFieldDataSource>)suggestionsResultDataSource
{
    NSAssert([suggestionsResultDataSource conformsToProtocol:@protocol(AutoCompletionTextFieldDataSource)], @"Your data source does not conform to the AutoCompletionTextFieldDataSource protocol");
    _suggestionsResultDataSource = suggestionsResultDataSource;
}

- (void)setAnimationDelegate:(id<AutoCompletionAnimator>)animationDelegate
{
    NSAssert([animationDelegate conformsToProtocol:@protocol(AutoCompletionAnimator)], @"Your animator does not conform to the AutoCompletionAnimator protocol");
    _animationDelegate = animationDelegate;
}

#pragma mark - Data Fetch

- (void)reloadData
{
    if (_suggestionsResultDataSource && [_suggestionsResultDataSource respondsToSelector:@selector(fetchSuggestionsForIncompleteString:withCompletionBlock:)])
    {
        __weak typeof(self) weakSelf = self;
        [_suggestionsResultDataSource fetchSuggestionsForIncompleteString:self.text withCompletionBlock:^(NSArray *items, NSString *textKey) {
            
            NSAssert([NSThread isMainThread], @"This completion block must be called on the main thread");
            
            [weakSelf.dataSource setSuggestItems:[NSArray arrayWithArray:items]];
            [weakSelf.autocompleteTableView reloadData];
            if ([items count] > 0)
            {
                NSInteger rows = items.count;
                [weakSelf showSuggestionsTableViewForNumberOfRows:rows];
                id item = items[0];
                if ([item valueForKey:textKey]) {
                    [self updateSuggestionPlaceholderTextFieldWithString:[self extractSubstringFromString:[item valueForKey:textKey] startingWithString:self.text] ];
                } else {
                    [self updateSuggestionPlaceholderTextFieldWithString:@""];
                }
            }
            else
            {
                [weakSelf hideSuggestionsTableView];
                [weakSelf updateSuggestionPlaceholderTextFieldWithString:@""];
            }
        }];
    }
}

- (void)updateSuggestionPlaceholderTextFieldWithString:(NSString *)suggestionString {
    self.placeholderTextField.text = suggestionString;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_suggestionsResultDelegate && [_suggestionsResultDelegate respondsToSelector:@selector(textField:didSelectItem:)])
    {
        NSArray *suggestedItems = [_dataSource suggestItems];
        id item = [suggestedItems objectAtIndex:indexPath.row];
        [_suggestionsResultDelegate textField:self didSelectItem:item];
        self.placeholderTextField.text = @"";
    }
    
    if (_shouldHideTableOnSelection)
    {
        [self hideSuggestionsTableView];
    }
}

#pragma mark - Open/Close

- (void)showSuggestionsTableViewForNumberOfRows:(NSInteger)rows
{
    if (_showOnWindow)
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_autocompleteTableView];
    }
    else
    {
        UIView *superview = self.superview;
        [superview addSubview:_autocompleteTableView];
    }
    
    if (_animationDelegate && [_animationDelegate respondsToSelector:@selector(showSuggestionsForTextField:table:numberOfItems:)])
    {
        [_animationDelegate showSuggestionsForTextField:self table:_autocompleteTableView numberOfItems:rows];
    }
    else
    {
        
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _autocompleteTableView.frame = [self getAutoCompleteTableViewFrameForNumberOfRows:rows];
        } completion:nil];
    }
}

- (void)hideSuggestionsTableView
{
    if (_animationDelegate && [_animationDelegate respondsToSelector:@selector(hideSuggestionsForTextField:table:)])
    {
        [_animationDelegate hideSuggestionsForTextField:self table:_autocompleteTableView];
    }
    else
    {
        [_autocompleteTableView removeFromSuperview];
    }
}

- (void)hidePlaceholder
{
    if (![self.text isEqualToString:_placeholderTextField.text]) {
        _placeholderTextField.text = @"";
    }
}

#pragma mark - Add Observers

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginNotification:) name:UITextFieldTextDidBeginEditingNotification object:self];
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - First Responder

- (BOOL)becomeFirstResponder
{
    [self addObservers];
    [self setSelectBorders];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self removeObservers];
    [self setUnselectedBorders];
    [self hideSuggestionsTableView];
    [self hidePlaceholder];
    
    return [super resignFirstResponder];
}

#pragma mark - Notifications

- (void)textFieldDidChangeNotification:(NSNotification*)notification
{
    if (notification.object == self) {
        [self reloadData];
    }
}

- (void)textFieldDidBeginNotification:(NSNotification*)notification
{
    if (notification.object == self) {
        [self reloadData];
    }
}

#pragma mark - Frames

- (CGRect)getAutoCompleteInitialFrame
{
    CGRect frame = CGRectZero;
    CGRect textFrame;
    if (_showOnWindow)
    {
        textFrame = [self textAbsoluteFrame];
    }
    else
    {
        textFrame = self.frame;
    }
    
    frame.origin.y = textFrame.size.height + textFrame.origin.y + _tableOffset.vertical;
    frame.origin.x = textFrame.origin.x + (self.frame.size.width - textFrame.size.width)/2 + _tableOffset.horizontal;
    
    if (_tableWidth != NSNotFound)
    {
        frame.size.width = _tableWidth;
    }
    else
    {
        frame.size.width = textFrame.size.width;
    }
    
    return frame;
}

- (CGRect)getAutoCompleteTableViewFrameForNumberOfRows:(NSInteger)rows
{
    CGRect frame = [self getAutoCompleteInitialFrame];
    
    frame.size.height = [self getTableViewHeightForNumberOfRows:rows];
    
    return frame;
}

- (CGFloat)getTableViewHeightForNumberOfRows:(NSInteger)rows
{
    CGFloat height = 0;
    CGFloat rowHeight = _tableRowHeight;
    height = rowHeight * rows;
    if (height > _tableHeight)
    {
        height = _tableHeight;
    }
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    float windowHeight = window.frame.size.height;
    CGRect textFrame = [self textAbsoluteFrame];
    if (textFrame.origin.y + textFrame.size.height + height > windowHeight)
    {
        height = windowHeight - (textFrame.origin.y + textFrame.size.height + 5 + _tableOffset.vertical);
    }
    
    return height;
}

- (CGRect)textAbsoluteFrame
{
    return [self.superview convertRect:self.frame toView:nil];
}

@end
