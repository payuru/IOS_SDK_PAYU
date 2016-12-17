//
//  MCHelper.h
//  PAYU_Example
//
//  Created by Max on 25.11.16.
//  Copyright © 2016 IPOL OOO. All rights reserved.
//

#define LanguageTypeString(LanguageType) [@[@"EN",@"RO",@"HU",@"RU",@"DE",@"FR",@"IT",@"ES"] objectAtIndex:LanguageType]

typedef enum{
    LanguageTypeEN,
    LanguageTypeRO,
    LanguageTypeHU,
    LanguageTypeRU,
    LanguageTypeDE,
    LanguageTypeFR,
    LanguageTypeIT,
    LanguageTypeES
}LanguageType;


#define BoolToSTR(bool) (bool) ? @"TRUE" : @"FALSE"
#define BoolToSTRNumber(bool) (bool) ? @"1" : @"0"



typedef enum{
    GROSS,  //(включая НДС)
    NET     // (НДС включается в PayU),
}PriceType;

#define PriceTypeString(PriceType) [@[@"GROSS",@"NET"] objectAtIndex:PriceType]

typedef NS_ENUM(NSInteger, ProductErrorCodes) {
    ProductErrorCodesEmptyName,
    ProductErrorCodesEmptyCode,
    ProductErrorCodesEmptyPrice,
    
    ProductErrorCodesLongName,
    ProductErrorCodesLongCode,
    
    ProductErrorCodesWrongPrice,
    ProductErrorCodesWrongQTY,
    ProductErrorCodesWrongVAT,
    ProductErrorCodesWrongShipping
};
typedef enum{
    NONE,
    RUB,
    EUR,
    USD
}PRICES_CURRENCYType;

#define PriceCurrencyTypeString(PRICES_CURRENCYType) [@[@"",@"RUB",@"EUR",@"USD"] objectAtIndex:PRICES_CURRENCYType]

@interface PAYHelper : NSObject{
    NSMutableDictionary *dicKey;
    NSMutableDictionary *dicHashKey;
}
-(void)addObject:(NSString*)value key:(NSString*)key hash:(BOOL)hashFlag;
-(void)addHash:(NSString*)obj;
-(NSString*)postString;
-(NSString*)hashString;

-(NSString*)LUpostStringWithProducts:(NSMutableArray*)products;
-(NSString*)LUhashStringWithProducts:(NSMutableArray*)products;
@end;


