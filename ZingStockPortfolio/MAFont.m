//
//  MAFont.m
//  Novalist
//
//  Created by Michael Ackley on 4/2/14.
//  Copyright (c) 2014 Pincel, LLC. All rights reserved.
//

#import "MAFont.h"
#import <CoreText/CoreText.h>

@implementation MAFont

+ (UIFont *)customOfSize:(CGFloat)size {
    
  //  static dispatch_once_t onceToken;
  //  dispatch_once(&onceToken, ^{
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"lato" withExtension:@"ttf"];
		CFErrorRef error;
        CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
        error = nil;
   // });
    return [UIFont fontWithName:@"lato" size:size];
}

@end
