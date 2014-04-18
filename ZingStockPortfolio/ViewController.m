//
//  ViewController.m
//  ZingStockPortfolio
//
//  Created by Michael Ackley on 4/7/14.
//  Copyright (c) 2014 Michael Ackley. All rights reserved.
//

#import "ViewController.h"
#import "StockViewController.h"
#import "TicketViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *thresholdView;
@property (nonatomic, strong) AAPullToRefresh *tv;
@end

@implementation ViewController

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITextField *field = [_searchBar valueForKey:@"_searchField"];
    
    field.tintColor = [UIColor whiteColor];
     field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Quote" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImageView *iconView = (id)field.leftView;
    iconView.image = [iconView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    iconView.tintColor = [UIColor whiteColor];
    
    
    
    [field setLeftViewMode:UITextFieldViewModeAlways];
    [field.leftView setTintColor:[UIColor whiteColor]];
    UIImageView *lView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
    lView.image = [UIImage imageNamed: @"glass1.png"];
    
    
    field.textColor = [UIColor whiteColor];
    field.font = [MAFont customOfSize:15.0];
    
    [self loadPortfolio];

    
    CGRect rect = self.stockTable.bounds;
    rect.size.height = self.stockTable.contentSize.height;
    self.thresholdView = [[UIView alloc] initWithFrame:rect];
    self.thresholdView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.thresholdView.userInteractionEnabled = NO;
    self.thresholdView.backgroundColor = [UIColor clearColor];
    [self.stockTable addSubview:self.thresholdView];
    __unsafe_unretained typeof(self) weakSelf = self;
    
    // top
    _tv = [self.stockTable addPullToRefreshPosition:AAPullToRefreshPositionTop actionHandler:^(AAPullToRefresh *v){
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [weakSelf loadPortfolio];
            
        });
        
    }];
    _tv.imageIcon = [UIImage imageNamed:@"clearhold"];
    _tv.borderColor = [UIColor colorWithRed:(51/255.0) green:(153/255.0) blue:(204/255.0) alpha:1.0];
    
    
    
    

}

- (void)viewWillLayoutSubviews
{
    CGRect rect = self.stockTable.bounds;
    rect.size.height = self.stockTable.contentSize.height;
    self.thresholdView.frame = rect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.thresholdView;
}

- (void)loadPortfolio
{
    // format portfolio values
    for(UILabel *lbl in [_btmView subviews]) {
        lbl.font = [MAFont customOfSize:17.0];
    }
    _elTag.font = [MAFont customOfSize:10.0];
    
    
    
    NSNumberFormatter* numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSInteger cash = [[[NSUserDefaults standardUserDefaults]objectForKey:@"balance"] integerValue];
   
    _available.text = [numberFormatter stringFromNumber: [NSNumber numberWithInt:cash]];
    
        
        
   [MAFinance findPricesOf:[[DataHandler myStockPositions] allKeys] withBlock:^(NSDictionary *prices, NSError *error) {
       if (!error) {
           // got data
           
           int mktVal = 0;
           for (NSString *str in [[DataHandler myStockPositions] allKeys]) {
               mktVal = mktVal + ([[[DataHandler myStockPositions]valueForKey:str]integerValue] * [[prices valueForKey:str]integerValue]);
            }
           
           
           int totalValue = cash + mktVal;
           
           _option.text = [numberFormatter stringFromNumber: [NSNumber numberWithInt:totalValue]];

           _stock.text = [numberFormatter stringFromNumber: [NSNumber numberWithInt:(totalValue * 2)]];
           

           
       } else {
           NSLog(@"Error - %@", error.description);
           
       }
   }];
    
    _stockTable.tableFooterView = [UIView new];
    [_stockTable reloadData];
    [_tv stopIndicatorAnimation];

}

#pragma mark - UISearchBar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    
     StockViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"stock"];
    controller.stck = _searchBar.text;
    [self.navigationController pushViewController:controller animated:NO];





}





#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        
        return [[DataHandler myStockPositions]allKeys].count;
        
    }
    else{
        return 0;}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	QuoteCell *cell = (QuoteCell *)[tableView dequeueReusableCellWithIdentifier: @"Cell"];
    cell.stock.text = [[[DataHandler myStockPositions] allKeys] objectAtIndex:indexPath.row];
    cell.shrs.text = [NSString stringWithFormat:@"%@ shares", [[[DataHandler myStockPositions] allValues] objectAtIndex:indexPath.row]];
    
    cell.stock.font = [MAFont customOfSize:17.0];
    cell.shrs.font = [MAFont customOfSize:14.0];
    cell.buy.font = [MAFont customOfSize:14.0];
    cell.sell.font = [MAFont customOfSize:14.0];
    
    for(UIView *subview in [cell.contentView subviews]) {
        if([subview isKindOfClass:[UIButton class]]) {
                [subview removeFromSuperview];
            }
        }
    
        UIButton *sellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sellBtn setTag:indexPath.row];
        [sellBtn addTarget:self
                action:@selector(sellStock:)
        forControlEvents:UIControlEventTouchUpInside];
        sellBtn.frame = cell.sell.frame;
        sellBtn.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:sellBtn];
    
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [buyBtn setTag:indexPath.row];
        [buyBtn addTarget:self
                action:@selector(buyStock:)
        forControlEvents:UIControlEventTouchUpInside];
        buyBtn.frame = cell.buy.frame;
        buyBtn.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:buyBtn];
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20;}
        else{
            return 175;}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *hView = [UIView new];
        hView.frame = CGRectMake(0, 0, 320, 30);
        hView.backgroundColor = [UIColor darkGrayColor];
        UILabel *lbl = [UILabel new];
        lbl.text = @"  Positions";
        lbl.font = [MAFont customOfSize:12.0];
        lbl.textColor = [UIColor whiteColor];
        [hView addSubview:lbl];
        lbl.frame = CGRectMake(2, 0, 320, 20);
        return hView;
    }
    else{
        return _btmView;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
       
    // NoteViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"noteView"];
    
}

- (void)sellStock:(UIButton*)sender{
    
    TicketViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ticket"];
    controller.order = OrderTypeSell;
  //  controller.shares = @"100";
   // controller.symbol = _stck;
    [self.navigationController pushViewController:controller animated:NO];
    
}

- (void)buyStock:(UIButton*)sender{
    
    TicketViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ticket"];
    controller.order = OrderTypeBuy;
  //  controller.shares = @"100";
   // controller.symbol = _stck;
    [self.navigationController pushViewController:controller animated:NO];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
