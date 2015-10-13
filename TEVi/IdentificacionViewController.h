//
//  IdentificacionViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 16/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sesion.h"
#import "NSConnection.h"
#import "UsuarioHelper.h"
#import "Comunes.h"
#import "TextFieldValidator.h"
#import <KVNProgress/KVNProgress.h>


@interface IdentificacionViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,NSConnectionDelegate>



@property (weak, nonatomic) IBOutlet UIButton *btnSiguiente;
@property (weak, nonatomic) IBOutlet UIScrollView *vistaScroll;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipoIdentificacion;
@property (weak, nonatomic) IBOutlet TextFieldValidator *folio;

@property(strong,nonatomic) UIImagePickerController *picker;
@property(strong,nonatomic) UIImage *foto;
@property(assign,nonatomic) BOOL adjuntoFoto;
@property(strong,nonatomic) NSString *StipoIdentificacion;
@property(strong,nonatomic)KVNProgressConfiguration *KVN;
@property(strong,nonatomic)NSString *valorCrypt;
@property(strong,nonatomic)NSConnection *conexion;

- (IBAction)SubirFoto:(id)sender;
-(IBAction)Siguiente:(id)sender;
- (IBAction)CambiaTipo:(id)sender;

@end
