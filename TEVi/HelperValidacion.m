//
//  HelperValidacion.m
//  TEVi
//
//  Created by Angel  Solsona on 10/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "HelperValidacion.h"

@implementation HelperValidacion

+(NSString *)CryptVal:(NSString *)cadena{
    CryptoARSN *arsn=[[CryptoARSN alloc] initCriptoARSN256];
    return [arsn EncriptARSN256:cadena];
}
+(NSString *)DecryptVal:(NSString *)cadena{
    CryptoARSN *arsn=[[CryptoARSN alloc] initCriptoARSN256];
    return [arsn DesencriptARSN256:cadena];
}

+(NSString *)GeneraAccesoFicha{
    NSArray *array=[NSCoreDataManager getDataWithEntity:@"Validaciones" andManagedObjContext:[NSCoreDataManager getManagedContext] orderWithKey:@"idValidacion"];
    NSString *acceso;
    if([array count]>0){
        NSRange range10=NSMakeRange(0, 10);
        NSRange range12=NSMakeRange(0, 12);
        Validaciones *V1=[array objectAtIndex:0];
        Validaciones *V2=[array objectAtIndex:1];
        Validaciones *V3=[array objectAtIndex:2];
        
        NSString *CE1=[V1.valor substringWithRange:range10];
        NSString *CE2=[V2.valor substringWithRange:range10];
        NSString *CE3=[V3.valor substringWithRange:range12];
        
        acceso=[NSString stringWithFormat:@"%@%@%@",CE1,CE2,CE3];
        
        NSLog(@"CE total: %@ CE 10: %@",[array objectAtIndex:0],CE1);
        
    }
    
    return acceso;
    
    
}
@end
