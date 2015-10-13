//
//  TarjetasCollectionViewController.h
//  BPM
//
//  Created by Angel  Solsona on 18/05/15.
//  Copyright (c) 2015 Angel  Solsona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassbookCollectionViewCell.h"
#import "AppDelegate.h"
#import "NSCoreDataManager.h"
#import "Tarjetas.h"
#import "PassbookLayout.h"
@interface TarjetasCollectionViewController : UICollectionViewController

@property(strong,nonatomic) AppDelegate *appDelegate;
@property(strong,nonatomic) NSManagedObjectContext *managedObject;
@property(strong,nonatomic) NSMutableArray *arrayTarjetas;
@property(assign,nonatomic) BOOL esPago;
@property(strong,nonatomic) Tarjetas *tarjetaActual;
@property(weak,nonatomic) IBOutlet UIBarButtonItem *btnAccion;

@end
