//
//  FWTableViewController.h
//  Demo
//
//  Created by Dave on 15/12/3.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import "FWViewController.h"
#import "UIScrollView+EmptyDataSet.h"
@class TPKeyboardAvoidingTableView;
@interface FWTableViewController : FWViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/// The table view for tableView controller.
@property (nonatomic, strong, readonly) UISearchBar *searchBar;
@property (nonatomic, strong, readonly) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, assign, readonly) UIEdgeInsets contentInset;

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end
