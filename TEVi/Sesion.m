//
//  Sesion.m
//  TEVi
//
//  Created by Angel  Solsona on 02/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "Sesion.h"
@implementation Sesion


+(NSDictionary *)generaSesion:(NSInteger)n{
    
    NSDictionary *dic=[[NSBundle mainBundle] infoDictionary];
    //NSLog(@"dic %@ ",[dic description]);
    
    NSBundle *mainBundle=[NSBundle mainBundle];
    NSString *api=[[mainBundle objectForInfoDictionaryKey:@"Tevi"] objectForKey:@"api"];
    NSString *version=[mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *appID=@"2";
    NSString *bundle=[mainBundle bundleIdentifier];
    
    NSLog(@"apikey=%@",api);
    
    ///GEneracion de tiempo
    //NSData *inicio=[NSDate date];
    NSString *apiKey=[CryptoARSN Bcrypt:api costo:n];
    //NSLog(@"tiempo Ejecucion %@",[inicio timeIntervalSinceNow]);
    
    NSDictionary *sesion=@{@"apiKey":apiKey,
                           @"version":version,
                           @"aplicacion":appID,
                           @"bundle":bundle
                           };
    return sesion;
    
    
    
    
}

+(NSDictionary *)generaPeticion:(NSDictionary *)parametros{
    NSDictionary *sesion=[Sesion generaSesion:12];
    CryptoARSN *cifrada=[[CryptoARSN alloc] initCriptoARSN256];
    NSError *error;
    NSData *dataParametros=[NSJSONSerialization dataWithJSONObject:parametros options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonParametros=[[NSString alloc] initWithData:dataParametros encoding:NSUTF8StringEncoding];
    NSLog(@"json parametros: %@",jsonParametros);
    NSString *cadenaCifrada=[cifrada EncriptARSN256:jsonParametros];
    
    NSDictionary *envio=@{@"sesion":sesion,@"parametros":cadenaCifrada};
    
    NSData *dataEnvio=[NSJSONSerialization dataWithJSONObject:envio options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonEnvio=[[NSString alloc] initWithData:dataEnvio encoding:NSUTF8StringEncoding];
    
    NSLog(@"envio %@",jsonEnvio);
    
    NSDictionary *dicReturn=@{@"cadena":jsonEnvio};
    return dicReturn;
}

@end
