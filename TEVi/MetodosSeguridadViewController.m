//
//  MetodosSeguridadViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 21/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "MetodosSeguridadViewController.h"

@interface MetodosSeguridadViewController ()

@end

@implementation MetodosSeguridadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arraySeleccionados=[[NSMutableArray alloc] init];
    _metodosSeleccionados=0;
    NSArray *array=[NSCoreDataManager getDataWithEntity:@"Usuario" andManagedObjContext:[NSCoreDataManager getManagedContext]];
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
    
    _metodoConfigActual=0;
    
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
    
    if ([segue.identifier isEqualToString:@"color_segue"]) {
        
        CodeColorViewController *VC=[segue destinationViewController];
        VC.metodoConfigActual=_metodoConfigActual;
        VC.arraySeleccionados=_arraySeleccionados;
        
    }
    
}

- (IBAction)SeleccionaMetodo:(UIButton *)sender {
    
    NSNumber *number=[NSNumber numberWithInt:sender.tag];
    
    if([_arraySeleccionados containsObject:number]){
        [_arraySeleccionados removeObject:number];
        [sender setBackgroundImage:[UIImage imageNamed:@"CampoGrisSinPaloma"] forState:UIControlStateNormal];
        _metodosSeleccionados--;
    }else{
        if(_metodosSeleccionados<3){
            _metodosSeleccionados++;
            [sender setBackgroundImage:[UIImage imageNamed:@"CampoGrisConPaloma"] forState:UIControlStateNormal];
            [_arraySeleccionados addObject:number];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Sólo puedes elegir 3 metodos de seguridad " delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
            [alert show];
        }
    }
    
    
}

- (IBAction)Siguiente:(id)sender {
    
    NSArray *array=[[NSArray alloc] initWithArray:_arraySeleccionados];
    _arraySeleccionados=[[NSMutableArray alloc] init];

    for(NSNumber *numero in array){
        NSString *nombreVista;
        switch([numero intValue]){
            
            case 1:
            {
                nombreVista=@"imagen_segue";
            }break;
            case 2:
            {
                nombreVista=@"pin_segue";
            }break;
            case 3:
            {
                nombreVista=@"touchid_segue";
            }break;
            case 4:
            {
                nombreVista=@"codigo_segue";
            }break;
            case 5:
            {
                nombreVista=@"patron_segue";
            }break;
            case 6:
            {
                nombreVista=@"color_segue";
            }
        }
        
        [_arraySeleccionados addObject:nombreVista];
    }
    
    NSString *primerVista=[_arraySeleccionados objectAtIndex:0];
    [self performSegueWithIdentifier:primerVista sender:self];
}



@end
