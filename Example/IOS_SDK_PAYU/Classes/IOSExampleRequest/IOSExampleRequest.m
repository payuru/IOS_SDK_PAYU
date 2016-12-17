//
//  IOSExampleRequest.m
//  IOS_SDK_PAYU
//
//  Created by Max on 18.12.16.
//  Copyright © 2016 Max. All rights reserved.
//


#import "IOSExampleRequest.h"
#import "PAYU_SDK.h"
#import "MBProgressHUD.h"

#define SHOW_PORGRESS(x) [MBProgressHUD showHUDAddedTo:x animated:YES]
#define HIDE_PORGRESS(x) [MBProgressHUD hideHUDForView:x animated:YES]

@implementation IOSExampleRequest

+(void)sendIOSRequestInView:(UIView*)view{
    SHOW_PORGRESS(view);
    //Instant Delivery Notification
    //создаем объект с секретным ключем и данными
    IOS *ios = [[IOS alloc] initWithSecretKey:@"e5|S|X~0@l10_?R4b8|1" Merchant:@"ipolhtst" Refnoext:@"3886786"];
    //отправляем запрос
    [ios sendIOSRequestWithResult:^(NSDictionary *response, NSError *error) {
        HIDE_PORGRESS(view);
        //результат запроса
        if (response) {
            NSLog(@"%@",response);
            NSString *respStr=[NSString stringWithFormat:@"ORDER_STATUS:%@,\n ORDER_DATE:%@\n REFNO:%@\n REFNOEXT:%@",[response objectForKey:@"ORDER_STATUS"],[response objectForKey:@"ORDER_DATE"],[response objectForKey:@"REFNO"],[response objectForKey:@"REFNOEXT"]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:respStr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            NSLog(@"%@",error);
        }
    }];
}

@end
