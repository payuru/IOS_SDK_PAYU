//
//  ALUExampleRequest.m
//  IOS_SDK_PAYU
//
//  Created by Max on 18.12.16.
//  Copyright © 2016 Max. All rights reserved.
//

#import "ALUExampleRequest.h"
#import "PAYU_SDK.h"
#import "MBProgressHUD.h"

#define SHOW_PORGRESS(x) [MBProgressHUD showHUDAddedTo:x animated:YES]
#define HIDE_PORGRESS(x) [MBProgressHUD hideHUDForView:x animated:YES]

@implementation ALUExampleRequest


+(void)payWithALUInView:(UIView*)view{
    SHOW_PORGRESS(view);

    
    NSString *dateNow=[[NSDate date] description];// Время должно быть UTC (единое мировое время). Время не должно отличаться от UTC больше чем +/-10 минут
    NSString *dateNowString = [dateNow substringToIndex:[dateNow length]-6];
    
    ALU *alu = [[ALU alloc] initWithSecretKey:@"e5|S|X~0@l10_?R4b8|1" merchant:@"ipolhtst" orderRef:@"3886786" orderDate:dateNowString];     //инициализация сервиса ALU и задаем секретный ключ MERCHANT,orderRef и orderDate

    // создаем продукты обязательне поля
    ALUProduct *product=[[ALUProduct alloc] initALUProductWithName:@"Phone" code:@"12" price:[NSNumber numberWithInt:1000] qty:1 currency:NONE];
    ALUProduct *product2=[[ALUProduct alloc] initALUProductWithName:@"Phone2" code:@"13" price:[NSNumber numberWithInt:1] qty:1 currency:NONE];
    
    //добавляем продукты в метод отправки
    NSError *productError;
    [alu addProduct:product error:&productError];
    [alu addProduct:product2 error:&productError];
    
    if(productError!=nil){
        NSLog(@"%@",productError);// вывод ошибок при добавления продуктов
    }
    
    alu.LANGUAGE=LanguageTypeRU; //Выбор языка
    alu.TESTORDER=NO; // Вкл/Выкл тестового заказа
    alu.PAY_METHOD=ALUPayMethodTypeCCVISAMC; //метод оплаты

    alu.CARDINFO=[[ALUCardInfo alloc] initWithCC_NUMBER:@"1122334455667777" EXP_MONTH:@"01" EXP_YEAR:@"2017" CC_CVV:@"071" CC_OWNER:@"Maxim"]; //добавляем реквизиты платежной карты
    
    //данные доставки
    alu.DELIVERYDATA.DELIVERY_FNAME=@"John";
    alu.DELIVERYDATA.DELIVERY_LNAME=@"Smith";
    alu.DELIVERYDATA.DELIVERY_PHONE=@"7-926-231-97-22";
    alu.DELIVERYDATA.DELIVERY_ADDRESS=@"3256 Epiphenomenal Avenue";
    alu.DELIVERYDATA.DELIVERY_ZIPCODE=@"55416";
    alu.DELIVERYDATA.DELIVERY_CITY=@"Moscow";
    alu.DELIVERYDATA.DELIVERY_STATE=@"Moscow";
    alu.DELIVERYDATA.DELIVERY_COUNTRYCODE=@"RU";
    //alu.CLIENT_IP=@"122.22.12.23"; //ip клиента
    
    alu.BIllCLIENTINFO=[[ALUBillClientInfo alloc] initWithFNAME:@"Mel" LNAME:@"Maxim" EMAIL:@"lolo@gmail.com" PHONE:@"7-926-177-77-22" COUNTRYCODE:CountryCodeRU];// данные покупателя
    alu.ORDER_SHIPPING=[NSNumber numberWithInt:1007];     //стоимость доставки
    
    alu.PRICES_CURRENCY=RUB; //Выбор валюты 
    alu.TESTORDER=NO; //Тестовый режим
    
    //отправляем созданный заказ
    [alu sendALURequstWithResult:^(NSDictionary *response, NSError *error) {
        //результат запроса
        if (response) {
            NSLog(@"%@",response);
            NSString *strHeader=[NSString stringWithFormat:@"STATUS:%@",[response objectForKey:@"STATUS"]];
            NSString *message=[NSString stringWithFormat:@"RETURN_MESSAGE:%@",[response objectForKey:@"RETURN_MESSAGE"]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strHeader message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            NSLog(@"%@",response);
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            NSLog(@"%@",error);
        }
        HIDE_PORGRESS(view);

    }];
}
@end
