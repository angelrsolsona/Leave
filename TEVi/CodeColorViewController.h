//
//  CodeColorViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 07/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSConnection.h"
#import "UsuarioHelper.h"
#import "HelperValidacion.h"
#import "Sesion.h"
#import "Comunes.h"
#import "Validaciones.h"
#import <KVNProgress/KVNProgress.h>

#import "ImagenViewController.h"
#import "PinViewController.h"
#import "CodigoAlfanumericoViewController.h"
#import "TouchIDViewController.h"
#import "PatronViewController.h"

@interface CodeColorViewController : UIViewController <NSConnectionDelegate>

@property(strong,nonatomic) NSMutableArray *arraySeleccionados;
@property(assign,nonatomic) NSInteger metodoConfigActual;
@property(assign,nonatomic) NSString *controladorSiguiente;

@property (weak, nonatomic) IBOutlet UIButton *btnSiguiente;
@property (weak, nonatomic) IBOutlet UILabel *txtAviso;
@property (weak, nonatomic) IBOutlet UIView *fondo;

@property(strong,nonatomic)NSString *codigoActual;
@property(strong,nonatomic)NSString *tipoV;
@property(strong,nonatomic)NSString *valorCrypt;
@property(strong,nonatomic)NSConnection *conexion;
@property(strong,nonatomic)KVNProgressConfiguration *KVN;

@property(strong,nonatomic)NSMutableArray *arraySeleccion;

- (IBAction)PrecionaBoton:(UIButton *)sender;

- (IBAction)Siguiente:(id)sender;
@end
