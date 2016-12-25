# IOS_SDK_PAYU

[![CI Status](http://img.shields.io/travis/Max/IOS_SDK_PAYU.svg?style=flat)](https://travis-ci.org/Max/IOS_SDK_PAYU)
[![Version](https://img.shields.io/cocoapods/v/IOS_SDK_PAYU.svg?style=flat)](http://cocoapods.org/pods/IOS_SDK_PAYU)
[![License](https://img.shields.io/cocoapods/l/IOS_SDK_PAYU.svg?style=flat)](http://cocoapods.org/pods/IOS_SDK_PAYU)
[![Platform](https://img.shields.io/cocoapods/p/IOS_SDK_PAYU.svg?style=flat)](http://cocoapods.org/pods/IOS_SDK_PAYU)

## Тестовое приложение

Для запуска тестового приложения нужно:

-Клонировать репозиторий

-Запустить терминал

-Перейти в скаченную дирректорию (в папку Example)

-Выполнить команду `pod install`

## Скриншоты Тестового приложения
<a href="http://imgur.com/UDHGr6v"><img src="http://i.imgur.com/UDHGr6v.png" title="source: imgur.com" /></a>
<a href="http://imgur.com/uiYZ8a1"><img src="http://i.imgur.com/uiYZ8a1.png" title="source: imgur.com" /></a>
<a href="http://imgur.com/vxXdOAK"><img src="http://i.imgur.com/vxXdOAK.png" title="source: imgur.com" /></a>

## Добавление библиотеки в проект:

Библиотека IOS_SDK_PAYU доступна через систему управления зависимостями [CocoaPods](http://cocoapods.org).

-Добавьте строчку в Podfile вашего приложения
```ruby
pod "IOS_SDK_PAYU"
```

-Выполните команду в терминале `pod update`

-Подключаем библиотеку  `#import "PAYU_SDK.h"`


# Описание API:

## LU - класс для работы с протоколом Live Update

#### Инициализируем платежный класс
```objective-c
LU *lu=[[LU alloc] initWithSecretKey:@"e5|S|X~0@l10_?R4b8|1" merchant:@"ipolhtst" orderRef:@"3886786" orderDate:@"2016-11-21 10:51:58"];
// необязательные параметры
lu.BILL_FNAME=@"Max";
lu.BILL_LNAME=@"Mel";
lu.BILL_EMAIL=@"ALoon12@gmail.com";
lu.BILL_PHONE=@"+79261122334";
lu.BILL_COUNTRYCODE=CountryCodeRU;
lu.LANGUAGE=LanguageTypeRU;
lu.DISCOUNT=[NSNumber numberWithFloat:200.1];
lu.PAY_METHOD=LUPayMethodTypeCCVISAMC;
lu.ORDER_SHIPPING=[NSNumber numberWithInt:1200];
lu.PRICES_CURRENCY=USD;
lu.ORDER_TIMEOUT=[NSNumber numberWithInt:200];
lu.TIMEOUT_URL=@"http://yandex.ru";
lu.TESTORDER=NO;
lu.Debug=YES;
```
| Переменная  | Тип |  Обязательно заполнять | Описание |
| -------------| ------------- | ------------- | ------------- |
| SECRET_KEY | NSString | да  |  Секретный ключ |
| MERCHANT | NSString | да  |  Идентификатор Интернет-магазина. Значение доступно через интерфейс Личного кабинета (Управление учетными записями > Настройки учетной записи) |
| ORDER_REF | NSString | да  |  Идентификационный номер заказа в системе ТСП (для упрощения процедуры идентификации заказа) |
| ORDER_DATE | NSString | да  |  Дата начала обработки заказа в системе в формате ГГГГ-ММ-ДД ЧЧ:ММ:СС (например: «2012-05-01 21:15:45») |
| BILL_FNAME | NSString | нет  | Имя плательщика |
| BILL_LNAME | NSString | нет  | Фамилия плательщика  |
| BILL_EMAIL | NSString | нет  |  Адрес электронной почты плательщика |
| BILL_PHONE | NSString | нет  | Номер телефона плательщика  |
| BILL_COUNTRYCODE | CountryCode | нет  | Код страны плательщика (Например для России ` BILL_COUNTRYCODE=CountryCodeRU;`)  |
| LANGUAGE | LanguageType | нет  |  Язык интерфейса<br/>Возможные значения: <br/> <br/><li>LanguageTypeEN - английский</li><br/><li>LanguageTypeRO - румынский</li> <br/><li>LanguageTypeHU - венгерский</li><br/><li>LanguageTypeRU -  русский</li>  <br/><li>LanguageTypeDE  - немецкий</li><br/><li>LanguageTypeFR - французский</li><br/><li>LanguageTypeIT - итальянский</li> <br/> <li>LanguageTypeES - испанский </li><br/>  |
| DISCOUNT | NSNumber | нет  | Значение скидки  |
| PAY_METHOD | LUPayMethodType | нет  | Метод оплаты <br/> Возможные значения:  <br/><li>LUPayMethodTypeCCVISAMC (Выставляется по умолчанию)</li><br/><li>LUPayMethodTypeWEBMONEY</li><br/><li>LUPayMethodTypeQIWI</li><br/><li>LUPayMethodTypeYANDEX</li><br/><li>LUPayMethodTypeEUROSET_SVYAZNOI</li> <br/><li>LUPayMethodTypeALFACLICK</li>  |
| ORDER_SHIPPING | NSNumber | нет  | Стоимость доставки заказа  |
| PRICES_CURRENCY | PRICES_CURRENCYType | нет  | Валюта, в которой указаны цены, налоги, стоимость доставки и скидки <br/>Возможные значения:  <br/><br/><li> RUB</li> <br/><li>EUR</li> <br/><li>USD</li>   |
| ORDER_TIMEOUT | NSNumber | нет  | Промежуток времени, в течение которого заказ может быть размещен, в секундах  |
| TIMEOUT_URL | NSString | нет  | URL, на который будет перенаправлен клиент по истечении ORDER_TIMEOUT  |
| Debug | BOOL | нет  | Режима отладки <br/>Возможные значения:  <br/><br/><li> TRUE <br/><li>FALSE  |
| TESTORDER | BOOL | нет  | Тестовая операция <br/>Возможные значения:  <br/><br/><li> TRUE <br/><li>FALSE  |



#### Создаем продукт (товар)
```objective-c
LUProduct *product=[[LUProduct alloc] initLUProductWithName:@"test" code:@"123" price:[NSNumber numberWithInt:50] qty:10 vat:13 ];
// необязательные параметры
product.pgGroup=@"2313123";
product.pinfo=@"Сбербанк 132132321";
```
Описание LUProduct


| Переменная  | Тип |  Обязательно заполнять | Описание |
| ------------- | ------------- | ------------- |------------- |
| name | NSString | да  |  Наименование продукта ( не более 155 знаков на один продукт) |
| code | NSString | да |  Код продукта  (1-50 символов) |
| price | NSNumber | да | Стоимость продукта  |
| qty | NSUInteger | да |  Количество единиц товара  |
| vat | NSUInteger | да |  НДС для  товара в рамках заказа |
| pgGroup | NSString  | нет | Идентификаторами групп товаров  |
| pinfo | NSString | нет | Дополнительной информацией о товаре (Например: номер лицевого счета) |


#### Добавляем созданный продукт (товар)
```objective-c
NSError *error;
[lu addProduct:product error:&error];
```
Коды ошибок LUErrorInputData

| Код ошибки | Описание |
| ------------- |------------- |
| ProductErrorCodesEmptyName | Отсутствует MERCHANT |
| ProductErrorCodesEmptyCode | Отсутствует ORDER_REF |
| ProductErrorCodesEmptyPrice | Отсутствуют  PRODUCTS(продукты/товары)|
| ProductErrorCodesLongName | Название продукта/товара более 155 символов |
| ProductErrorCodesLongCode | Код продукта/товара более 50 символов |
| ProductErrorCodesWrongPrice  | Ошибка цены продукта/товара |
| ProductErrorCodesWrongQTY | Ошибка количества продукта/товара |
| ProductErrorCodesWrongVAT | Ошибка НДС продукта/товара |
| ProductErrorCodesWrongShipping | Ошибка стоимости продукта/товара   |


#### Создаем форму пользователя
```objective-c
NSError *error;
[self.webView loadRequest: [lu getLURequstWitherror:&error]];
```
Коды ошибок LUErrorInputData при добавлении продуктов/ товаров

| Код ошибки | Описание |
| ------------- |------------- |
| LUErrorDataEmptyMERCHANT | Отсутствует MERCHANT |
| LUErrorDataEmptyORDER_REF | Отсутствует ORDER_REF |
| LUErrorDataEmptyPRODUCTS | Отсутствуют  PRODUCTS(продукты/товары)|
| LUErrorDataEmptyORDER_DATE | Отсутствует дата ORDER_DATE |





#### Cохраняем номер заказа, для "отмены транзакции" или "подтверждения транзакции"
```objective-c
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
```
<br/>
<br/>
<br/>
## ALU - класс для работы с протоколом ALUv3 (Automatic Live Update)

#### Инициализируем платежный класс ALU

```objective-c
ALU *alu = [[ALU alloc] initWithSecretKey:@"e5|S|X~0@l10_?R4b8|1" merchant:@"ipolhtst" orderRef:@"3886786" orderDate:@"2016-11-21 10:51:58"]; 

alu.ORDER_SHIPPING=[NSNumber numberWithInt:1007];     //стоимость доставки    
alu.PRICES_CURRENCY=RUB; 
alu.LANGUAGE=LanguageTypeRU;
alu.PAY_METHOD=ALUPayMethodTypeCCVISAMC;
alu.CLIENT_IP=@"192.168.0.1";
alu.TESTORDER=NO;


```
###Поля заказа

| Переменная  | Тип |  Обязательно заполнять | Описание |
| -------------| ------------- | ------------- | ------------- |
| SECRET_KEY | NSString | да  |  Секретный ключ |
| MERCHANT | NSString | да  |  Идентификатор Интернет-магазина. Значение доступно через интерфейс Личного кабинета (Управление учетными записями > Настройки учетной записи) |
| ORDER_REF | NSString | да  |  Идентификационный номер заказа в системе ТСП (для упрощения процедуры идентификации заказа) |
| ORDER_DATE | NSString | да  |  Дата начала обработки заказа в системе в формате ГГГГ-ММ-ДД ЧЧ:ММ:СС (например: «2012-05-01 21:15:45») <br/> Важно: Время должно быть UTC (единое мировое время, не московское). Время в запросе не должно отличаться от UTC больше чем +/-10 минут |
| BACK_REF | NSString | да  | Обратный URL ТСП |
| BIllCLIENTINFO | ALUBillClientInfo | да  | Реквизиты плательщика  |
| CARDINFO | ALUCardInfo | да  |  Реквизиты карты  |
| ORDER_SHIPPING | NSNumber | нет  | Стоимость доставки заказа  |
| DELIVERYDATA  | ALUDELIVERYData  | нет  |  Параметры доставки  |
| PAY_METHOD | ALUPayMethodType | нет  | Метод оплаты <br/> Возможные значения:  <br/><li>ALUPayMethodTypeCCVISAMC (Выставляется по умолчанию)</li><br/>  |
| PRICES_CURRENCY | PRICES_CURRENCYType | нет  | Валюта, в которой указаны цены, налоги, стоимость доставки и скидки <br/>Возможные значения:  <br/><br/><li> RUB</li> <br/><li>EUR</li> <br/><li>USD</li>   |
| LANGUAGE | LanguageType | нет  |  Язык интерфейса<br/>Возможные значения: <br/> <br/><li>LanguageTypeEN - английский</li><br/><li>LanguageTypeRO - румынский</li> <br/><li>LanguageTypeHU - венгерский</li><br/><li>LanguageTypeRU -  русский</li>  <br/><li>LanguageTypeDE  - немецкий</li><br/><li>LanguageTypeFR - французский</li><br/><li>LanguageTypeIT - итальянский</li> <br/> <li>LanguageTypeES - испанский </li><br/>  |
| CLIENT_IP | NSString | нет  |  ip пользователя  |
| CLIENT_TIME | NSString | нет  |  Время, определенное на основе информации браузера покупателя в формате ГГГГ-ММ-ДД чч:мм:сс  |
| CC_NUMBER_TIME | NSString | нет  |  Время потраченное пользователем при вводе номера карты  |
| CC_OWNER_TIME | NSString | нет  |  Время потраченное пользователем при вводе владельца карты |
| TESTORDER | BOOL | нет  | Тестовая операция <br/>Возможные значения:  <br/><br/><li> TRUE </li><br/><li>FALSE</li>  |

###Добавляем информация о продукте
```objective-c
NSError *productError;
ALUProduct *product=[[ALUProduct alloc] initALUProductWithName:@"Phone" code:@"12" price:[NSNumber numberWithInt:1000] qty:1];
NSError *productError;
product.pinfo=@"Носки хлопковые";
product.ver=@"1.0.0";
[alu addProduct:product error:&productError];
```
Описание ALUProduct


| Переменная  | Тип |  Обязательно заполнять | Описание |
| -------------| ------------- | ------------- |------------- |
| name | NSString | да  |  Наименование продукта ( не более 155 знаков на один продукт) |
| code | NSString |да |  Код продукта  (1-50 символов) |
| price | NSNumber | да | Стоимость продукта  |
| qty | NSUInteger | да |  Количество единиц товара  |
| pinfo | NSString | нет|  Дополнительная информация о продукте/товаре  |
| ver | NSString | нет|  Информация о версии заказанного продукта/товара  |

Коды ошибок ALUErrorInputData при добавлении продуктов/ товаров

| Код ошибки | Описание |
| ------------- |------------- |
| ProductErrorCodesEmptyName | Отсутствует MERCHANT |
| ProductErrorCodesEmptyCode | Отсутствует ORDER_REF |
| ProductErrorCodesEmptyPrice | Отсутствуют  PRODUCTS(продукты/товары)|
| ProductErrorCodesLongName | Название продукта/товара более 155 символов |
| ProductErrorCodesLongCode | Код продукта/товара более 50 символов |
| ProductErrorCodesWrongPrice  | Ошибка цены продукта/товара |
| ProductErrorCodesWrongQTY | Ошибка количества продукта/товара |
| ProductErrorCodesWrongVAT | Ошибка НДС продукта/товара |
| ProductErrorCodesWrongShipping | Ошибка стоимости продукта/товара   |


###Добавляем реквизиты покупателя

```objective-c
alu.BIllCLIENTINFO=[[ALUBillClientInfo alloc] initWithFNAME:@"Mel" LNAME:@"Maxim" EMAIL:@"lolo@gmail.com" PHONE:@"7-926-177-77-22" COUNTRYCODE:CountryCodeRU];
```

Описание ALUBillClientInfo

| Переменная  | Тип |  Обязательно заполнять | Описание |
| -------------| ------------- | ------------- |------------- |
| BILL_LNAME | NSString | да  | Фамилия покупателя |
| BILL_FNAME | NSString | да  | Имя покупателя |
| BILL_EMAIL | NSString | да  | Адрес электронной почты покупателя |
| BILL_PHONE | NSString | да  | Номер телефона покупателя |
| BILL_COUNTRYCODE	 | CountryCode | да  | Код страны (например CountryCodeRU)|
| BILL_FAX | NSString | нет  | Номер факса покупателя |
| BILL_ADDRESS | NSString | нет  | Адрес покупателя |
| BILL_ADDRESS2 | NSString | нет  | Адрес покупателя (вторая строчка) |
| BILL_ZIPCODE | NSString | нет  | Почтовый индекс |
| BILL_CITY | NSString | нет  | Город |
| BILL_STATE | NSString | нет  | Область/район |


###Добавляем реквизиты карты

```objective-c
alu.CARDINFO=[[ALUCardInfo alloc] initWithCC_NUMBER:@"1122334455667777" EXP_MONTH:@"01" EXP_YEAR:@"2017" CC_CVV:@"071" CC_OWNER:@"Maxim"];
```
Описание ALUCardInfo

| Переменная  | Тип |  Обязательно заполнять | Описание |
| -------------| ------------- | ------------- |------------- |
| CC_NUMBER | NSString | да  | Номер карты, которая будет использоваться при авторизации заказа |
| EXP_MONTH | NSString | да  | Месяц истечения срока действия карты |
| EXP_YEAR | NSString | да  | Год истечения срока действия карты |
| CC_CVV | NSString | да  | CCV/CVV2 код карты. Для некоторых видов карт эта информация не указывается, в противном случае это должно быть числовое значение |
| CC_OWNER | NSString | да  | ФИО владельца карты, в соответствии с тем, что указано на самой карте |
| CC_TOKEN | NSString | да  | Токен, полученный при использовании модального чекаута или с использованием протокола Токен v2 |

###Добавляем параметры доставки

```objective-c
alu.DELIVERYDATA.DELIVERY_FNAME=@"John";
alu.DELIVERYDATA.DELIVERY_LNAME=@"Smith";
alu.DELIVERYDATA.DELIVERY_PHONE=@"7-926-231-97-22";
alu.DELIVERYDATA.DELIVERY_ADDRESS=@"3256 Epiphenomenal Avenue";
alu.DELIVERYDATA.DELIVERY_ZIPCODE=@"55416";
alu.DELIVERYDATA.DELIVERY_CITY=@"Moscow";
alu.DELIVERYDATA.DELIVERY_STATE=@"Moscow";
alu.DELIVERYDATA.DELIVERY_COUNTRYCODE=CountryCodeRU;
```
Описание ALUDELIVERYData

| Переменная  | Тип |  Обязательно заполнять | Описание |
| -------------| ------------- | ------------- |------------- |
| DELIVERY_FNAME | NSString | нет  | Фамилия лица, которому будет доставлен заказ |
| DELIVERY_LNAME | NSString | нет  | Имя лица, которому будет доставлен заказ |
| DELIVERY_EMAIL | NSString | нет  | Адрес электронной почты  лица или компании, которым будет доставлен заказ |
| DELIVERY_PHONE | NSString | нет  | Номер телефона лица или компании, которым будет доставлен заказ |
| DELIVERY_ADDRESS | NSString | нет  | Адрес доставки заказа |
| DELIVERY_ADDRESS2 | NSString | нет  | Дополнительная информация по адресу доставки заказа |
| DELIVERY_ZIPCODE | NSString | нет  | Почтовый индекс в рамках адреса доставки заказа |
| DELIVERY_CITY | NSString | нет  | Город доставки заказа |
| DELIVERY_STATE | NSString | нет  | Регион/область доставки заказа |
| DELIVERY_COUNTRYCODE | CountryCode | нет  | Код страны доставки |
| DELIVERY_COMPANY | NSString | нет  | Название компании, которой будет доставлен заказ |


### Отправляем созданный заказ и получаем статус заказа от сервера

```objective-c
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
```

Описание ответа от сервера в словаре response


| Ключ  |  Обязательное поле | Описание |
| ------------- | ------------- |------------- |
| REFNO |   | Уникальный идентификатор заказа, присваиваемый PayU |
| ALIAS |   | Уникальное строчное обозначение операции, которое может использоваться ТСП на сервере базы данных |
| STATUS |   | Возможные статусы платежа:<br/><br/><li>SUCCESS - платеж бы успешно авторизован. В данном случае также выдается значение REFNO</li><br/><li>AUTHORIZATION_FAILED - платеж НЕ был авторизован в силу различных причин (мошенничество, недостаточное количество средств и т.д.). В данном случае также выдается значение REFNO, но при этом платеж  рассматривается</li><br/><li>INPUT_ERROR - запрос платежа является ошибочным или не содержит обязательных параметров</li> |
| RETURN_CODE |   | Код ошибки  |
| RETURN_MESSAGE |   | Подробное описание кода ответа  |
| DATE |   | Дата ответа в формате универсального координированного времени  |
| URL_3DS |   | Если кредитная карта является частью системы 3D Secure данный параметр содержит URL, на который ТСП перенаправляется браузер покупателя  |
| ORDER_REF |   | Внешний идентификационный номер заказа в системе ТСП  |
| AUTH_CODE |   | Авторизационный банковский код  |
| HASH |   | Подпись, применяемая для всех элементов запроса, в рамках которой используется тот же алгоритм как и в случае с подписью из первоначального запроса. Если подпись является НЕВЕРНОЙ, выводится ошибка HASH_MISMATCH, а тег HASH остается незаполненным  |


Коды ошибок RETURN_CODE от сервера метода ALU


| Ключ | Описание |
| -------------| ------------- |
| WRONG_VERSION |    Версия ALU, отправленная ТСП, НЕ существует |
| REQUEST_EXPIRED |  Между ORDER_DATE и датой оплаты прошло более 10 минут или время, превышающее значение ORDER_TIMEOUT, заданное ТСП  |
| INVALID_PAYMENT_METHOD_CODE | Код способа оплаты НЕ принят |
| INVALID_PAYMENT_INFO | Неверные данные карты |
| INVALID_CUSTOMER_INFO | Обязательные данные покупателя отсутствуют или искажены |
| INVALID_CURRENCY | Валюта платежа НЕ принята |
| INVALID_CC_TOKEN | Некорректный токен |
| INVALID_ACCOUNT | Название ТСП  указано неверно |
| HASH_MISMATCH | Параметр HASH, направленный ТСП, не соответствует значению HASH, рассчитанному PayU |
| AUTHORIZED | Если платеж бы успешно авторизован |
| AUTHORIZATION_FAILED | Платеж не авторизован |
| ALREADY_AUTHORIZED | При попытке покупателя разместить новый заказ со значениями ORDER_REF и HASH, аналогичными предыдущему заказу |
| 3DS_ENROLLED | Авторизация платежа должна быть подтверждена покупателем и его банком через 3DS |


<br/>
<br/>
<br/>
## IOS - класс запроса текущего статуса заказа Live Update

#### Инициализируем  класс IOS
```objective-c
IOS *ios = [[IOS alloc] initWithSecretKey:@"e5|S|X~0@l10_?R4b8|1" Merchant:@"ipolhtst" Refnoext:@"3886786"];
```
| Переменная  | Тип |  Обязательно заполнять | Описание |
| -------------| ------------- | ------------- | ------------- |
| SECRET_KEY | NSString | да | Секретный ключ |
| MERCHANT | NSString | да | Идентификатор ТСП в системе PayU |
| REFNOEXT | NSString | да | Внешний ссылочный номер, предоставленный ТСП вместе с заказом |

### Запрашиваем и получаем статус заказа от сервера

```objective-c
[ios sendIOSRequestWithResult:^(NSDictionary *response, NSError *error) {
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
```

Описание ответа от сервера в словаре response


| Ключ  |  Обязательное поле | Описание |
| ------------- | ------------- |------------- |
| ORDER_DATE |   | Дата заказа в формате гггг-дд-мм чч:мм:сс |
| REFNO |   | Глобальный ссылочный номер PayU для заказа (не более 9 символов) |
| REFNOEXT |   | Ссылочный номер заказа ТСП, присвоенный через LiveUpdate (не более 10 символов) |
| ORDER_STATUS |   | Текущий статус заказа |
| PAYMETHOD |   | Метод платежа (не более 40 символов) |
| HASH |   | Подпись HMAC MD5 на основании полей выше |


Коды статуса заказа ORDER_STATUS от сервера метода IOS


| Ключ | Описание |
| -------------| ------------- |
| NOT_FOUND | Не найден/обработка не выполнена |
| WAITING_PAYMENT | Размещен, ожидает платежа |
| CARD_NOTAUTHORIZED | Карта не авторизована |
| IN_PROGRESS	 | Платеж авторизован, заказ в стадии подтверждения |
| PAYMENT_AUTHORIZED | Платеж авторизован, заказ подтвержден |
| COMPLETE | Завершен (оплачен/доставлен) |
| FRAUD | Подозрение на мошенничество |
| INVALID | Покупатель ввел некорректные данные |
| TEST | Тестовый заказ |
| REVERSED | Заказ отменен, средства на счету покупателя разблокированы |
| REFUND | Возврат платежа, деньги переведены обратно на счет покупателя|




<br/>
<br/>
<br/>
## IRN - класс запроса уведомления об отмене/возврате Instant Refund Notification

#### Инициализируем  класс IRN
```objective-c
IRN *irn = [[IRN alloc] initWithSecretKey:@"e5|S|X~0@l10_?R4b8|1"];
```

#### Создаем  параметры в виде словаря NSMutableDictionary
```objective-c
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
```
| Переменная  | Тип |  Обязательно заполнять | Описание |
| -------------| ------------- | ------------- | ------------- |
| SECRET_KEY | NSString | да | Секретный ключ |
| MERCHANT | NSString | да | Идентификатор ТСП в системе PayU |
| ORDER_REF | NSString | да | Идентификационный номер заказа, присваиваемый системой PayU  |
| ORDER_AMOUNT | NSString | да | Сумма заказа |
| ORDER_CURRENCY | NSString | да | Валюта заказа |
| IRN_DATE | NSString | да | Дата направления запроса об отмене заказа/возврате, которая указывается в следующем формате: гггг-мм-дд чч:мм:сс |
| AMOUNT | NSString | нет | Сумма возврата.
Если сумма, заданная этим параметром, меньше общей суммы заказа, направляется запрос ЧАСТИЧНОГО ВОЗВРАТА.
Если параметр AMOUNT равен стоимости заказа, направляется ЗАПРОС ПОЛНОГО ВОЗВРАТА.
Параметр не обязательный, но лучше его всегда передавать. |
| REF_URL | NSString | нет | URL, на который посредством HTTP GET направляется ответ (при необходимости). В случае если данный параметр не выслан или его значение является неверным, ответ отображается в режиме "inline" (например: http://www.my-website.com/irn.php) |
| PRODUCTS_IDS[] | NSArray | нет | Массив данных с идентификационными номерами продуктов для которых отправлен запрос ОТМЕНЫ/ВОЗВРАТА |
| PRODUCTS_QTY[] | NSArray | нет | Массив данных о количестве, соответствующем продуктам, заданным параметром PRODUCTS_IDS |





### Запрашиваем и получаем статус заказа от сервера

```objective-c
[irn sendIRNRequest:orderDetails withResult:^(NSData *response, NSError *error) {
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
```
Варианты ответных сообщений 

| Ответ  |  Значение |
| ------------- | ------------- |
| ОК |   |
| ORDER_REF missing or incorrect |  неверно указан или не указан номер заказа |
| ORDER_AMOUNT missing or incorrect  |  неверно указана или не указана итоговая сумма возврата |
| ORDER_CURRENCY is missing or incorrect | неверно указана (не указана) валюта возврата |
| IRN_DATE is not in the correct format  | некорректный формат поля IRN_DATE  |
| Error cancelling order |  ошибка отмены заказа |
| Order already cancelled | заказ уже был отменен  |
| Unknown error | неизвестная ошибка  |
| Invalid ORDER_REF |  неверно указан номер заказа |
| Invalid ORDER_AMOUNT | неверно указана итоговая сумма возврата  |
| Invalid ORDER_CURRENCY |  Неверная валюта возврата  |
| AMOUNT missing or format incorrect | в запросе нет AMOUNT или его значение некорректно |
| Invalid AMOUNT | неправильное значение AMOUNT  |
| Extra parameter ORDER_MPLACE_MERCHANT or ORDER_MPLACE_AMOUNT sent |  отправлены избыточные параметры ORDER_MPLACE_MERCHANT или ORDER_MPLACE_AMOUNT |
| ORDER_MPLACE_MERCHANT missing or format incorrect | параметра ORDER_MPLACE_MERCHANT нет в запросе или он передан некорректно  |
| ORDER_MPLACE_AMOUNT missing or format incorrect  |  параметра ORDER_MPLACE_AMOUNTнет в запросе или он передан некорректно |
| Invalid ORDER_MPLACE_MERCHANT[] |  неправильный код продавца в запросе |
| Invalid ORDER_MPLACE_AMOUNT[] |  неправильная сумма в запросе |
| ORDER_MPLACE_MERCHANT[] and ORDER_MPLACE_AMOUNT[] not synchronized | ORDER_MPLACE_MERCHANT[] и ORDER_MPLACE_AMOUNT[] не синхронизированы  |
| Amount mismatch | сумма не соответствует ожидаемой |
| ORDER_MPLACE_MERCHANT[] contains a duplicate value | в массиве ORDER_MPLACE_MERCHANT[] есть несколько одинаковых значений |
| This payment method does not support refunds | для данного метода оплаты нельзя провести возврат  |
| Number of maximum refunds for this order reached | достигнуто максимальное количество возвратов по одной транзакции  |
| Multiple refund is not allowed for this order or the amount for refunds exceeded the total amount of the order | множественные возвраты не разрешены для данного заказа, или сумма для возврата превышает общую сумму заказа  |




## Автор

Maxim Melikhov, melikhov@ipolh.com

## Лицензия

IOS_SDK_PAYU is available under the MIT license. See the LICENSE file for more info.
