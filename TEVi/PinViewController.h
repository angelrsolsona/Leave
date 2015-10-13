//
//  PinViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 27/08/15.
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

#import "CodigoAlfanumericoViewController.h"
#import "ImagenViewController.h"
#import "TouchIDViewController.h"
#import "CodeColorViewController.h"
#import "PatronViewController.h"
@interface PinViewController : UIViewController <NSConnectionDelegate,UIAlertViewDelegate>

@property(strong,nonatomic) NSMutableArray *arraySeleccionados;
@property(assign,nonatomic) NSInteger metodoConfigActual;
@property(assign,nonatomic) NSString *controladorSiguiente;


@property (weak, nonatomic) IBOutlet UITextField *codigo;
@property (weak, nonatomic) IBOutlet UIScrollView *vistaScroll;
@property (weak, nonatomic) IBOutlet UILabel *txtAviso;
@property (weak, nonatomic) IBOutlet UIButton *btnSiguiente;
@property (weak, nonatomic) IBOutlet UIImageView *lineaShake;

@property(assign,nonatomic)NSInteger *caracteresActuales;
@property(strong,nonatomic)NSString *codigoActual;
@property(strong,nonatomic)NSString *tipoV;
@property(strong,nonatomic)NSString *valorCrypt;
@property(strong,nonatomic)NSConnection *conexion;
@property(strong,nonatomic)KVNProgressConfiguration *KVN;


- (IBAction)Teclado:(UIButton *)sender;
- (IBAction)Borrar:(id)sender;
- (IBAction)Siguiente:(id)sender;


@end
