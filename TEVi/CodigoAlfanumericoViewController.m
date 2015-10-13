//
//  CodigoAlfanumericoViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 31/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "CodigoAlfanumericoViewController.h"

@interface CodigoAlfanumericoViewController ()

@end

@implementation CodigoAlfanumericoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self InicializaTextField];
    _KVN=[[KVNProgressConfiguration alloc] init];
    [_KVN setFullScreen:YES];
    _tipoV=@"4";

    _metodoConfigActual++;
    if(_metodoConfigActual==3){
        _controladorSiguiente=@"bienvenido_segue";
    }else{
        _controladorSiguiente=[_arraySeleccionados objectAtIndex:_metodoConfigActual];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [_vistaScroll setContentSize:CGSizeMake(320,850)];
    //[_containerView setFrame:CGRectMake(0, 100, 320, 228)];
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
    }
    if ([segue.identifier isEqualToString:@"pin_segue"]) {
        
        PinViewController *VC=[segue destinationViewController];
        VC.metodoConfigActual=_metodoConfigActual;
        VC.arraySeleccionados=_arraySeleccionados;
        
    }
    if ([segue.identifier isEqualToString:@"touchid_segue"]) {
        
        TouchIDViewController *VC=[segue destinationViewController];
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


- (IBAction)Siguiente:(id)sender {
    
    if([_codigo1 validate] && [_codigo2 validate]){
        if([_codigo1.text isEqualToString:_codigo2.text]){
            _codigoActual=_codigo1.text;
            [self GuardaValidacionCloud];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Los codigos no coinciden" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
            [alert show];
            [self ShakeView:_codigo1];
            [self ShakeView:_codigo2];
        }
    }
}

#pragma mark - UITexfieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect rc=[textField bounds];
    rc=[textField convertRect:rc toView:_vistaScroll];
    CGPoint pt=rc.origin;
    pt.x=0;
    pt.y-=200;
    [_vistaScroll setContentOffset:pt animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [_vistaScroll setContentOffset:CGPointMake(0, 0)animated:YES];
    return YES;
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

-(void)ShakeView:(id)sender{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:8];
    [animation autoreverses];
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake([sender center].x - 120.0f, [sender center].y)]];
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake([sender center].x + 60.0f, [sender center].y)]];
    [[sender layer] addAnimation:animation forKey:@"position"];
}

#pragma mark - Metodo Test

-(IBAction)CambiaVistaTest:(id)sender{
    [self performSegueWithIdentifier:_controladorSiguiente sender:self];
}

-(void)InicializaTextField{
    //[_nombre addRegx:REGEX_NOMBRE withMsg:@"El nombre debe iniciar con mayúsculas"];
    [_codigo1 setPresentInView:self.view];
    [_codigo2 setPresentInView:self.view];
}

@end
