//
//  InicioViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 18/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PassbookCollectionViewCell.h"
#import "PassbookLayout.h"
#import "Tarjeta.h"
#import "TarjetasHelper.h"
#import "AltaTarjetaViewController.h"
@interface InicioViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *vistaScroll;
@property (weak,nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong,nonatomic) Tarjetas *tarjetaActual;
@property (strong,nonatomic) NSMutableArray *arrayTarjetas;
@property (strong,nonatomic) NSUserDefaults *datosAlm;
@property (strong,nonatomic) UIButton *btnPagar;

@end
