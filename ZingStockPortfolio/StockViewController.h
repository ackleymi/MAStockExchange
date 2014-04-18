//
//  StockViewController.h
//  ZingStockPortfolio
//
//  Created by Michael Ackley on 4/8/14.
//  Copyright (c) 2014 Michael Ackley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *quoteTable;

- (IBAction)goBack:(id)sender;
- (IBAction)buy:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *topLbl;

@property (strong, nonatomic) NSString *stck;


@end
