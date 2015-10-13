//
//  Tarjeta.m
//  TEVi
//
//  Created by Angel  Solsona on 22/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "Tarjeta.h"

@implementation Tarjeta


-(void)ObtenBin{
    if ([_afiliacionFichaID isEqualToString:@"3"]) {
        NSRange rangoBIN=NSMakeRange(0, 4);
        _bin=[_noFicha substringWithRange:rangoBIN];
    }else{
        NSRange rangoBIN=NSMakeRange(0, 6);
        _bin=[_noFicha substringWithRange:rangoBIN];
    }
    
    
}
@end
