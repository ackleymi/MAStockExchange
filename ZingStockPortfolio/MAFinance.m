//
//  MAFinance.m
//  MAStockGraph
//


#import "MAFinance.h"

@interface MAFinance ()
@end


@implementation MAFinance

/*

- (void)findStockDataWithBlock:(MAFinanceResultBlock)block
{
    symbol = [symbol uppercaseString];
    
    NSString *symbolURL = [self symbolUrlText];
    NSURL *getUrl = [NSURL URLWithString:symbolURL];

    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:getUrl];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue new]
                           completionHandler:^(NSURLResponse *resp, NSData *data, NSError *errorOne) {
                               
                if (!errorOne) {
                                   
                NSDictionary *oneDctnry = [[[[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]valueForKey:@"query"] valueForKey:@"results"]valueForKey:@"quote"];
                                   
                NSString *tnsURL = [self timesalesUrlText];
                NSURL *tnsUrl = [NSURL URLWithString:tnsURL];
                NSMutableURLRequest *requestTwo = [NSMutableURLRequest requestWithURL:tnsUrl];
                [NSURLConnection sendAsynchronousRequest:requestTwo
                        queue:[NSOperationQueue new]
                        completionHandler:^(NSURLResponse *respTwo, NSData *dataTwo, NSError *errorTwo) {
                            
                        if (!errorTwo) {
                                                                  
                        NSDictionary *twoDctnry = [self timesalesFromRawData:[[[[NSJSONSerialization JSONObjectWithData:dataTwo options:NSJSONReadingMutableContainers error:nil]valueForKey:@"query"]valueForKey:@"results"]valueForKey:@"quote"]];
                                                                  
                            NSArray *rversePrices = [[[twoDctnry objectForKey:@"prices"] reverseObjectEnumerator]allObjects];
                            NSArray *rverseDates = [[[twoDctnry objectForKey:@"dates"]reverseObjectEnumerator]allObjects];

                                    NSDictionary *stockData = [NSDictionary dictionaryWithObjects:@[rversePrices,rverseDates,oneDctnry] forKeys:@[@"Prices",@"Dates",@"StockInformation"]];
                            
                                    block(stockData, nil);
                                                                  
                                        }
                                                              
                        else {
                                block(nil, errorTwo);
                                                                  
                            }
                                                              
                            }];
                    }
                    else {
                    block(nil, errorOne);

                        }

            }];
    
    
    
    
}
*/


+ (void)findStockDataOf:(NSString *)symbol withBlock:(MASingleResultBlock)block{
    
    symbol = [symbol uppercaseString];
    
    NSString *symbolURL = [NSString stringWithFormat:@"http://data.benzinga.com/stock/%@", symbol];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:symbolURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                if(!error){
                    // handle response
                      block([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil], nil);
                    
                }
                
                else
                    block(nil, error);
                
            }] resume];

}


+ (void)findPricesOf:(NSArray *)symbols withBlock:(MABatchResultBlock)block{

    
    NSMutableDictionary *stkPrices = [NSMutableDictionary dictionary];
    
    for (NSString *str in symbols) {
        ///
        NSString *stock = [str uppercaseString];
        NSString *symbolURL = [NSString stringWithFormat:@"http://data.benzinga.com/stock/%@", stock];
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:[NSURL URLWithString:symbolURL]
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    
                    if(!error){
                        // handle response
                        
                        [stkPrices setObject:[[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] objectForKey:@"price"] forKey:[[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] objectForKey:@"symbol"]];
                        
                        
                    if ([stkPrices allKeys].count == symbols.count) {
                            
                              block(stkPrices, nil);
                            
                        }
                        
                    }
                    
                    else
                        block(nil, error);
                    
                }] resume];
        
    }
    
    
    
    

}



@end
