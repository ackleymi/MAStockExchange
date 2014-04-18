//
//  StockViewController.m
//  ZingStockPortfolio
//
//  Created by Michael Ackley on 4/8/14.
//  Copyright (c) 2014 Michael Ackley. All rights reserved.
//

#import "StockViewController.h"
#import "TicketViewController.h"


@interface StockViewController ()
@property (strong, nonatomic) NSMutableDictionary *stckData;

@end

@implementation StockViewController

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (IBAction)goBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (IBAction)buy:(id)sender {
    ///
    
    TicketViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ticket"];
    controller.order = OrderTypeBuy;
    controller.shares = @"100";
    controller.symbol = _stck;
    [self.navigationController pushViewController:controller animated:NO];
    

    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _topLbl.text = [_stck uppercaseString];
    
    [MAFinance findStockDataOf:_stck withBlock:^(NSDictionary *stockData, NSError *error) {
     if (!error) {
     // got data
     
     NSLog(@"DATA %@", stockData);
         _stckData = [NSMutableDictionary dictionaryWithDictionary:stockData];
         [_quoteTable reloadData];
         
     }
     else {
     NSLog(@"Error - %@", error.description);
     }
     }];
 
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        return [[_stckData allKeys]count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell"];
    
    cell.textLabel.text = [[_stckData allKeys]objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[_stckData allValues]objectAtIndex:indexPath.row]];
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@end
