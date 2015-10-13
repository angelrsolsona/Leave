//
//  ListaRestaurantesViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 09/10/15.
//  Copyright © 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSConnection.h"
#import "MBProgressHUD.h"
#import "Sesion.h"
#import "Comunes.h"
#import "Restaurantes.h"
@interface ListaRestaurantesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSConnectionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tablaRestaurantes;

@property(strong,nonatomic)NSMutableArray *arrayRestaurantes;
@property(strong,nonatomic)NSConnection *conexion;
@property(strong,nonatomic)MBProgressHUD *HUD;
@property(strong,nonatomic)Restaurantes *retauranteActual;

@end
