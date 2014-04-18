//
//  QuoteCell.h
//  Tickfeed
//
//  Created by Michael Ackley on 2/12/14.
//  Copyright (c) 2014 Pincel, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteCell : UITableViewCell
{
    IBOutlet  UILabel *stock;
    IBOutlet  UILabel *shrs;
    IBOutlet  UILabel *buy;
    IBOutlet  UILabel *sell;


}

@property (strong, nonatomic) IBOutlet UILabel *stock;
@property (strong, nonatomic) IBOutlet UILabel *shrs;
@property (strong, nonatomic) IBOutlet UILabel *buy;
@property (strong, nonatomic) IBOutlet UILabel *sell;


@end
