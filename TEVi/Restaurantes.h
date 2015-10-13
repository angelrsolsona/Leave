//
//  Restaurantes.h
//  TEVi
//
//  Created by Angel  Solsona on 13/10/15.
//  Copyright © 2015 Kelevrads. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurantes : NSObject

@property(strong,nonatomic)NSString *idRestaurante;
@property(strong,nonatomic)NSString *nombre;
@property(strong,nonatomic)NSString *direccion;
@property(strong,nonatomic)NSString *latitud;
@property(strong,nonatomic)NSString *longitud;
@property(strong,nonatomic)NSString *distancia;

@end
