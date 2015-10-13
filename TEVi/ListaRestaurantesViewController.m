//
//  ListaRestaurantesViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 09/10/15.
//  Copyright © 2015 Kelevrads. All rights reserved.
//

#import "ListaRestaurantesViewController.h"

@implementation ListaRestaurantesViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    _arrayRestaurantes=[[NSMutableArray alloc] init];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    _HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [_HUD setLabelText:@"Obteniendo Restaurantes"];
    [_HUD setMode:MBProgressHUDModeIndeterminate];
    [self.view addSubview:_HUD];
    [_HUD show:YES];
    NSDictionary *params=@{@"funcion":@"ListaRestaurante",
                           @"latitud":@"19.4156",
                           @"longitud":@"-99.1676",
                           };
    
    NSDictionary *cipherParams=[Sesion generaPeticion:params];
    
    _conexion=[[NSConnection alloc] initWithRequestURL:[NSString stringWithFormat:@"%@%@",k_websiteLEAVE,k_WS_Registro] parameters:cipherParams idRequest:1 delegate:self];
    [_conexion connectionPOSTExecute];
    
    
    
}

#pragma mark - Delegate NSconnection

-(void)connectionDidFinish:(id)result numRequest:(NSInteger)numRequest{
    
    switch (numRequest) {
    
        case 1:
        {
            NSError *error;
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"DIC %@",[dic description]);
            CryptoARSN *decifrada=[[CryptoARSN alloc] initCriptoARSN256];
            NSString *jsonResponse=[decifrada DesencriptARSN256:[dic objectForKey:@"parametros"]];
            
            NSDictionary *dicResponse=[NSJSONSerialization JSONObjectWithData:[jsonResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"dic parametros %@",[dicResponse description]);
            if ([[dic objectForKey:@"exito"] boolValue]) {
                
                if ([[dicResponse objectForKey:@"code"] isEqualToString:@"001011"]) {
                    
                    for (NSDictionary *restTMP in [dicResponse objectForKey:@"lista"]) {
                        Restaurantes *restaurante=[[Restaurantes alloc] init];
                        restaurante.idRestaurante=[restTMP objectForKey:@"id_sucursal"];
                        restaurante.nombre=[restTMP objectForKey:@"nombre_sucursal"];
                        restaurante.direccion=[restTMP objectForKey:@"direccion"];
                        restaurante.latitud=[restTMP objectForKey:@"latitud"];
                        restaurante.longitud=[restTMP objectForKey:@"longitud"];
                        restaurante.distancia=[restTMP objectForKey:@"distancia"];
                    }
                }
                
            }else{
                [_HUD hide:YES];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:[NSString stringWithFormat:@"Error de comunicación code:%@",[dicResponse objectForKey:@"code"]] delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
                [alert show];
            }
        }
            break;
    }

    
}
-(void)connectionDidFail:(NSString *)error{
    NSLog(@"error %@",error);
    [_HUD hide:YES];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Error de conexion intente de nuevo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    [alert show];
}
@end
