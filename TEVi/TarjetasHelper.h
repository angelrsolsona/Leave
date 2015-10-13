//
//  TarjetasHelper.h
//  TEVi
//
//  Created by Angel  Solsona on 25/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSCoreDataManager.h"
#import "Tarjetas.h"
#import "Tarjeta.h"
#import "HelperValidacion.h"
#import "CryptoARSN.h"
@interface TarjetasHelper : NSObject

+(NSDictionary *)GuardaFicha:(Tarjeta *)tarjeta;
+(NSMutableArray *)ObtenTarjetas;
@end
