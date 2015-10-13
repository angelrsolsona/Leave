//
//  MetodosSeguridadViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 21/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSCoreDataManager.h"
#import "Usuario.h"

#import "ImagenViewController.h"
#import "PinViewController.h"
#import "CodigoAlfanumericoViewController.h"
#import "TouchIDViewController.h"
#import "PatronViewController.h"
#import "CodeColorViewController.h"

@interface MetodosSeguridadViewController : UIViewController

@property(assign,nonatomic) NSInteger metodosSeleccionados;
@property(strong,nonatomic) NSMutableArray *arraySeleccionados;
@property(assign,nonatomic) NSInteger metodoConfigActual;

- (IBAction)SeleccionaMetodo:(UIButton *)sender;
- (IBAction)Siguiente:(id)sender;

@end
