//
//  VerificaCodigoViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 20/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSConnection.h"
#import "Usuario.h"
#import "NSCoreDataManager.h"
#import "CryptoARSN.h"
#import "MBProgressHUD.h"
#import "Comunes.h"
#import "Sesion.h"
@interface VerificaCodigoViewController : UIViewController <NSConnectionDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *codigo;
@property (weak, nonatomic) IBOutlet UIScrollView *vistaScroll;

@property(assign,nonatomic)NSInteger *caracteresActuales;
@property(assign,nonatomic)NSString *telefonoActual;
@property(strong,nonatomic)NSConnection *conexion;
@property(strong,nonatomic)MBProgressHUD *HUD;
@property(strong,nonatomic)Usuario *usuarioActual;

- (IBAction)Teclado:(UIButton *)sender;
- (IBAction)Borrar:(id)sender;
- (IBAction)Siguiente:(id)sender;

@end
