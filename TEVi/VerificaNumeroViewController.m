//
//  VerificaNumeroViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 19/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "VerificaNumeroViewController.h"

@interface VerificaNumeroViewController ()

@end

@implementation VerificaNumeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    if ([segue.identifier isEqualToString:@"verificacodigo_segue"]) {
        VerificaCodigoViewController *VC=[segue destinationViewController];
        VC.telefonoActual=_telefonoActual;
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


- (IBAction)Siguiente:(id)sender {
    
    if (![_telefono.text isEqualToString:@""]) {
        
        NSDictionary *params=@{@"funcion":@"GeneraCodigoVerificacionTelefono",
                    @"telefono":_telefono.text
                    };
        
        NSDictionary *cipherParams=[Sesion generaPeticion:params];
        NSLog(@"peticion %@",cipherParams);
        _conexion=[[NSConnection alloc] initWithRequestURL:[NSString stringWithFormat:@"%@%@",k_website,k_WS_Registro] parameters:cipherParams idRequest:1 delegate:self];
        [_conexion connectionPOSTExecute];
        
        _HUD=[[MBProgressHUD alloc] initWithView:self.view];
        [_HUD setMode:MBProgressHUDModeIndeterminate];
        [_HUD setLabelText:@"Enviando Datos"];
        [self.view addSubview:_HUD];
        [_HUD show:YES];
        
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
            if ([dic objectForKey:@"exito"]) {
                
                _telefonoActual=_telefono.text;
                [self performSegueWithIdentifier:@"verificacodigo_segue" sender:self];
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
@end
