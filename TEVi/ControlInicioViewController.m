//
//  ControlInicioViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 02/10/15.
//  Copyright © 2015 Kelevrads. All rights reserved.
//

#import "ControlInicioViewController.h"

@implementation ControlInicioViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _datosAlm=[NSUserDefaults standardUserDefaults];
    [self ConstruyeJSON];
    BOOL login=[[_datosAlm objectForKey:@"login"] boolValue];
    if (login) {
        // Ya esta logueado
        
    }else{
        BOOL estaRegistrado=[[_datosAlm objectForKey:@"estaRegistrado"] boolValue];
        if (estaRegistrado) {
            // Enviar a login ya tiene cuenta
        }else{
            // Enviar a login y registro
            [self performSegueWithIdentifier:@"inicioregistro_segue" sender:self];
        }
    }
}

-(void)ConstruyeJSON{
    
    /*NSDictionary *params=@{
                           @"funcion":@"ListaRestaurante",
                           @"latitud":@"19.4156",
                           @"longitud":@"-99.1676"
                           };*/
    NSDictionary *params=@{
     @"funcion":@"ObtenInformacionRestaurante",
     @"idRestaurante":@"1"
     };
    
    NSDictionary *cipherParams=[Sesion generaPeticion:params];
    NSLog(@"peticion %@",cipherParams);
}

@end
