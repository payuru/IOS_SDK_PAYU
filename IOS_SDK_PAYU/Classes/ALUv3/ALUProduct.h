//
//  ALUProduct.h
//  PAYU_Example
//
//  Created by Max on 25.11.16.
//  Copyright © 2016 IPOL OOO. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PAYHelper.h"

@interface ALUProduct:NSObject{
    NSString *name; // 155 знаков на одно название продукта
    NSString *code;  //Максимальная длина кода 1 товара: 50 символов.
    NSNumber *price; // проверка на «.» и положительную часть ORDER_PRICE[]
    NSUInteger qty;
    NSUInteger vat;
    NSString *pinfo;
    NSString *ver;

    
}

@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSString *code;
@property (nonatomic,readonly) NSNumber *price;
@property (nonatomic,readonly) NSUInteger qty;
@property (nonatomic,strong) NSString *pinfo;
@property (nonatomic,strong) NSString *ver;
-(id)initALUProductWithName:(NSString*)Name code:(NSString*)Code price:(NSNumber*)Price qty:(NSUInteger)Qty;
-(NSString*)qtyString;
-(NSString*)vatString;

@end

