//
//  CodeColorViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 07/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "CodeColorViewController.h"

@interface CodeColorViewController ()

@end

@implementation CodeColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _KVN=[[KVNProgressConfiguration alloc] init];
    [_KVN setFullScreen:YES];
    _tipoV=@"6";
    _metodoConfigActual++;
    if(_metodoConfigActual==3){
        _controladorSiguiente=@"bienvenido_segue";
    }else{
        _controladorSiguiente=[_arraySeleccionados objectAtIndex:_metodoConfigActual];
    }
    
    _arraySeleccion=[[NSMutableArray alloc] init];
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
    
}


- (IBAction)PrecionaBoton:(UIButton *)sender {
    
    NSString *tagActual=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    if([_arraySeleccion containsObject:tagActual]){
        
        [sender setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ColorS%@",tagActual]] forState:UIControlStateNormal];
        [_arraySeleccion removeObject:tagActual];
    }else{
        [sender setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ColorSO%@",tagActual]] forState:UIControlStateNormal];
        [_arraySeleccion addObject:tagActual];
    }
}

- (IBAction)Siguiente:(id)sender {
    if([_arraySeleccion count]>2){
    
        NSString *pin=@"";
        for(NSString *cadena in _arraySeleccion){
            
            pin=[pin stringByAppendingString:[NSString stringWithFormat:@"%@$",[self ObtenValorColor:[cadena integerValue]]]];
        }
        NSLog(@"pin %@",pin);
        if([self CodigoCorrecto:pin]){
            [self GuardaValidacionCloud];
        }
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Debes elegir al menos 3 cuadritos" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alert show];
    }
}

-(NSString *)ObtenValorColor:(NSInteger)tag{
    NSString *string=@"";
    switch(tag){
            
        case 1:
        {
            
            string=@"3Sm3R4lD4";
        }break;
        case 2:
        {
            string=@"R0j0";
        }break;
        case 3:
        {
            string=@"M0r4d0";
        }break;
        case 4:
        {
            string=@"4M4r1Llo";
        }break;
        case 5:
        {
            string=@"N4r4Nj4";
        }break;
        case 6:
        {
            string=@"V3rd3";
        }break;
        case 7:
        {
            string=@"N3GR0";
        }break;
        case 8:
        {
            string=@"4Z9L";
        }break;
        case 9:
        {
            string=@"Gr1s";
        }break;
            
    }
    
    return string;
    
}

-(BOOL)CodigoCorrecto:(NSString *)codigo{
    BOOL exito=NO;
    if(_codigoActual==nil){
        exito=NO;
        _codigoActual=codigo;
        [_txtAviso setText:@"Verifica tu código de colores"];
        [_btnSiguiente setTitle:@"Confirmar" forState:UIControlStateNormal];
        [self ApagaBotones];
    }else{
        if([_codigoActual isEqualToString:codigo]){
            exito=YES;
        }else{
            exito=NO;
            [_txtAviso setText:@"El codigo no concuerda. Intenta de nuevo"];
            [_btnSiguiente setTitle:@"Siguiente" forState:UIControlStateNormal];
            _codigoActual=nil;
            [self ApagaBotones];
            
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

-(void)ApagaBotones{
    
    for(int i=1;i<10;i++){
        UIButton *btn=(UIButton *)[self.view viewWithTag:i];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ColorS%d",i]] forState:UIControlStateNormal];
    }
    _arraySeleccion=[[NSMutableArray alloc] init];
    
    
}

#pragma mark - Guardadado

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
