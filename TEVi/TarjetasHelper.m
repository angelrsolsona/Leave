//
//  TarjetasHelper.m
//  TEVi
//
//  Created by Angel  Solsona on 25/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "TarjetasHelper.h"

@implementation TarjetasHelper

+(NSDictionary *)GuardaFicha:(Tarjeta *)tarjeta{
    
    //NSArray *array=[NSCoreDataManager getDataWithEntity:@"Validaciones" andManagedObjContext:[NSCoreDataManager getManagedContext] orderWithKey:@"idValidacion"];
    NSDictionary *dic;
    BOOL exito=NO;
    Tarjetas *tarjetas=[NSEntityDescription insertNewObjectForEntityForName:@"Tarjetas" inManagedObjectContext:[NSCoreDataManager getManagedContext]];
    
    //if([array count]>0){
        
        NSString *AF=[HelperValidacion GeneraAccesoFicha];

        NSRange RT1=NSMakeRange(0, 4);
        NSRange RT2=NSMakeRange(4, 4);
        NSRange RT3=NSMakeRange(8, 4);
        NSRange RT4=NSMakeRange(12, 4);
        NSRange RTAE4=NSMakeRange(12, 3);
        
        NSString *uno=[tarjeta.noFicha substringWithRange:RT1];
        NSString *dos=[tarjeta.noFicha substringWithRange:RT2];
        NSString *tres=[tarjeta.noFicha substringWithRange:RT3];
        NSString *cuatro;
        if([tarjeta.afiliacionFichaID integerValue]==3){
             cuatro=[tarjeta.noFicha substringWithRange:RTAE4];
        }else{
             cuatro=[tarjeta.noFicha substringWithRange:RT4];
        }
        NSString *unoTres=[NSString stringWithFormat:@"%@%@ABC$&*´()AB*",uno,tres];
        NSString *dosCuatro=[NSString stringWithFormat:@"%@%@",dos,cuatro];
    
        CryptoARSN *crypto=[[CryptoARSN alloc] initCriptoARSN256WithKey:AF];
        
        NSString *NF=[crypto EncriptARSN256:unoTres];
        NSRange RNF=NSMakeRange(0, 32);
        NSString *NFKey=[NF substringWithRange:RNF];
        
        CryptoARSN *crypto2=[[CryptoARSN alloc] initCriptoARSN256WithKey:NFKey];
        NSString *F=[crypto2 EncriptARSN256:dosCuatro];
        
        
        
        CryptoARSN *criptoARSN=[[CryptoARSN alloc] initCriptoARSN256];
        
        
        tarjetas.noFichaHidden=tarjeta.noFichaHidden;
        tarjetas.cvv=[criptoARSN EncriptARSN256:tarjeta.cvv];
        tarjetas.vigencia=[criptoARSN EncriptARSN256:tarjeta.vigencia];
        tarjetas.naturalezaContable=[criptoARSN EncriptARSN256:tarjeta.naturalezaContable];
        tarjetas.afiliacionFichaID=tarjeta.afiliacionFichaID;
        tarjetas.afiliacionFichaImagen=UIImagePNGRepresentation(tarjeta.afiliacionFichaImagen);
        tarjetas.tituloFicha=[criptoARSN EncriptARSN256:tarjeta.tituloFicha];
        tarjetas.nombreTitular=[criptoARSN EncriptARSN256:tarjeta.nombreTitular];
        tarjetas.nombreBanco=[criptoARSN EncriptARSN256:tarjeta.nombreBanco];
        tarjetas.idFondoFicha=tarjeta.idFondoFicha;
        tarjetas.f=F;
        tarjetas.nF=NF;
        tarjetas.bin=[criptoARSN EncriptARSN256:tarjeta.bin];
        
    NSLog(@"Valor de AT= %@ \n F= %@ \n NF= %@",AF,NF,F);
    
    
        
    //}
    
    dic=@{@"exito":[NSString stringWithFormat:@"%d",exito],@"tarjetas":tarjeta};
    return dic;
    
    
}

+(NSMutableArray *)ObtenTarjetas{
    
    NSArray *array=[NSCoreDataManager getDataWithEntity:@"Tarjetas" andManagedObjContext:[NSCoreDataManager getManagedContext]];
    NSMutableArray *arrayTarjeta=[[NSMutableArray alloc] init];
    if ([array count]>0) {
     CryptoARSN *criptoARSN=[[CryptoARSN alloc] initCriptoARSN256];
        
        for (Tarjetas *tarjetas in array) {
            
            Tarjeta *tarjeta=[[Tarjeta alloc] init];
            
            tarjeta.noFichaHidden=tarjetas.noFichaHidden;
            tarjeta.cvv=[criptoARSN DesencriptARSN256:tarjetas.cvv];
            tarjeta.vigencia=[criptoARSN DesencriptARSN256:tarjetas.vigencia];
            tarjeta.afiliacionFichaID=tarjetas.afiliacionFichaID;
            tarjeta.afiliacionFichaImagen=[UIImage imageWithData:tarjetas.afiliacionFichaImagen];
            tarjeta.tituloFicha=[criptoARSN DesencriptARSN256:tarjetas.tituloFicha];
            tarjeta.nombreTitular=[criptoARSN DesencriptARSN256:tarjetas.nombreTitular];
            tarjeta.nombreBanco=[criptoARSN DesencriptARSN256:tarjetas.nombreBanco];
            tarjeta.idFondoFicha=tarjetas.idFondoFicha;
            tarjeta.bin=[criptoARSN DesencriptARSN256:tarjetas.bin];
            
            [arrayTarjeta addObject:tarjeta];
            
        }
    }
    
    return arrayTarjeta;
}

@end
