//
//  IRNExampleRequest.m
//  IOS_SDK_PAYU
//
//  Created by Max on 18.12.16.
//  Copyright © 2016 Max. All rights reserved.
//

#import "IRNExampleRequest.h"
#import "PAYU_SDK.h"
#import "MBProgressHUD.h"

#define SHOW_PORGRESS(x) [MBProgressHUD showHUDAddedTo:x animated:YES]
#define HIDE_PORGRESS(x) [MBProgressHUD hideHUDForView:x animated:YES]

@implementation IRNExampleRequest


+(void)sendIRNRequestInView:(UIView*)view{
    SHOW_PORGRESS(view);
    NSString *payrefno;
    //Instant Refund Notification
    
    //формируем заказ
    NSMutableDictionary *orderDetails = [NSMutableDictionary new];
    
    //данные заказа
    [orderDetails setValue:@"ipolhtst" forKey:@"MERCHANT"];
    [orderDetails setValue:@"3886786" forKey:@"ORDER_REF"];
    if (payrefno) {
        [orderDetails setValue:payrefno forKey:@"ORDER_REF"];
    }
    [orderDetails setValue:@"1234" forKey:@"ORDER_AMOUNT"];
    [orderDetails setValue:@"RUB" forKey:@"ORDER_CURRENCY"];
    [orderDetails setValue:@"2016-12-18 01:26:16" forKey:@"IRN_DATE"];
    
    //создаем объект с секретным ключем
    IRN *irn = [[IRN alloc] initWithSecretKey:@"e5|S|X~0@l10_?R4b8|1"];
    //отправляем запрос
    [irn sendIRNRequest:orderDetails withResult:^(NSData *response, NSError *error) {
        HIDE_PORGRESS(view);
        //результат запроса
        if (response) {
            NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            NSLog(@"%@",result);
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            NSLog(@"%@",error);
        }
    }];
}

@end
