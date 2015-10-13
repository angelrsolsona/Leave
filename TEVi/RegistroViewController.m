//
//  RegistroViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 18/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "RegistroViewController.h"

@interface RegistroViewController ()

@end

@implementation RegistroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTextfield];
    _foto.layer.borderWidth=3.0;
    _foto.layer.borderColor=[UIColor colorWithRed:97/255.0f green:148/255.0f blue:68/255.0f alpha:1.0].CGColor;
    _foto.layer.cornerRadius=_foto.frame.size.width/2;
    _foto.clipsToBounds=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SeleccinaFoto)];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [_foto addGestureRecognizer:tap];
    [_foto setUserInteractionEnabled:YES];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Acciones de Botones
- (IBAction)Siguiente:(id)sender {
    
    if([_nombre validate]&&[_apPaterno validate]&&[_apMaterno validate]&&[_usuario validate]&&[_correo validate]&&[_pass validate]&&[_pass2 validate]){
        
        if([_pass.text isEqualToString:_pass2.text]){
            
            NSString *UUID=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
            
            NSDictionary *params=@{@"funcion":@"RegistroUsuario",@"nombre":_nombre.text,@"apPaterno":_apPaterno.text,@"apMaterno":_apMaterno.text,@"email":_correo.text,@"usuario":_usuario.text,@"password":_pass.text,@"uuid":UUID,@"tokenDevice":UUID};
            
            NSDictionary *cipherParams=[Sesion generaPeticion:params];
            
            _conexion=[[NSConnection alloc] initWithRequestURL:[NSString stringWithFormat:@"%@%@",k_website,k_WS_Registro] parameters:cipherParams idRequest:1 delegate:self];
            [_conexion connectionPOSTExecuteUploadImage:_foto.image];
            
            _HUD=[[MBProgressHUD alloc] initWithView:self.view];
            [_HUD setMode:MBProgressHUDModeIndeterminate];
            [_HUD setLabelText:@"Enviando Datos"];
            [self.view addSubview:_HUD];
            [_HUD show:YES];

        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Las contraseña no coinciden verificalas por favor" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
            [alert show];
        }
        
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Todos los campos deben ser correctos verificalos por favor" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alert show];
    }

    
    
    
}

- (IBAction)Atras:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - NSconnection Delegate

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

                Usuario *nuevoUsuario=[NSEntityDescription insertNewObjectForEntityForName:@"Usuario" inManagedObjectContext:[NSCoreDataManager getManagedContext]];
                
                nuevoUsuario.nombre=_nombre.text;
                nuevoUsuario.apPaterno=_apPaterno.text;
                nuevoUsuario.apMaterno=_apMaterno.text;
                nuevoUsuario.usuario=_usuario.text;
                nuevoUsuario.correo=_correo.text;
                nuevoUsuario.foto=UIImagePNGRepresentation(_foto.image);
                nuevoUsuario.uuid=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
                nuevoUsuario.guid=[dicResponse objectForKey:@"guid"];
                
                if([NSCoreDataManager SaveData]){
                    [_HUD hide:YES];
                    [self performSegueWithIdentifier:@"verificacion_segue" sender:self];
                    
                }
            }else{
                [_HUD hide:YES];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:[NSString stringWithFormat:@"Error de comunicación code:%@",[dicResponse objectForKey:@"code"]] delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
                [alert show];
            }
        }
            break;
            
        default:
            break;
    }
    
}

-(void)connectionDidFail:(NSString *)error{
    NSLog(@"error %@",error);
    [_HUD hide:YES];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Error de conexion intente de nuevo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    [alert show];
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

#pragma mark - Fotografia
-(IBAction)SeleccinaFoto{
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Seleccionar Imagen" message:@"¿De dónde quieres obtener la foto?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Cámara",@"Galería de Fotos ", nil];
    [alert setTag:500];
    [alert show];
    alert=nil;
}
-(void)MuestraGaleria{
    
    if (_picker==nil) {
        _picker=[[UIImagePickerController alloc] init];
    }
    
    [_picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [_picker setDelegate:self];
    [self presentViewController:_picker animated:YES completion:nil];
    
}

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
    imagen=[self imageWithImage:imagen scaledToSize:CGSizeMake(150, 150)];
    _foto.image=imagen;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark - Delegate UIAlert

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==500) {
        
        switch (buttonIndex) {
            case 0:
            {
                NSLog(@"Cancelar");
            }break;
            case 1:
            {
                [self MuestraCamara];
            }break;
            case 2:
            {
                [self MuestraGaleria];
            }break;
                
            default:
                break;
        }
        
    }
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

#pragma mark Expreciones TextField
-(void)initTextfield{
    
    [_nombre addRegx:REGEX_NOMBRE withMsg:@"El nombre debe iniciar con mayúsculas"];
    [_nombre setPresentInView:self.view];
    [_apPaterno addRegx:REGEX_NOMBRE withMsg:@"El apellido paterno debe iniciar con mayúsculas"];
    [_apPaterno setPresentInView:self.view];
    [_apMaterno addRegx:REGEX_NOMBRE withMsg:@"El apellido materno debe iniciar con mayúsculas"];
    [_apMaterno setPresentInView:self.view];
    
    [_usuario addRegx:REGEX_USUARIO withMsg:@"El usuario no puede tener caracteres especiales"];
    [_usuario setPresentInView:self.view];
    
    [_correo addRegx:REGEX_EMAIL withMsg:@"El correo no es válido"];
    [_correo setPresentInView:self.view];
    
    [_pass addRegx:REGEX_PASS withMsg:@"El usuario debe tener por lo menos una mayúscula, una minúscula,un número y un caracter especial"];
    [_pass setPresentInView:self.view];
    
    [_pass2 addRegx:REGEX_PASS withMsg:@"El usuario debe tener por lo menos una mayúscula, una minúscula,un número y un caracter especial"];
    [_pass2 setPresentInView:self.view];
}
@end
