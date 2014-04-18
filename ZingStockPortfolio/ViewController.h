//
//  ViewController.h
//  ZingStockPortfolio
//
//  Created by Michael Ackley on 4/7/14.
//  Copyright (c) 2014 Michael Ackley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAPullToRefresh.h"
#import "QuoteCell.h"
#import "MAFinance.h"


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *stockTable;
     


@property (strong, nonatomic) IBOutlet UIView *btmView;
@property (strong, nonatomic) IBOutlet UILabel *option;
@property (strong, nonatomic) IBOutlet UILabel *stock;
@property (strong, nonatomic) IBOutlet UILabel *available;
@property (strong, nonatomic) IBOutlet UILabel *elTag;

@end
