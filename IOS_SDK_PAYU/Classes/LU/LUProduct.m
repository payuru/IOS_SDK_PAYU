//
//  Product.m
//  PAYU_Example
//
//  Created by Max on 24.11.16.
//  Copyright © 2016 IPOL OOO. All rights reserved.
//

#import "LUProduct.h"



@implementation LUProduct
@synthesize name;
@synthesize code;
@synthesize price;
@synthesize qty;
@synthesize vat;
@synthesize pgGroup;
@synthesize pinfo;
//@synthesize priceType;


-(id)initLUProductWithName:(NSString*)Name code:(NSString*)Code price:(NSNumber*)Price qty:(NSUInteger)Qty vat:(NSUInteger)Vat{
    self=[super init];
    if(self){
        name=Name;
        code=Code;
        price=Price;
        qty=Qty;
        vat=Vat;
        //priceType=NET;
    }
    return self;
}
-(NSString*)qtyString{
    return  [NSString stringWithFormat:@"%lu",(unsigned long)qty];
}
-(NSString*)vatString{
    return  [NSString stringWithFormat:@"%lu",(unsigned long)vat];
}

@end
