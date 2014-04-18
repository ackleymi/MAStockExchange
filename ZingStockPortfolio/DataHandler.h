//
//  DataHandler.h
//  ZingStockPortfolio
//
//  Created by Michael Ackley on 4/8/14.
//  Copyright (c) 2014 Michael Ackley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandler : NSObject

+ (void)sellStockWithSym:(NSString *)symbol andSize:(NSString *)size;
+ (void)buyStockWithSym:(NSString *)symbol andSize:(NSString *)size;

+ (NSMutableDictionary *)myStockPositions;


@end
