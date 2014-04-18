//
//  TicketViewController.m
//  ZingStockPortfolio
//
//  Created by Michael Ackley on 4/8/14.
//  Copyright (c) 2014 Michael Ackley. All rights reserved.
//

#import "TicketViewController.h"

@interface TicketViewController ()

@end

@implementation TicketViewController



- (UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}

- (IBAction)close:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (IBAction)chngeSide:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        segmentedControl.tintColor = [UIColor greenColor];
    }
    else {
        segmentedControl.tintColor = [UIColor redColor];

        
    }

}

- (IBAction)submit:(id)sender {
    // buy or sell stock
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    for (UILabel *vw in self.view.subviews) {
        if ([vw isKindOfClass:[UILabel class]]) {
            
            vw.font = [MAFont customOfSize:vw.font.pointSize];
            
            

        }
    }
    
    
    _subBtn.layer.borderColor = _subBtn.titleLabel.textColor.CGColor;
    _subBtn.layer.borderWidth = 0.8f;
    _subBtn.layer.cornerRadius = 4.0f;
    _subBtn.clipsToBounds = YES;
    if (OrderTypeSell) {
        
        _bsSeg.tintColor = [UIColor redColor];
        _bsSeg.selectedSegmentIndex = 1;
    }
    else{
    
        _bsSeg.tintColor = [UIColor greenColor];

    
    }
    [self fetchStock];
}


- (void)fetchStock
{
    
    
    [MAFinance findStockDataOf:_symbol withBlock:^(NSDictionary *stockData, NSError *error) {
        if (!error) {
            // got data
            
            NSLog(@"DATA %@", stockData);
            
            
            
            _ordSize.text = _shares;
            _ordPrice.text = [NSString stringWithFormat:@"%.02f", [[stockData valueForKey:@"price"]floatValue]];
            
            _name.text = [NSString stringWithFormat:@"%@ : %@",[stockData valueForKey:@"symbol"],[stockData valueForKey:@"name"]];
            
            _last.text = [NSString stringWithFormat:@"%.02f", [[stockData valueForKey:@"price"]floatValue]];
            _vol.text = [stockData valueForKey:@"volume"];
            _exchnge.text = [stockData valueForKey:@"exchange"];
            _bid.text = [NSString stringWithFormat:@"%.02f", [[stockData valueForKey:@"bid"]floatValue]];
            _bSize.text = [stockData valueForKey:@"bidsize"];
            _ask.text = [NSString stringWithFormat:@"%.02f", [[stockData valueForKey:@"ask"]floatValue]];
            _askSize.text = [stockData valueForKey:@"asksize"];
            _prev.text = [stockData valueForKey:@"priceclose"];
            _open.text = [stockData valueForKey:@"priceopen"];
            _perc.text = [stockData valueForKey:@"pricepercentchange"];
            _dol.text = [stockData valueForKey:@"pricedaychange"];
            _high.text = [stockData valueForKey:@"yearhigh"];
            _low.text = [stockData valueForKey:@"yearlow"];
           // _eps.text = [stockData valueForKey:@"eps"];
            _per.text = [stockData valueForKey:@"peratio"];
            _sec.text = [stockData valueForKey:@"sector"];
            _ind.text = [stockData valueForKey:@"industry"];

            
        }
        else {
            NSLog(@"Error - %@", error.description);
        }
    }];

    
}













- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
