//
//  ALU.m
//  alu
//
//  Created by Denis Demjanko on 31.03.14.
//  Copyright (c) 2014 it-dimension.com. All rights reserved.
//

#import "ALU.h"
#import "XMLDictionary.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

#include <sys/types.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

@implementation ALU

@synthesize completionHandler;

#pragma mark - init

@synthesize products;
@synthesize SECRET_KEY;
@synthesize MERCHANT;
@synthesize ORDER_REF;
@synthesize ORDER_DATE;
@synthesize ORDER_HASH;

@synthesize ORDER_SHIPPING;
@synthesize PRICES_CURRENCY;

@synthesize PAY_METHOD;
@synthesize TESTORDER;
@synthesize LANGUAGE;
@synthesize BACK_REF;

@synthesize BIllCLIENTINFO;

@synthesize DELIVERYDATA;

@synthesize CARDINFO;
@synthesize CLIENT_IP;
@synthesize CLIENT_TIME;
@synthesize CC_OWNER_TIME;
@synthesize CC_NUMBER_TIME;

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
        BACK_REF=[NSString stringWithFormat:@""];
        payHelper=[[PAYHelper alloc] init];
    }
    return self;
    
}
-(BOOL)addProduct:(ALUProduct*)product error:(NSError**)error{
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

- (void)sendALURequstWithResult:(ALUResult)result{
    self.completionHandler = result;

    
    [payHelper addObject:BACK_REF key:@"BACK_REF" hash:YES];
    
    [payHelper addObject:BIllCLIENTINFO.BILL_ADDRESS key:@"BILL_ADDRESS" hash:YES];
    [payHelper addObject:BIllCLIENTINFO.BILL_ADDRESS2 key:@"BILL_ADDRESS2" hash:YES];
    [payHelper addObject:BIllCLIENTINFO.BILL_CITY key:@"BILL_CITY" hash:YES];
    [payHelper addObject:CountryCodeString(BIllCLIENTINFO.BILL_COUNTRYCODE) key:@"BILL_COUNTRYCODE" hash:YES];
    [payHelper addObject:BIllCLIENTINFO.BILL_EMAIL key:@"BILL_EMAIL" hash:YES];
    [payHelper addObject:BIllCLIENTINFO.BILL_FAX key:@"BILL_FAX" hash:YES];
    [payHelper addObject:BIllCLIENTINFO.BILL_FNAME key:@"BILL_FNAME" hash:YES];
    [payHelper addObject:BIllCLIENTINFO.BILL_LNAME key:@"BILL_LNAME" hash:YES];
    [payHelper addObject:BIllCLIENTINFO.BILL_PHONE key:@"BILL_PHONE" hash:YES];
    [payHelper addObject:BIllCLIENTINFO.BILL_STATE key:@"BILL_STATE" hash:YES];
    [payHelper addObject:BIllCLIENTINFO.BILL_ZIPCODE key:@"BILL_ZIPCODE" hash:YES];
    
    [payHelper addObject:CARDINFO.CC_CVV key:@"CC_CVV" hash:YES];
    [payHelper addObject:CARDINFO.CC_NUMBER key:@"CC_NUMBER" hash:YES];
    [payHelper addObject:CARDINFO.CC_OWNER key:@"CC_OWNER" hash:YES];
    [payHelper addObject:CARDINFO.CC_TOKEN key:@"CC_TOKEN" hash:YES];
    
    [payHelper addObject:CLIENT_IP key:@"CLIENT_IP" hash:YES];
    [payHelper addObject:CLIENT_TIME key:@"CLIENT_TIME" hash:YES];
    [payHelper addObject:CLIENT_TIME key:@"CLIENT_TIME" hash:YES];
    
    [payHelper addObject:DELIVERYDATA.DELIVERY_ADDRESS key:@"DELIVERY_ADDRESS" hash:YES];
    [payHelper addObject:DELIVERYDATA.DELIVERY_CITY key:@"DELIVERY_CITY" hash:YES];
    [payHelper addObject:DELIVERYDATA.DELIVERY_COUNTRYCODE key:@"DELIVERY_COUNTRYCODE" hash:YES];
    [payHelper addObject:DELIVERYDATA.DELIVERY_FNAME key:@"DELIVERY_FNAME" hash:YES];
    [payHelper addObject:DELIVERYDATA.DELIVERY_LNAME key:@"DELIVERY_LNAME" hash:YES];
    [payHelper addObject:DELIVERYDATA.DELIVERY_PHONE key:@"DELIVERY_PHONE" hash:YES];
    [payHelper addObject:DELIVERYDATA.DELIVERY_STATE key:@"DELIVERY_STATE" hash:YES];
    [payHelper addObject:DELIVERYDATA.DELIVERY_ZIPCODE key:@"DELIVERY_ZIPCODE" hash:YES];
    
    [payHelper addObject:CARDINFO.EXP_MONTH key:@"EXP_MONTH" hash:YES];
    [payHelper addObject:CARDINFO.EXP_YEAR key:@"EXP_YEAR" hash:YES];
    

    [payHelper addObject:LanguageTypeString(LANGUAGE) key:@"LANGUAGE" hash:YES];
    
    [payHelper addObject:MERCHANT key:@"MERCHANT" hash:YES];

    [payHelper addObject:ORDER_DATE key:@"ORDER_DATE" hash:YES];
    
    //products
    for (ALUProduct *product in products) {
        [payHelper addObject:product.code key:@"ORDER_PCODE[]" hash:YES];
    }
    for (ALUProduct *product in products) {
        [payHelper addObject:product.name key:@"ORDER_PNAME[]" hash:YES];
    }
    for (ALUProduct *product in products) {
        [payHelper addObject:[product.price stringValue] key:@"ORDER_PRICE[]" hash:YES];
    }
    for (ALUProduct *product in products) {
        [payHelper addObject:product.qtyString key:@"ORDER_QTY[]" hash:YES];
    }
   
     for (ALUProduct *product in products) {
         NSString *priceT=PriceCurrencyTypeString(product.currency);
         [payHelper addObject:priceT key:@"PRICES_CURRENCY" hash:YES];
    }
   
    [payHelper addObject:ORDER_REF key:@"ORDER_REF" hash:YES];
    
    [payHelper addObject:ALUPAY_METHODTypeString(PAY_METHOD)  key:@"PAY_METHOD" hash:YES];

    
    if(PRICES_CURRENCY!=NONE){
        [payHelper addObject:PriceCurrencyTypeString(PRICES_CURRENCY) key:@"PRICES_CURRENCY" hash:YES];
    }
    
    [payHelper addObject:[ORDER_SHIPPING stringValue] key:@"ORDER_SHIPPING" hash:YES];

   
    
    [payHelper addObject:CC_NUMBER_TIME key:@"CC_NUMBER_TIME" hash:YES];
    [payHelper addObject:CC_OWNER_TIME key:@"CC_OWNER_TIME" hash:YES];

    [payHelper addObject:BoolToSTR( TESTORDER) key:@"TESTORDER" hash:YES];
    
    
    NSString *postString =[payHelper postString];
    NSString *hashString = [payHelper hashString];
    NSString *hmac = [self HMACWithSourceAndSecret:hashString secret:SECRET_KEY];
    
   // NSLog(@"hashs\n%@",hashs);
   // NSLog(@"postString\n%@",postString);
   // NSLog(@"hashString\n%@",hashString);
   // NSLog(@"hmac\n%@",hmac);
    
    postString = [postString stringByAppendingString:[NSString stringWithFormat:@"&ORDER_HASH=%@", hmac]];
    NSData *postData =  [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://secure.payu.ru/order/alu/v3"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                self.completionHandler(nil,error);
            }
            else{
                NSDictionary *result =[NSDictionary dictionaryWithXMLData:data];
                self.completionHandler(result,nil);
            }
        });
    });
}

-(NSString*)HMACWithSourceAndSecret:(NSString*)source  secret:(NSString*)secret{
    CCHmacContext    ctx;
    const char       *key = [secret UTF8String];
    const char       *str = [source UTF8String];
    unsigned char    mac[CC_MD5_DIGEST_LENGTH];
    char             hexmac[2 * CC_MD5_DIGEST_LENGTH + 1];
    char             *p;
    
    CCHmacInit(&ctx, kCCHmacAlgMD5, key, strlen( key ));
    CCHmacUpdate(&ctx, str, strlen(str) );
    CCHmacFinal(&ctx, mac );
    
    p = hexmac;
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++ ) {
        snprintf( p, 3, "%02x", mac[ i ] );
        p += 2;
    }
    
    return [NSString stringWithUTF8String:hexmac];
}

@end
