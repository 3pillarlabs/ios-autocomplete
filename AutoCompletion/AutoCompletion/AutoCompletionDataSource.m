//
//  AutoCompletionDataSource.m
//  TextFieldSearch
//
//  Created by Flaviu Silaghi on 29/06/15.
//  Copyright (c) 2015 Flaviu Silaghi. All rights reserved.
//

#import "AutoCompletionDataSource.h"
#import "CoreDataOperation.h"

@interface AutoCompletionDataSource ()
{
    CoreDataOperation *operation;
}

@end

@interface AutoCompletionDataSource ()



@end

@implementation AutoCompletionDataSource


#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_suggestItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SearchResultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == 0) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    id object = [_suggestItems objectAtIndex:indexPath.row];
    NSString *text = [object valueForKey:@"title"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",text];
    UIFont *font = [UIFont fontWithName:@"FontAwesome" size:14];
    [cell.textLabel setFont:font];
    return cell;
}

@end
