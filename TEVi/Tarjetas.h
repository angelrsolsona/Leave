//
//  Tarjetas.h
//  TEVi
//
//  Created by Angel  Solsona on 25/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tarjetas : NSManagedObject

@property (nonatomic, retain) NSString * noFichaHidden;
@property (nonatomic, retain) NSString * cvv;
@property (nonatomic, retain) NSString * vigencia;
@property (nonatomic, retain) NSString * naturalezaContable;
@property (nonatomic, retain) NSString * afiliacionFichaID;
@property (nonatomic, retain) NSData * afiliacionFichaImagen;
@property (nonatomic, retain) NSString * tituloFicha;
@property (nonatomic, retain) NSString * nombreTitular;
@property (nonatomic, retain) NSString * nombreBanco;
@property (nonatomic, retain) NSString * idFondoFicha;
@property (nonatomic, retain) NSData * fotoFicha;
@property (nonatomic, retain) NSString * nF;
@property (nonatomic, retain) NSString * f;
@property (nonatomic, retain) NSString * tokenFicha;
@property (nonatomic, retain) NSString * bin;

@end
