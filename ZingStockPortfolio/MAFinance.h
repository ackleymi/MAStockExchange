//
//  MAFinance.h
//  MAStockGraph
//

#import <UIKit/UIKit.h>

typedef void (^MASingleResultBlock)(NSDictionary *stockData, NSError *error);
typedef void (^MABatchResultBlock)(NSDictionary *prices, NSError *error);


@interface MAFinance : NSObject


+ (void)findStockDataOf:(NSString *)symbol withBlock:(MASingleResultBlock)block;
+ (void)findPricesOf:(NSArray *)symbols withBlock:(MABatchResultBlock)block;


@end
