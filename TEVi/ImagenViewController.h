//
//  ImagenViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 25/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSConnection.h"
#import "NSCoreDataManager.h"
#import "CryptoARSN.h"
#import "Usuario.h"

#import "PinViewController.h"
#import "TouchIDViewController.h"
#import "CodigoAlfanumericoViewController.h"
#import "PatronViewController.h"
#import "CodeColorViewController.h"

@interface ImagenViewController : UIViewController<NSConnectionDelegate>

@property(strong,nonatomic) NSMutableArray *arraySeleccionados;
@property(assign,nonatomic) NSInteger metodoConfigActual;
@property(assign,nonatomic) NSString *controladorSiguiente;

@property(strong,nonatomic) NSConnection *conexion;
@property(assign,nonatomic) NSInteger tagActual;

@property(strong,nonatomic) NSString *valorActual;

@property(strong,nonatomic)NSString *codigoActual;
@property(strong,nonatomic)NSString *tipoV;
@property(strong,nonatomic)NSString *valorCrypt;
@property(strong,nonatomic)KVNProgressConfiguration *KVN;
@property (weak, nonatomic) IBOutlet UIView *fondo;
@property (weak, nonatomic) IBOutlet UIButton *btnSiguiente;
@property (weak, nonatomic) IBOutlet UILabel *txtAviso;


- (IBAction)SeleccionaImagen:(UIButton *)sender;

- (IBAction)Siguiente:(id)sender;
@end
