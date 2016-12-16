//
//  LU.m
//  alu
//
//  Created by Demjanko Denis on 01.04.14.
//  Copyright (c) 2014 it-dimension.com. All rights reserved.
//

#import "LU.h"
#import "NSData+Base64.h"
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
@synthesize DESTINATION_CITY;
@synthesize DESTINATION_STATE;
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

    
    
    [payHelper addObject:MERCHANT key:@"MERCHANT" hash:YES];
    [payHelper addObject:ORDER_REF key:@"ORDER_REF" hash:YES];
    [payHelper addObject:ORDER_DATE key:@"ORDER_DATE" hash:YES];

    [payHelper addObject:BILL_FNAME key:@"BILL_FNAME" hash:NO];
    [payHelper addObject:BILL_LNAME key:@"BILL_LNAME" hash:NO];
    [payHelper addObject:BILL_EMAIL key:@"BILL_EMAIL" hash:NO];
    [payHelper addObject:BILL_PHONE key:@"BILL_PHONE" hash:NO];
    [payHelper addObject:BACK_REF key:@"BACK_REF" hash:NO];
    [payHelper addObject:BILL_COUNTRYCODE key:@"BILL_COUNTRYCODE" hash:NO];
    [payHelper addObject:LanguageTypeString(LANGUAGE) key:@"LANGUAGE" hash:NO];
    
    [payHelper addObject:DESTINATION_CITY key:@"DESTINATION_CITY" hash:NO];
    [payHelper addObject:DESTINATION_STATE key:@"DESTINATION_STATE" hash:NO];
  

    
    [payHelper addObject:[ORDER_SHIPPING stringValue] key:@"ORDER_SHIPPING" hash:NO];
    
    if(PRICES_CURRENCY!=NONE){
        [payHelper addObject:PriceCurrencyTypeString(PRICES_CURRENCY) key:@"PRICES_CURRENCY" hash:YES];
    }
    
    [payHelper addObject:[DISCOUNT stringValue] key:@"DISCOUNT" hash:NO];
   
    [payHelper addObject:LUPAY_METHODTypeString(PAY_METHOD)  key:@"PAY_METHOD" hash:YES];
    
    [payHelper addObject:[ORDER_TIMEOUT stringValue]  key:@"ORDER_TIMEOUT" hash:NO];
    
    [payHelper addObject:TIMEOUT_URL  key:@"TIMEOUT_URL" hash:NO];
    
    [payHelper addObject:[NSString stringWithFormat:@"%d",AUTOMODE] key:@"AUTOMODE" hash:NO];
    [payHelper addObject:[NSString stringWithFormat:@"%d",DEBUG] key:@"DEBUG" hash:NO];
    [payHelper addObject:BoolToSTR(TESTORDER) key:@"TESTORDER" hash:NO];
   

    NSString *postString =[payHelper LUpostStringWithProducts:products];
    NSString *hashString = [payHelper LUhashStringWithProducts:products];
    
  //  hashString =[NSString stringWithFormat:@"%@%@",hashString,(TESTORDER?@"4TRUE":@"")];
  NSString *hmac = [self HMACWithSourceAndSecret:hashString secret:SECRET_KEY];
    
   // NSLog(@"hashs\n%@",hashs);
    NSLog(@"postString\n%@",postString);
    NSLog(@"hashString\n%@",hashString);
    NSLog(@"hmac\n%@",hmac);

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
