//
//  AltaTarjetaViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 21/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardIO.h"
#import "Tarjeta.h"
#import "Tarjetas.h"
#import "TarjetasHelper.h"
#import "NSCoreDataManager.h"
#import "TextFieldValidator.h"
@interface AltaTarjetaViewController : UIViewController<UITextFieldDelegate,CardIOPaymentViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UILabel *scrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *vistaScroll;
@property (weak, nonatomic) IBOutlet UILabel *numTarjeta;
@property (weak, nonatomic) IBOutlet UITextField *tipoTarjeta;
@property (weak, nonatomic) IBOutlet UIImageView *producto;
@property (weak, nonatomic) IBOutlet UILabel *vigencia;
@property (weak, nonatomic) IBOutlet TextFieldValidator *tituloTarjeta;
@property (weak, nonatomic) IBOutlet TextFieldValidator *nombreTitular;
@property (weak, nonatomic) IBOutlet TextFieldValidator *nombreBanco;
@property (weak, nonatomic) IBOutlet UIImageView *fondoTarjeta;

@property (strong,nonatomic)Tarjeta *tarjetaActual;
@property (assign,nonatomic)BOOL capturoFicha;
@property (assign,nonatomic)BOOL esAltaFicha;

- (IBAction)SeleccionaColor:(id)sender;
- (IBAction)Siguiente:(id)sender;

@end
