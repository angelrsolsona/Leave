//
//  HelperValidacion.h
//  TEVi
//
//  Created by Angel  Solsona on 10/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CryptoARSN.h"
#import "NSCoreDataManager.h"
#import "Validaciones.h"
@interface HelperValidacion : NSObject

+(NSString *)CryptVal:(NSString *)cadena;
+(NSString *)DecryptVal:(NSString *)cadena;
+(NSString *)GeneraAccesoFicha;

@end
