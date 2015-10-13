//
//  ImagenViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 25/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "ImagenViewController.h"

@interface ImagenViewController ()

@end

@implementation ImagenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _KVN=[[KVNProgressConfiguration alloc] init];
    [_KVN setFullScreen:YES];
    _tipoV=@"1";
    _tagActual=-1;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"pin_segue"]) {
        
        PinViewController *VC=[segue destinationViewController];
        VC.metodoConfigActual=_metodoConfigActual;
        VC.arraySeleccionados=_arraySeleccionados;
        
    }
    if ([segue.identifier isEqualToString:@"codigo_segue"]) {
        
        CodigoAlfanumericoViewController *VC=[segue destinationViewController];
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


- (IBAction)SeleccionaImagen:(UIButton *)sender {
    
    if(_tagActual!=-1){
        UIButton *btnAnterior=(UIButton *)[self.view viewWithTag:_tagActual];
        [btnAnterior setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ImagenS%ld",(long)_tagActual]] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ImagenSO%ld",(long)sender.tag]] forState:UIControlStateNormal];
        _tagActual=sender.tag;
    }else{
        [sender setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ImagenSO%ld",(long)sender.tag]] forState:UIControlStateNormal];
        _tagActual=sender.tag;
    }
    
    
}

-(void)ApagaBotones{

        UIButton *btn=(UIButton *)[self.view viewWithTag:_tagActual];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ImagenS%d",_tagActual]] forState:UIControlStateNormal];
    
    
    
}
- (IBAction)Siguiente:(id)sender {
    
    if (_tagActual!=-1) {
        if([self CodigoCorrecto:[NSString stringWithFormat:@"1M4g3N%d",_tagActual]]){
            [self GuardaValidacionCloud];
        }
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Debes elegir un imagen" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alert show];
    }

    
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
            
            
        } break;
            
        default:
            break;
    }
    
}

-(void)connectionDidFail:(NSString *)error{
    NSLog(@"error %@",error);
}

#pragma mark - Guardado

-(BOOL)CodigoCorrecto:(NSString *)codigo{
    BOOL exito=NO;
    if(_codigoActual==nil){
        exito=NO;
        _codigoActual=codigo;
        [_txtAviso setText:@"Selecciona de nuevo la imagen"];
        [self ApagaBotones];
        [_btnSiguiente setTitle:@"Confirmar" forState:UIControlStateNormal];
    }else{
        if([_codigoActual isEqualToString:codigo]){
            exito=YES;
        }else{
            exito=NO;
            [_txtAviso setText:@"Las imagenes no concuerdan intenta de nuevo"];
            [self ApagaBotones];
            [_btnSiguiente setTitle:@"Siguiente" forState:UIControlStateNormal];
            _codigoActual=nil;
            
            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
            [animation setDuration:0.05];
            [animation setRepeatCount:8];
            [animation autoreverses];
            [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake([_fondo center].x - 120.0f, [_fondo center].y)]];
            [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake([_fondo center].x + 60.0f, [_fondo center].y)]];
            [[_fondo layer] addAnimation:animation forKey:@"position"];
        }
    }
    
    return exito;
}

-(void)GuardaValidacionCloud{
    [KVNProgress setConfiguration:_KVN];
    [KVNProgress showWithStatus:@"Guardando Validacion" onView:self.view];
    UsuarioHelper *helperUsuario=[[UsuarioHelper alloc] init];
    _valorCrypt=[HelperValidacion CryptVal:_codigoActual];
    NSString *guid=helperUsuario.usuario.guid;
    NSDictionary *params=@{@"funcion":@"AltaValidacion",
                           @"guid":guid,
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

#pragma mark - Metodo Test

-(IBAction)CambiaVistaTest:(id)sender{
    [self performSegueWithIdentifier:_controladorSiguiente sender:self];
}




@end
