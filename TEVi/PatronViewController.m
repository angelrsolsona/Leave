//
//  PatronViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 25/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "PatronViewController.h"

#define MATRIX_SIZE 3

@interface PatronViewController ()

@end

@implementation PatronViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _KVN=[[KVNProgressConfiguration alloc] init];
    [_KVN setFullScreen:YES];
    _tipoV=@"5";

    _metodoConfigActual++;
    if(_metodoConfigActual==3){
        _controladorSiguiente=@"bienvenido_segue";
    }else{
        _controladorSiguiente=[_arraySeleccionados objectAtIndex:_metodoConfigActual];
    }
    
    _vistaPatron2=[[DrawPatternLockView alloc] initWithFrame:CGRectMake(20, 178, 292, 292)];
    _vistaPatron2.backgroundColor = [UIColor clearColor];
    for (int i=0; i<MATRIX_SIZE; i++) {
        for (int j=0; j<MATRIX_SIZE; j++) {
            UIImage *dotImage = [UIImage imageNamed:@"DotOff"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:dotImage
                                                       highlightedImage:[UIImage imageNamed:@"DotOn"]];
            imageView.frame = CGRectMake(0, 0, dotImage.size.width, dotImage.size.height);
            imageView.userInteractionEnabled = YES;
            imageView.tag = j*MATRIX_SIZE + i + 1;
            [_vistaPatron2 addSubview:imageView];
        }
    }
    
    [self.view addSubview:_vistaPatron2];
    
}

- (void)viewWillLayoutSubviews {
    int w = _vistaPatron2.frame.size.width/MATRIX_SIZE;
    int h = _vistaPatron2.frame.size.height/MATRIX_SIZE;
    
    int i=0;
    for (UIView *view in _vistaPatron2.subviews)
        if ([view isKindOfClass:[UIImageView class]]) {
            int x = w*(i/MATRIX_SIZE) + w/2;
            int y = h*(i%MATRIX_SIZE) + h/2;
            view.center = CGPointMake(x, y);
            i++;
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
    
    if ([segue.identifier isEqualToString:@"color_segue"]) {
        
        CodeColorViewController *VC=[segue destinationViewController];
        VC.metodoConfigActual=_metodoConfigActual;
        VC.arraySeleccionados=_arraySeleccionados;
        
    }

}


- (IBAction)Siguiente:(id)sender {
    NSString *codigo=[self getKey];
    if (![codigo isEqualToString:@""]) {
        if([self CodigoCorrecto:codigo]){
            [self GuardaValidacionCloud];
        }
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Debes dibujar un patrón" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alert show];
    }

}

-(void)lockScreen:(SPLockScreen *)lockScreen didEndWithPattern:(NSNumber *)patternNumber{
    NSLog(@"pattern %@",patternNumber);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _paths = [[NSMutableArray alloc] init];
}



- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:_vistaPatron2];
    UIView *touched = [_vistaPatron2 hitTest:pt withEvent:event];
    
    DrawPatternLockView *v = (DrawPatternLockView *)_vistaPatron2;
    [v drawLineFromLastDotTo:pt];
    
    if (touched!=_vistaPatron2 && touched.tag!=0) {
        NSLog(@"touched view tag: %ld ", (long)touched.tag);
        
        BOOL found = NO;
        for (NSNumber *tag in _paths) {
            found = tag.integerValue==touched.tag;
            if (found)
                break;
        }
        
        if (found)
            return;
        
        [_paths addObject:[NSNumber numberWithInt:touched.tag]];
        [v addDotView:touched];
        
        UIImageView* iv = (UIImageView*)touched;
        iv.highlighted = YES;
    }
    
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // clear up hilite
    DrawPatternLockView *v = (DrawPatternLockView *)_vistaPatron2;
    [v clearDotViews];
    
    for (UIView *view in _vistaPatron2.subviews)
        if ([view isKindOfClass:[UIImageView class]])
            [(UIImageView*)view setHighlighted:NO];
    
    [_vistaPatron2 setNeedsDisplay];
    
    // pass the output to target action...
    /*if (_target && _action)
        [_target performSelector:_action withObject:[self getKey]];*/
    NSLog(@"patron %@",[self getKey]);
}


// get key from the pattern drawn
// replace this method with your own key-generation algorithm
- (NSString*)getKey {
    NSMutableString *key;
    key = [NSMutableString string];
    
    // simple way to generate a key
    for (NSNumber *tag in _paths) {
        [key appendFormat:@"%ld", (long)tag.integerValue];
    }
    
    return key;
}


- (void)setTarget:(id)target withAction:(SEL)action {
    _target = target;
    _action = action;
}

#pragma mark - Guardadado

-(BOOL)CodigoCorrecto:(NSString *)codigo{
    BOOL exito=NO;
    if(_codigoActual==nil){
        exito=NO;
        _codigoActual=codigo;
        [_txtAviso setText:@"Verifica tu código de colores"];
        [_btnSiguiente setTitle:@"Confirmar" forState:UIControlStateNormal];
    }else{
        if([_codigoActual isEqualToString:codigo]){
            exito=YES;
        }else{
            exito=NO;
            [_txtAviso setText:@"El codigo no concuerda. Intenta de nuevo"];
            [_btnSiguiente setTitle:@"Siguiente" forState:UIControlStateNormal];
            _codigoActual=nil;
            
            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"position"];
            [animation setDuration:0.05];
            [animation setRepeatCount:8];
            [animation autoreverses];
            [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake([_vistaPatron2 center].x - 120.0f, [_vistaPatron2 center].y)]];
            [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake([_vistaPatron2 center].x + 60.0f, [_vistaPatron2 center].y)]];
            [[_vistaPatron2 layer] addAnimation:animation forKey:@"position"];
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
