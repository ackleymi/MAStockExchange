//
//  TicketViewController.h
//  ZingStockPortfolio
//
//  Created by Michael Ackley on 4/8/14.
//  Copyright (c) 2014 Michael Ackley. All rights reserved.
//

typedef enum {
    OrderTypeBuy,
    OrderTypeSell,
}OrderType;



#import <UIKit/UIKit.h>

@interface TicketViewController : UIViewController <UITextFieldDelegate>
// some inputs
@property (readwrite, assign) OrderType order;
@property (strong, nonatomic) NSString *shares;
@property (strong, nonatomic) NSString *symbol;

- (IBAction)close:(id)sender;

// order details
@property (strong, nonatomic) IBOutlet UITextField *ordSize;
@property (strong, nonatomic) IBOutlet UITextField *ordPrice;
@property (strong, nonatomic) IBOutlet UISegmentedControl *bsSeg;
- (IBAction)chngeSide:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *subBtn;
- (IBAction)submit:(id)sender;

// stock details
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *last;
@property (strong, nonatomic) IBOutlet UILabel *vol;
@property (strong, nonatomic) IBOutlet UILabel *exchnge;
@property (strong, nonatomic) IBOutlet UILabel *bid;
@property (strong, nonatomic) IBOutlet UILabel *bSize;
@property (strong, nonatomic) IBOutlet UILabel *ask;
@property (strong, nonatomic) IBOutlet UILabel *askSize;

@property (strong, nonatomic) IBOutlet UILabel *prev;
@property (strong, nonatomic) IBOutlet UILabel *open;
@property (strong, nonatomic) IBOutlet UILabel *perc;
@property (strong, nonatomic) IBOutlet UILabel *dol;
@property (strong, nonatomic) IBOutlet UILabel *high;
@property (strong, nonatomic) IBOutlet UILabel *low;
@property (strong, nonatomic) IBOutlet UILabel *eps;
@property (strong, nonatomic) IBOutlet UILabel *per;

@property (strong, nonatomic) IBOutlet UILabel *sec;
@property (strong, nonatomic) IBOutlet UILabel *ind;





@end
