//
//  orderLUViewController.m
//  PAYU_Example
//
//  Created by Max on 13.11.16.
//  Copyright © 2016 IPOL OOO. All rights reserved.
//

#import "LUExampleViewController.h"
#import "PAYU_SDK.h"

@interface LUExampleViewController ()

@end

@implementation LUExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SHOW_PORGRESS(self.view);
    [self payWithLU];
}

-(void)payWithLU{
    LUProduct *product=[[LUProduct alloc] initLUProductWithName:@"test" code:@"123" price:[NSNumber numberWithInt:50] qty:10 vat:13 ];
    LUProduct *product2=[[LUProduct alloc] initLUProductWithName:@"test2" code:@"123" price:[NSNumber numberWithInt:100] qty:10 vat:10 ];
    LU *lu=[[LU alloc] initWithSecretKey:@"e5|S|X~0@l10_?R4b8|1" merchant:@"ipolhtst" orderRef:@"3886786" orderDate:@"2016-11-21 10:51:58"];
    
    [lu addProduct:product error:nil];
    [lu addProduct:product2 error:nil];
    
    lu.BILL_FNAME=@"Max";
    lu.BILL_LNAME=@"Mel";
    lu.BILL_EMAIL=@"ALoon12@gmail.com";
    lu.BILL_PHONE=@"+79261122334";
    lu.BILL_COUNTRYCODE=CountryCodeRU;
    lu.LANGUAGE=LanguageTypeRU;
    lu.DISCOUNT=[NSNumber numberWithFloat:200.1];
     lu.TESTORDER=NO;
    lu.Debug=YES;
    lu.PAY_METHOD=LUPayMethodTypeCCVISAMC;
    
    
     lu.ORDER_SHIPPING=[NSNumber numberWithInt:1200];
    lu.PRICES_CURRENCY=USD;
    
    NSError *error;
    [self.webView loadRequest: [lu getLURequstWitherror:&error]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@",request.URL.absoluteString);
    
    NSString *string = request.URL.absoluteString;
    //отлавливаем переход на нашу ссылку
    if ([string rangeOfString:@"?result=0"].location != NSNotFound) {
        NSArray *array = [request.URL.absoluteString componentsSeparatedByString:@"&"];
        
        //сохраняем номер заказа, он нам понадобится для "отмены транзакции" и для "подтверждения транзакци"
        self.payrefno = [[array objectAtIndex:3] stringByReplacingOccurrencesOfString:@"payrefno=" withString:@""];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Оплата прошла успешно payrefno=%@",self.payrefno] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    HIDE_PORGRESS(self.view);

}

@end
