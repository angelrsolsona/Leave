//
//  PassbookCollectionViewCell.h
//  BPM
//
//  Created by Angel  Solsona on 18/05/15.
//  Copyright (c) 2015 Angel  Solsona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassbookCollectionViewCell : UICollectionViewCell

@property(weak,nonatomic)IBOutlet UILabel *noTarjeta;
@property(weak,nonatomic)IBOutlet UILabel *fechaValido;
@property(weak,nonatomic)IBOutlet UIImageView *imagenFondo;
@property (weak, nonatomic) IBOutlet UILabel *banco;
@property (weak, nonatomic) IBOutlet UILabel *alias;
@property (weak, nonatomic) IBOutlet UIImageView *afiliacionImagen;
@property (weak, nonatomic) IBOutlet UILabel *nombreTitular;

@end
