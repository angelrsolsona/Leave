//
//  IdentificacionViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 16/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "IdentificacionViewController.h"

@implementation IdentificacionViewController


-(void)viewDidLoad{
    _KVN=[[KVNProgressConfiguration alloc] init];
    [_KVN setFullScreen:YES];
    _adjuntoFoto=NO;
    _StipoIdentificacion=@"1";
    [_folio setPresentInView:self.view];
}

-(IBAction)Siguiente:(id)sender{
    if ([_folio validate]) {
        if (_adjuntoFoto) {
            
            [self GuardaCloud];
            //[self performSegueWithIdentifier:@"altaTarjeta_segue" sender:self];
            
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Debes tomar la foto de tu identificacación" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
            [alert show];
        }
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Debes llenar el campo folio" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)CambiaTipo:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex==0) {
        _StipoIdentificacion=@"1";
    }else if (sender.selectedSegmentIndex==1){
        _StipoIdentificacion=@"2";
    }
    
    
    
}

- (IBAction)SubirFoto:(id)sender {
    
    [self MuestraCamara];
    
}

#pragma mark - Fotografia

-(void)MuestraCamara{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Este dispositivo no tiene cámara" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alert show];
        alert=nil;
    }else{
        if (_picker==nil) {
            _picker=[[UIImagePickerController alloc] init];
        }
        [_picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [_picker setDelegate:self];
        [self presentViewController:_picker animated:YES completion:nil];
        _picker=nil;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *imagen=[info objectForKey:UIImagePickerControllerOriginalImage];
    _foto=[self imageWithImage:imagen scaledToSize:CGSizeMake((imagen.size.width/2.0f),(imagen.size.height))];
    [self dismissViewControllerAnimated:YES completion:nil];
    _adjuntoFoto=YES;
    
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)targetSize;

{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - Guardado Cloud

-(void)GuardaCloud{
    [KVNProgress setConfiguration:_KVN];
    [KVNProgress showWithStatus:@"Guardando Validacion" onView:self.view];
    UsuarioHelper *helperUsuario=[[UsuarioHelper alloc] init];
    NSString *guid=helperUsuario.usuario.guid;
    NSDictionary *params=@{@"funcion":@"RegistraIdentificacion",
                           @"guid":guid,
                           @"idIdentificacion":_StipoIdentificacion,
                           @"folio":_folio.text
                           };
    
    NSDictionary *cipherParams=[Sesion generaPeticion:params];
    NSLog(@"peticion %@",cipherParams);
    _conexion=[[NSConnection alloc] initWithRequestURL:[NSString stringWithFormat:@"%@%@",k_website,k_WS_Registro] parameters:cipherParams idRequest:1 delegate:self];
    [_conexion connectionPOSTExecuteUploadImage:_foto];
    
    
    
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

#pragma mark - NSConnection Delegate

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
                
                if ([[dicResponse objectForKey:@"code"] isEqualToString:@"000024"]) {
                    
                    [KVNProgress setConfiguration:_KVN];
                    [KVNProgress showSuccessWithStatus:@"Operacion Exitosa" onView:self.view completion:^{
                        
                        [self performSegueWithIdentifier:@"altaTarjeta_segue" sender:self];
                        
                    }];
                    
                }
            }else{
                if([[dicResponse objectForKey:@"code"] isEqualToString:@"000025"]){
                    
                    [KVNProgress setConfiguration:_KVN];
                    [KVNProgress showErrorWithStatus:@"Error al registrar el método de seguridad. Intente de nuevo" onView:self.view completion:^{
                        [KVNProgress dismiss];
                    }];
                }else if([[dicResponse objectForKey:@"code"] isEqualToString:@"000026"]){
                    
                    [KVNProgress setConfiguration:_KVN];
                    [KVNProgress showErrorWithStatus:@"El folio ya existe corrigelo" onView:self.view completion:^{
                        [KVNProgress dismiss];
                    }];
                }else if([[dicResponse objectForKey:@"code"] isEqualToString:@"000027"]){
                    
                    [KVNProgress setConfiguration:_KVN];
                    [KVNProgress showErrorWithStatus:@"Error al validar usuario. Intente de nuevo" onView:self.view completion:^{
                        [KVNProgress dismiss];
                    }];
                }
            }
            
            
            
        }
            break;
            
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

-(void)InicializaTextField{
    
    [_folio setPresentInView:self.view];
    [_folio addRegx:@"[A-Za-z0-9]{13}" withMsg:@"El folio debe ser de 13 caracteres sin caracteres epeciales"];
}


@end
