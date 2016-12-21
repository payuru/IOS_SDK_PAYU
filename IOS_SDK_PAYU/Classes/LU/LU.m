//
//  LU.m
//  alu
//
//  Created by Demjanko Denis on 01.04.14.
//  Copyright (c) 2014 it-dimension.com. All rights reserved.
//

#import "LU.h"
#import "XMLDictionary.h"
#import "NSData+Base64.h"
#import "MCMutableArray.h"

#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

#include <sys/types.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>




@implementation LU
@synthesize products;
@synthesize SECRET_KEY;
@synthesize MERCHANT;
@synthesize ORDER_REF;
@synthesize ORDER_DATE;
@synthesize ORDER_HASH;
@synthesize BACK_REF;
@synthesize ORDER_SHIPPING;
@synthesize PRICES_CURRENCY;
@synthesize DISCOUNT;
@synthesize PAY_METHOD;
@synthesize TESTORDER;
@synthesize Debug;
@synthesize LANGUAGE;
@synthesize ORDER_TIMEOUT;
@synthesize TIMEOUT_URL;

@synthesize BILL_FNAME;
@synthesize BILL_LNAME;
@synthesize BILL_EMAIL;
@synthesize BILL_PHONE;
@synthesize BILL_COUNTRYCODE;
@synthesize AUTOMODE;
#pragma mark - init
-(id)initWithSecretKey:(NSString*)secretKey merchant:(NSString*)merchant orderRef:(NSString*)orderRef orderDate:(NSString*)orderDate{
    
    self = [super init];
    if(self){
        SECRET_KEY = [[NSString alloc] initWithString:secretKey];
        products=[[NSMutableArray alloc] init];
        MERCHANT=merchant;
        ORDER_REF=orderRef;
        ORDER_DATE=orderDate;
        TESTORDER=NO;
        Debug=NO;
        AUTOMODE=NO;
        BILL_COUNTRYCODE=CountryCodeNone;
        payHelper=[[PAYHelper alloc] init];
    }
    return self;
    
}
-(BOOL)addProduct:(LUProduct*)product error:(NSError**)error{
    if(product.name==nil||product.name.length==0){
        *error=  [NSError errorWithDomain:@"LUProductError" code:ProductErrorCodesEmptyName userInfo:nil];
        return NO;
    }else{
        if(product.name.length>155){
            *error=  [NSError errorWithDomain:@"LUProductError" code:ProductErrorCodesLongName userInfo:nil];
            return NO;
        }
    }
    if(product.code==nil||product.code.length==0){
        *error=  [NSError errorWithDomain:@"LUProductError" code:ProductErrorCodesEmptyCode userInfo:nil];
        return NO;
    }else{
        if(product.code.length>50){
            *error=  [NSError errorWithDomain:@"LUProductError" code:ProductErrorCodesLongCode userInfo:nil];
            return NO;
        }
    }
    if(product.price==nil){
        *error=  [NSError errorWithDomain:@"LUProductError" code:ProductErrorCodesEmptyPrice userInfo:nil];
        return NO;
    }
        [products addObject:product];
    return YES;
}

- (NSMutableURLRequest *)getLURequstWitherror:(NSError**)error{
    MCMutableArray *parts = [MCMutableArray new];
    MCMutableArray *hashs = [MCMutableArray new];
    [parts addObject:BoolToSTR(AUTOMODE) key:@"AUTOMODE"];
    if(![parts addObject:MERCHANT key:@"MERCHANT"])
        *error= [NSError errorWithDomain:@"LUErrorInputData" code:LUErrorDataEmptyMERCHANT userInfo:nil];
    [hashs addHash:MERCHANT];

    if(![parts addObject:ORDER_REF key:@"ORDER_REF"])
        *error=[NSError errorWithDomain:@"LUErrorInputData" code:LUErrorDataEmptyORDER_REF userInfo:nil];

    [hashs addHash:ORDER_REF];

    if(![parts addObject:ORDER_DATE key:@"ORDER_DATE"])
        *error=[NSError errorWithDomain:@"LUErrorInputData" code:LUErrorDataEmptyORDER_DATE userInfo:nil];
    [hashs addHash:ORDER_DATE];

    
    //Информация о платильщике
    
    [parts addObject:BILL_FNAME key:@"BILL_FNAME"];
    [parts addObject:BILL_LNAME key:@"BILL_LNAME"];
    [parts addObject:BILL_EMAIL key:@"BILL_EMAIL"];
    [parts addObject:BILL_PHONE key:@"BILL_PHONE"];
    [parts addObject:CountryCodeString(BILL_COUNTRYCODE) key:@"BILL_COUNTRYCODE"];
    [parts addObject:LanguageTypeString(LANGUAGE) key:@"LANGUAGE"];
    
    
    
    //products
    if([products count]==0)
        *error=[NSError errorWithDomain:@"LUErrorInputData" code:LUErrorDataEmptyPRODUCTS userInfo:nil];

    if (*error!=nil)
        return nil;
    for (LUProduct *product in products) {
        [parts addObject:product.name key:@"ORDER_PNAME[]"];
        [hashs addHash:product.name];
    }
    
    for (LUProduct *product in products) {
        [parts addObject:product.code key:@"ORDER_PCODE[]"];
        [hashs addHash:product.code];
    }
    
    for (LUProduct *product in products) {
        [parts addObject:[product.price stringValue] key:@"ORDER_PRICE[]"];
        [hashs addHash:[product.price stringValue]];
    }
    
    
    
    for (LUProduct *product in products) {
        [parts addObject:product.qtyString key:@"ORDER_QTY[]"];
        [hashs addHash:product.qtyString];
    }
    
    for (LUProduct *product in products) {
        [parts addObject:product.vatString key:@"ORDER_VAT[]"];
        [hashs addHash:product.vatString];
    }
    
   
    for (LUProduct *product in products) {
        [parts addObject:product.pgGroup key:@"ORDER_PGROUP[]"];
        [hashs addHash:product.pgGroup];
        
    }
    
    for (LUProduct *product in products) {
        [parts addObject:product.pinfo key:@"ORDER_PINFO[]"];
        [hashs addHash:product.pinfo];
    }
    
    
    [parts addObject:[ORDER_SHIPPING stringValue] key:@"ORDER_SHIPPING"];
    [hashs addHash:[ORDER_SHIPPING stringValue]];
    
    if(PRICES_CURRENCY!=NONE){
        [parts addObject:PriceCurrencyTypeString(PRICES_CURRENCY) key:@"PRICES_CURRENCY"];
        [hashs addHash:PriceCurrencyTypeString(PRICES_CURRENCY)];
    }
    
    [parts addObject:[DISCOUNT stringValue] key:@"DISCOUNT"];
    [hashs addHash:[DISCOUNT stringValue]];
    
    [parts addObject:LUPAY_METHODTypeString(PAY_METHOD)  key:@"PAY_METHOD"];
    [hashs addHash:LUPAY_METHODTypeString(PAY_METHOD)];
    
    [parts addObject:[ORDER_TIMEOUT stringValue]  key:@"ORDER_TIMEOUT"];
    //[hashs addHash:[ORDER_TIMEOUT stringValue]];
    
    [parts addObject:TIMEOUT_URL  key:@"TIMEOUT_URL"];
   // [hashs addHash:TIMEOUT_URL];
    
    [parts addObject:BoolToSTR(Debug) key:@"DEBUG"];
    [parts addObject:BoolToSTR(TESTORDER) key:@"TESTORDER"];
    
    
    NSString *postString =[parts componentsJoinedByString:@"&"]; //[parts postString];
    NSString *hashString = [hashs componentsJoinedByString:@""];
    hashString =[NSString stringWithFormat:@"%@%@",hashString,(TESTORDER?@"4TRUE":@"")];
    NSString *hmac = [self HMACWithSourceAndSecret:hashString secret:SECRET_KEY];
    
    postString = [postString stringByAppendingString:[NSString stringWithFormat:@"&ORDER_HASH=%@", hmac]];
    //NSLog(@"%@",postString);
    NSData *postData =  [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL* URL = [NSURL URLWithString:@"https://secure.payu.ru/order/lu.php"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    return request;
}

- (NSString *)HMACWithSourceAndSecret:(NSString *)source secret:(NSString *)secret
{
  CCHmacContext ctx;
  const char *key = [secret UTF8String];
  const char *str = [source UTF8String];
  unsigned char mac[CC_MD5_DIGEST_LENGTH];
  char hexmac[2 * CC_MD5_DIGEST_LENGTH + 1];
  char *p;

  CCHmacInit(&ctx, kCCHmacAlgMD5, key, strlen(key));
  CCHmacUpdate(&ctx, str, strlen(str));
  CCHmacFinal(&ctx, mac);

  p = hexmac;
  for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    snprintf(p, 3, "%02x", mac[i]);
    p += 2;
  }

  return [NSString stringWithUTF8String:hexmac];
}

@end
