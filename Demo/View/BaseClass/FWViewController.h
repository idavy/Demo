//
//  FWViewController.h
//  Demo
//
//  Created by Dave on 15/12/3.
//  Copyright © 2015年 Dave. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FWViewModel;

@interface FWViewController : UIViewController
/// Initialization method. This is the preferred way to create a new view.
///
/// viewModel - corresponding view model
///
/// Returns a new view.
- (instancetype)initWithViewModel:(FWViewModel *)viewModel;

/// The `viewModel` parameter in `-initWithViewModel:` method.
@property (nonatomic, strong, readonly) FWViewModel *viewModel;

/// Binds the corresponding view model to the view.
- (void)bindViewModel;

- (void)popCallback:(id)obj;
@end
