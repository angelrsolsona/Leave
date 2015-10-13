//
//  PatronViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 25/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLockScreen.h"
#import "NormalCircle.h"
#import "DrawPatternLockView.h"

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
typedef enum {
    InfoStatusFirstTimeSetting = 0,
    InfoStatusConfirmSetting,
    InfoStatusFailedConfirm,
    InfoStatusNormal,
    InfoStatusFailedMatch,
    InfoStatusSuccessMatch
}	InfoStatus;

@interface PatronViewController : UIViewController <LockScreenDelegate,NSConnectionDelegate>{
    
    NSMutableArray* _paths;
    
    // after pattern is drawn, call this:
    id _target;
    SEL _action;
}

@property(strong,nonatomic) NSMutableArray *arraySeleccionados;
@property(assign,nonatomic) NSInteger metodoConfigActual;
@property(assign,nonatomic) NSString *controladorSiguiente;

//@property (strong, nonatomic) IBOutlet SPLockScreen *lockScreenView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *vistaScroll;
@property (nonatomic) InfoStatus infoLabelStatus;

@property (strong,nonatomic)UIView *vistaPatron2;

@property(strong,nonatomic)NSString *codigoActual;
@property(strong,nonatomic)NSString *tipoV;
@property(strong,nonatomic)NSString *valorCrypt;
@property(strong,nonatomic)NSConnection *conexion;
@property(strong,nonatomic)KVNProgressConfiguration *KVN;
@property (weak, nonatomic) IBOutlet UILabel *txtAviso;
@property (weak, nonatomic) IBOutlet UIButton *btnSiguiente;



- (IBAction)Siguiente:(id)sender;

- (NSString*)getKey;

- (void)setTarget:(id)target withAction:(SEL)action;
@end
