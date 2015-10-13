//
//  RegistroViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 18/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSConnection.h"
#import "Comunes.h"
#import "CryptoARSN.h"
#import "JFBCrypt.h"
#import "Usuario.h"
#import "NSCoreDataManager.h"
#import "MBProgressHUD.h"
#import "Sesion.h"
#import "TextFieldValidator.h"
@interface RegistroViewController : UIViewController <NSConnectionDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet TextFieldValidator *nombre;
@property (weak, nonatomic) IBOutlet TextFieldValidator *apPaterno;
@property (weak, nonatomic) IBOutlet TextFieldValidator *apMaterno;
@property (weak, nonatomic) IBOutlet TextFieldValidator *usuario;
@property (weak, nonatomic) IBOutlet TextFieldValidator *correo;
@property (weak, nonatomic) IBOutlet TextFieldValidator *pass;
@property (weak, nonatomic) IBOutlet TextFieldValidator *pass2;
@property (weak, nonatomic) IBOutlet UIScrollView *vistaScroll;
@property (weak, nonatomic) IBOutlet UIImageView *foto;

@property(strong,nonatomic)NSConnection *conexion;
@property(strong,nonatomic) UIImagePickerController *picker;
@property(strong,nonatomic)MBProgressHUD *HUD;

- (IBAction)Siguiente:(id)sender;
- (IBAction)Atras:(id)sender;
@end
