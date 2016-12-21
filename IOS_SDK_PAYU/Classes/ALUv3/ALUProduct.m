//
//  ALUProduct.m
//  PAYU_Example
//
//  Created by Max on 25.11.16.
//  Copyright © 2016 IPOL OOO. All rights reserved.
//

#import "ALUProduct.h"

@implementation ALUProduct
@synthesize name;
@synthesize code;
@synthesize price;
@synthesize qty;
@synthesize pinfo;
@synthesize ver;

-(id)initALUProductWithName:(NSString*)Name code:(NSString*)Code price:(NSNumber*)Price qty:(NSUInteger)Qty{
    self=[super init];
    if(self){
        name=Name;
        code=Code;
        price=Price;
        qty=Qty;
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
