//
//  QuoteCell.m
//  Tickfeed
//
//  Created by Michael Ackley on 2/12/14.
//  Copyright (c) 2014 Pincel, LLC. All rights reserved.
//

#import "QuoteCell.h"

@implementation QuoteCell
@synthesize stock, shrs, buy, sell;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
