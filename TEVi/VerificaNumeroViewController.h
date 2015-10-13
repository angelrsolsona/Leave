//
//  VerificaNumeroViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 19/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comunes.h"
#import "NSConnection.h"
#import "MBProgressHUD.h"
#import "CryptoARSN.h"
#import "Usuario.h"
#import "VerificaCodigoViewController.h"
#import "Sesion.h"
@interface VerificaNumeroViewController : UIViewController <NSConnectionDelegate>

@property (weak, nonatomic) IBOutlet UITextField *telefono;
@property (weak, nonatomic) IBOutlet UIScrollView *vistaScroll;

@property(strong,nonatomic) NSConnection *conexion;
@property(strong,nonatomic) MBProgressHUD *HUD;
@property(strong,nonatomic) NSString *telefonoActual;

- (IBAction)Siguiente:(id)sender;
@end
