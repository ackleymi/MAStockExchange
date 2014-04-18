//
//  DataHandler.m
//  ZingStockPortfolio
//
//  Created by Michael Ackley on 4/8/14.
//  Copyright (c) 2014 Michael Ackley. All rights reserved.
//

#import "DataHandler.h"

@implementation DataHandler

+(void)buyStockWithSym:(NSString *)symbol andSize:(NSString *)size{
    
    
    if ([[[self myStockPositions]allKeys] containsObject:symbol]) {
        // add to the position
        
            
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:@"100" forKey:@"NFLX"];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"stocks"];
        [[NSUserDefaults standardUserDefaults] setObject:@"65347.01" forKey:@"balance"];

        
        
        
        
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        //create new position
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"stocks"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}

+(void)sellStockWithSym:(NSString *)symbol andSize:(NSString *)size{

    if ([[[self myStockPositions]allKeys] containsObject:symbol]) {
        // sell the position
        
    } else {
        // no position so return an error
        
    }

}

+(NSMutableDictionary *)myStockPositions{
    
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"stocks"];
}
@end
