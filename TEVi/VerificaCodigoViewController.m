//
//  VerificaCodigoViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 20/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "VerificaCodigoViewController.h"

@interface VerificaCodigoViewController ()

@end

@implementation VerificaCodigoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _caracteresActuales=0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Teclado:(UIButton *)sender {
    
    if(sender.tag==10){
        
        _codigo.text=[_codigo.text stringByAppendingString:@"0"];
    }else{
        _codigo.text=[_codigo.text stringByAppendingString:[NSString stringWithFormat:@"%d",sender.tag]];
    }
}

- (IBAction)Borrar:(id)sender {
    
    if ([_codigo.text length] > 0) {
        NSString *string = [_codigo.text substringToIndex:[_codigo.text length] - 1];
        _codigo.text=string;
        NSLog(@"string %@",string);
    } else {
        //no characters to delete... attempting to do so will result in a crash
    }
}

- (IBAction)Siguiente:(id)sender {
    
    if (![_codigo.text isEqualToString:@""]) {
        
        NSArray *array=[NSCoreDataManager getDataWithEntity:@"Usuario" andManagedObjContext:[NSCoreDataManager getManagedContext]];
        if([array count]>0){
          _usuarioActual=[array objectAtIndex:0];
            NSDictionary *params=@{@"funcion":@"VerificaCodigo",
                                   @"telefono":_telefonoActual,
                                   @"codigo":_codigo.text,
                                   @"guid":_usuarioActual.guid
                                   };
            
        NSDictionary *cipherParams=[Sesion generaPeticion:params];
            
            _conexion=[[NSConnection alloc] initWithRequestURL:[NSString stringWithFormat:@"%@%@",k_website,k_WS_Registro] parameters:cipherParams        idRequest:1 delegate:self];
            [_conexion connectionPOSTExecute];
            
            _HUD=[[MBProgressHUD alloc] initWithView:self.view];
            [_HUD setMode:MBProgressHUDModeIndeterminate];
            [_HUD setLabelText:@"Enviando Datos"];
            [self.view addSubview:_HUD];
            [_HUD show:YES];

        }
        
        
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Debes ingresar un número telefónico" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
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
            
            if([[dic objectForKey:@"exito"] boolValue]){
                
                CryptoARSN *decifrada=[[CryptoARSN alloc] initCriptoARSN256];
                NSString *jsonResponse=[decifrada DesencriptARSN256:[dic objectForKey:@"parametros"]];
                
                NSDictionary *dicResponse=[NSJSONSerialization JSONObjectWithData:[jsonResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
                
                if ([[dicResponse objectForKey:@"code"] isEqualToString:@"000006"]) {
                    [self performSegueWithIdentifier:@"metodos_segue" sender:self];
                    
                }else if([[dicResponse objectForKey:@"code"] isEqualToString:@"000021"]){
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"El código es incorrecto verifiquelo por favor"delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
                    [alert setTag:1];
                    [alert show];
                    [_HUD hide:YES];
                }else if([[dicResponse objectForKey:@"code"] isEqualToString:@"000022"]){
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"El código ha expirado"delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
                    [alert setTag:1];
                    [alert show];
                    [_HUD hide:YES];
                }if([[dicResponse objectForKey:@"code"] isEqualToString:@"000023"]){
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"El usuario no existe"delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
                    [alert setTag:1];
                    [alert show];
                    [_HUD hide:YES];
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
    [_HUD hide:YES];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Error de conexion intente de nuevo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    [alert show];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
}

@end
