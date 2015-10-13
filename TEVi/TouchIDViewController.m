//
//  TouchIDViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 31/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "TouchIDViewController.h"

@interface TouchIDViewController ()

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _KVN=[[KVNProgressConfiguration alloc] init];
    [_KVN setFullScreen:YES];
    _tipoV=@"3";
    _metodoConfigActual++;
    if(_metodoConfigActual==3){
        _controladorSiguiente=@"bienvenido_segue";
    }else{
        _controladorSiguiente=[_arraySeleccionados objectAtIndex:_metodoConfigActual];
    }
    [_btnSiguiente setEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"imagen_segue"]) {
        
        ImagenViewController *VC=[segue destinationViewController];
        VC.metodoConfigActual=_metodoConfigActual;
        VC.arraySeleccionados=_arraySeleccionados;
        
    }else if ([segue.identifier isEqualToString:@"pin_segue"]) {
        
        ImagenViewController *VC=[segue destinationViewController];
        VC.metodoConfigActual=_metodoConfigActual;
        VC.arraySeleccionados=_arraySeleccionados;
        
    }
    if ([segue.identifier isEqualToString:@"codigo_segue"]) {
        
        CodigoAlfanumericoViewController *VC=[segue destinationViewController];
        VC.metodoConfigActual=_metodoConfigActual;
        VC.arraySeleccionados=_arraySeleccionados;
        
    }
    if ([segue.identifier isEqualToString:@"patron_segue"]) {
        
        PatronViewController *VC=[segue destinationViewController];
        VC.metodoConfigActual=_metodoConfigActual;
        VC.arraySeleccionados=_arraySeleccionados;
        
    }
    
    if ([segue.identifier isEqualToString:@"color_segue"]) {
        
        CodeColorViewController *VC=[segue destinationViewController];
        VC.metodoConfigActual=_metodoConfigActual;
        VC.arraySeleccionados=_arraySeleccionados;
        
    }
    
}





- (IBAction)Escanear:(id)sender {
    
    LAContext *context=[[LAContext alloc] init];
    NSError *error;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Para realizar la transaccion es necesario autenticarte " reply:^(BOOL success, NSError *error) {
            
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Hay un problema para identificarte intenta de nuevo"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                    [alert show];
                    return;
                    
                });
                
            }
            
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [_btnSiguiente setEnabled:YES];
                    _codigoActual=@"T09cH1d1";
                });
               
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Hay un problema para identificarte intenta de nuevo"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                    [alert show];
                                        
                    
                });
                
                
            }
        }];
        
        
    }else{
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Contraseña" message:@"Para hacer la transaccion introduce tu contraseña" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Realizar Transaccion", nil];
        [alert setAlertViewStyle:UIAlertViewStyleSecureTextInput];
        [alert setTag:1];
        [alert show];
        
    }

}

- (IBAction)Siguiente:(id)sender {
    
    
    [self GuardaValidacionCloud];
}

#pragma mark - Guardadado

-(void)GuardaValidacionCloud{
    [KVNProgress setConfiguration:_KVN];
    [KVNProgress showWithStatus:@"Guardando Validacion" onView:self.view];
    UsuarioHelper *helperUsuario=[[UsuarioHelper alloc] init];
    _valorCrypt=[HelperValidacion CryptVal:_codigoActual];
    
    NSDictionary *params=@{@"funcion":@"AltaValidacion",
                           @"guid":helperUsuario.usuario.guid,
                           @"idTipoValidacion":_tipoV,
                           @"valor":_valorCrypt
                           };
    
    NSDictionary *cipherParams=[Sesion generaPeticion:params];
    NSLog(@"peticion %@",cipherParams);
    _conexion=[[NSConnection alloc] initWithRequestURL:[NSString stringWithFormat:@"%@%@",k_website,k_WS_Registro] parameters:cipherParams idRequest:1 delegate:self];
    [_conexion connectionPOSTExecute];
    
    
    
}

-(BOOL)GuardaValidacionBD{
    Validaciones *val=[NSEntityDescription insertNewObjectForEntityForName:@"Validaciones" inManagedObjectContext:[NSCoreDataManager getManagedContext]];
    val.idValidacion=[NSNumber numberWithInteger:[_tipoV integerValue]];
    val.valor=_valorCrypt;
    BOOL exito=[NSCoreDataManager SaveData];
    return exito;
}

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
            if([[dic objectForKey:@"exito"] boolValue]){
                
                if ([[dicResponse objectForKey:@"code"] isEqualToString:@"000007"]) {
                    if([self GuardaValidacionBD]){
                        [self performSegueWithIdentifier:_controladorSiguiente sender:self];
                    }
                }
            }else{
                
                
                if([[dicResponse objectForKey:@"code"] isEqualToString:@"000008"]){
                    
                    [KVNProgress setConfiguration:_KVN];
                    [KVNProgress showErrorWithStatus:@"Error al registrar el método de seguridad. Intente de nuevo" onView:self.view completion:^{
                        [KVNProgress dismiss];
                    }];
                }else if([[dicResponse objectForKey:@"code"] isEqualToString:@"000017"]){
                    
                    [KVNProgress setConfiguration:_KVN];
                    [KVNProgress showErrorWithStatus:@"Error al validar usuario. Intente de nuevo" onView:self.view completion:^{
                        [KVNProgress dismiss];
                    }];
                }else if([[dicResponse objectForKey:@"code"] isEqualToString:@"000002"]){
                    
                    [KVNProgress setConfiguration:_KVN];
                    [KVNProgress showErrorWithStatus:@"Error de conexion. Intente de nuevo" onView:self.view completion:^{
                        [KVNProgress dismiss];
                    }];
                }
                
            }
            
            
        }break;
            
        default:
            break;
    }
    
}
-(void)connectionDidFail:(NSString *)error{
    NSLog(@"error %@",error);
    [KVNProgress setConfiguration:_KVN];
    [KVNProgress showErrorWithStatus:@"Error al conectar con el servidor. Intente de nuevo" onView:self.view completion:^{
        [KVNProgress dismiss];
    }];
}

#pragma mark - Metodo Test

-(IBAction)CambiaVistaTest:(id)sender{
    [self performSegueWithIdentifier:_controladorSiguiente sender:self];
}

@end
