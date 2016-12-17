//
//  IOS.h
//  alu
//
//  Created by Demjanko Denis on 02.04.14.
//  Copyright (c) 2014 it-dimension.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IOSResult)(NSDictionary *response, NSError *error);

@interface IOS : NSObject{
    IOSResult completionHandler;
    
    NSString *SECRET_KEY;
    NSString *MERCHANT;
    NSString *REFNOEXT;
}

-(id)initWithSecretKey:(NSString*)_SECRET_KEY Merchant:(NSString*)_MERCHANT Refnoext:(NSString*)_REFNOEXT;

@property (copy) IOSResult completionHandler;

-(void)sendIOSRequestWithResult:(IOSResult)result;

@end

