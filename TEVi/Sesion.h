//
//  Sesion.h
//  TEVi
//
//  Created by Angel  Solsona on 02/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CryptoARSN.h"
@interface Sesion : NSObject

+(NSDictionary *)generaSesion:(NSInteger)n;

+(NSDictionary *)generaPeticion:(NSDictionary *)parametros;
@end
