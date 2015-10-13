//
//  Tarjeta.h
//  TEVi
//
//  Created by Angel  Solsona on 22/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tarjeta : NSObject

@property(strong,nonatomic)NSString *noFicha;
@property(strong,nonatomic)NSString *noFichaHidden;
@property(strong,nonatomic)NSString *cvv;
@property(strong,nonatomic)NSString *vigencia;
@property(strong,nonatomic)NSString *naturalezaContable;
@property(strong,nonatomic)NSString *afiliacionFichaID;
@property(strong,nonatomic)UIImage *afiliacionFichaImagen;
@property(strong,nonatomic)NSString *tituloFicha;
@property(strong,nonatomic)NSString *nombreTitular;
@property(strong,nonatomic)NSString *nombreBanco;
@property(strong,nonatomic)NSString *idFondoFicha;
@property(strong,nonatomic)UIImage *fotoFicha;
@property(strong,nonatomic)NSString *tokenFicha;
@property(strong,nonatomic)NSString *bin;

-(void)ObtenBin;


@end
