//
//  MCHelper.m
//  PAYU_Example
//
//  Created by Max on 25.11.16.
//  Copyright © 2016 IPOL OOO. All rights reserved.
//
#import "PAYHelper.h"
#import "LUProduct.h"

@implementation PAYHelper


-(id)init{
    self=[super init];
    if(self){
        dicKey=[NSMutableDictionary new];
        dicHashKey=[NSMutableDictionary new];
    }
    return self;
}

-(void)addObject:(NSString*)value key:(NSString*)key hash:(BOOL)hashFlag{
    if(key!=nil&&value!=nil){
        [dicKey setObject:[NSString stringWithFormat:@"%@=%@", key, value] forKey:key];
        if(hashFlag){
            [dicHashKey setObject:[NSString stringWithFormat:@"%lu%@", [value lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , value] forKey:key];
        }
    }
    
}
-(NSString*)postString{
    NSMutableString *str=[[NSMutableString alloc] init];
    NSArray *sortedKeys = [[dicKey allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    for (NSString *key in sortedKeys) {
        NSString *encodedValue = [dicKey objectForKey:key];
        [str appendFormat:@"%@&",encodedValue];
    }
    if(str.length>1)
        [str deleteCharactersInRange:NSMakeRange([str length]-1, 1)];
    return str;
}
-(NSString*)hashString{
    NSMutableString *str=[[NSMutableString alloc] init];
    NSArray *sortedKeys = [[dicHashKey allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    for (NSString *key in sortedKeys) {
        NSString *encodedValue = [dicHashKey objectForKey:key];
        [str appendFormat:@"%@",encodedValue];
    }
    return str;
}


-(NSString*)LUpostStringWithProducts:(NSMutableArray*)products{
    NSMutableString *str=[[NSMutableString alloc] init];
  //  [str appendFormat:@"%@&",[dicKey objectForKey:@"MERCHANT"]];
  //  [str appendFormat:@"%@&",[dicKey objectForKey:@"ORDER_REF"]];
  //  [str appendFormat:@"%@&",[dicKey objectForKey:@"ORDER_DATE"]];

    
    NSArray *sortedKeys = [[dicKey allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    for (NSString *key in sortedKeys) {
       // if([key isEqualToString:@"MERCHANT"]||[key isEqualToString:@"ORDER_REF"]||[key isEqualToString:@"ORDER_DATE"]||[key isEqualToString:@"ORDER_PGROUP"]||[key isEqualToString:@"ORDER_PRICE_TYPE"]){
       // }else{
            NSString *encodedValue = [dicKey objectForKey:key];
            [str appendFormat:@"%@&",encodedValue];
    }
    
    
    
    //products
    for (LUProduct *product in products) {
        if(product.name!=nil)
            [str appendFormat:@"ORDER_PNAME[]=%@&",product.name];
        if(product.code!=nil)
            [str appendFormat:@"ORDER_PCODE[]=%@&",product.code];
        if([product.price stringValue]!=nil)
            [str appendFormat:@"ORDER_PRICE[]=%@&",[product.price stringValue]];
        if(product.qtyString!=nil)
            [str appendFormat:@"ORDER_QTY[]=%@&",product.qtyString];
        if(product.vatString!=nil)
            [str appendFormat:@"ORDER_VAT[]=%@&",product.vatString];
        if(product.pgGroup!=nil)
            [str appendFormat:@"ORDER_PGROUP[]=%@&",product.pgGroup];
        if(product.pinfo!=nil)
            [str appendFormat:@"ORDER_PINFO[]=%@&",product.pinfo];
    }
 /*   for (LUProduct *product in products) {
        if(product.name!=nil)
            [str appendFormat:@"ORDER_PNAME[]=%@&",product.name];
    }
    for (LUProduct *product in products) {
        if(product.code!=nil)
            [str appendFormat:@"ORDER_PCODE[]=%@&",product.code];
    }
    for (LUProduct *product in products) {
        if([product.price stringValue]!=nil)
            [str appendFormat:@"ORDER_PRICE[]=%@&",[product.price stringValue]];
    }
    for (LUProduct *product in products) {
        if(product.qtyString!=nil)
            [str appendFormat:@"ORDER_QTY[]=%@&",product.qtyString];
    }
    for (LUProduct *product in products) {
        if(product.vatString!=nil)
            [str appendFormat:@"ORDER_VAT[]=%@&",product.vatString];
    }
    for (LUProduct *product in products) {
        if(product.pgGroup!=nil)
        [str appendFormat:@"ORDER_PGROUP[]=%@&",product.pgGroup];
    }
    
    for (LUProduct *product in products) {
        if(product.pinfo!=nil)
            [str appendFormat:@"ORDER_PINFO[]=%@&",product.pinfo];
    }
    for (LUProduct *product in products) {
        NSString *priceT=PriceTypeString(product.priceType);
      //  [str appendFormat:@"ORDER_PRICE_TYPE[]=%@&",priceT];
    }*/
    
    NSString *ORDER_PGROUP=[dicKey objectForKey:@"ORDER_PGROUP"];
    NSString *ORDER_PRICE_TYPE=[dicKey objectForKey:@"ORDER_PRICE_TYPE"];
    if(ORDER_PGROUP!=nil)
        [str appendFormat:@"%@&",ORDER_PGROUP];
    if(ORDER_PRICE_TYPE!=nil)
        [str appendFormat:@"%@&",ORDER_PRICE_TYPE];
    if(str.length>1)
        [str deleteCharactersInRange:NSMakeRange([str length]-1, 1)];
    return str;
}
-(NSString*)LUhashStringWithProducts:(NSMutableArray*)products{
    NSMutableString *str=[[NSMutableString alloc] init];
  //  [str appendFormat:@"%@",[dicHashKey objectForKey:@"MERCHANT"]];
   // [str appendFormat:@"%@",[dicHashKey objectForKey:@"ORDER_REF"]];
   // [str appendFormat:@"%@",[dicHashKey objectForKey:@"ORDER_DATE"]];
    //products

    for (LUProduct *product in products) {
        if(product.name!=nil)
            [str appendFormat:@"%lu%@", [product.name lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , product.name];
        if(product.code!=nil)
            [str appendFormat:@"%lu%@", [product.code lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , product.code];
        if([product.price stringValue]!=nil)
            [str appendFormat:@"%lu%@", [[product.price stringValue] lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , [product.price stringValue]];
        if(product.qtyString!=nil)
            [str appendFormat:@"%lu%@", [product.qtyString lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , product.qtyString];
        if(product.vatString!=nil)
            [str appendFormat:@"%lu%@", [product.vatString lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , product.vatString];
        NSString *priceT=PriceTypeString(product.priceType);
      //  [str appendFormat:@"%lu%@", [priceT lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , priceT];
    }
   
    /*
    for (LUProduct *product in products) {
        if(product.name!=nil)
            [str appendFormat:@"%lu%@", [product.name lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , product.name];
    }
    for (LUProduct *product in products) {
        if(product.code!=nil)
            [str appendFormat:@"%lu%@", [product.code lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , product.code];
    }
    for (LUProduct *product in products) {
        if([product.price stringValue]!=nil)
            [str appendFormat:@"%lu%@", [[product.price stringValue] lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , [product.price stringValue]];
    }
    for (LUProduct *product in products) {
        if(product.qtyString!=nil)
            [str appendFormat:@"%lu%@", [product.qtyString lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , product.qtyString];
    }
    for (LUProduct *product in products) {
        if(product.vatString!=nil)
            [str appendFormat:@"%lu%@", [product.vatString lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , product.vatString];
    }
    for (LUProduct *product in products) {
        NSString *priceT=PriceTypeString(product.priceType);
        //  [str appendFormat:@"%lu%@", [priceT lengthOfBytesUsingEncoding:NSUTF8StringEncoding] , priceT];
    }
*/
    [str appendFormat:[dicHashKey objectForKey:@"PAY_METHOD"]];


    return str;
}






@end
