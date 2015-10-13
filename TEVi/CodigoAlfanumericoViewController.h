//
//  CodigoAlfanumericoViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 31/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"
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
#import "CodeColorViewController.h"
@interface CodigoAlfanumericoViewController : UIViewController<NSConnectionDelegate>

@property(strong,nonatomic) NSMutableArray *arraySeleccionados;
@property(assign,nonatomic) NSInteger metodoConfigActual;
@property(assign,nonatomic) NSString *controladorSiguiente;

@property (weak,nonatomic) IBOutlet UIScrollView *vistaScroll;
@property (weak, nonatomic) IBOutlet TextFieldValidator *codigo1;
@property (weak, nonatomic) IBOutlet TextFieldValidator *codigo2;


@property(strong,nonatomic)NSString *codigoActual;
@property(strong,nonatomic)NSString *tipoV;
@property(strong,nonatomic)NSString *valorCrypt;
@property(strong,nonatomic)NSConnection *conexion;
@property(strong,nonatomic)KVNProgressConfiguration *KVN;

- (IBAction)Siguiente:(id)sender;
@end
