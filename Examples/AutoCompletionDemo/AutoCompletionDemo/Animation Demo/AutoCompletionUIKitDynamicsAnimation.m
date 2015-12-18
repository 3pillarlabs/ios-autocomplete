//
//  AutoCompletionUIKitDynamicsAnimator.m
//  AutoCompletion
//


@import AutoCompletion;
#import "AutoCompletionUIKitDynamicsAnimation.h"

#define kDefaultDamping 0.2
#define kDefaultFrequency 3

@interface AutoCompletionUIKitDynamicsAnimation ()
{
    UIDynamicAnimator* dynamicAnimator;
}

@end

@implementation AutoCompletionUIKitDynamicsAnimation

- (void)showSuggestionsForTextField:(AutoCompletionTextField*)textField
                              table:(UITableView*)table
                      numberOfItems:(NSInteger)count
{
    if (!dynamicAnimator) {
        dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:textField.superview];
    }
    
    [dynamicAnimator removeAllBehaviors];
    
    table.frame = [textField getAutoCompleteTableViewFrameForNumberOfRows:count];
    
    UIGravityBehavior *gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[table]];
    
    UIAttachmentBehavior *attachementBehavior = [[UIAttachmentBehavior alloc] initWithItem:table attachedToAnchor:textField.center];
    
    float textWidth = textField.bounds.size.width;
    float tableWidth = table.bounds.size.width;
    
    attachementBehavior.damping = kDefaultDamping;
    attachementBehavior.frequency = kDefaultFrequency * (tableWidth/textWidth);
    
    __weak typeof(textField) weakText = textField;
    __weak typeof(table) weakTable = table;
    
    attachementBehavior.action = ^{
        CGRect frame = weakTable.frame;
        CGRect textFrame = [weakText textAbsoluteFrame];
        frame.origin.x = textFrame.origin.x + (textFrame.size.width - frame.size.width)/2;
        weakTable.frame = frame;
    };
    
    [dynamicAnimator addBehavior:gravityBehaviour];
    [dynamicAnimator addBehavior:attachementBehavior];
}

- (void)hideSuggestionsForTextField:(UITextField*)textField
                              table:(UITableView*)table
{
    [dynamicAnimator removeAllBehaviors];
    [table removeFromSuperview];
    
}

@end
