//
//  RestaurantesTableViewCell.h
//  TEVi
//
//  Created by Angel  Solsona on 09/10/15.
//  Copyright © 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nombreRestaurante;
@property (weak, nonatomic) IBOutlet UILabel *direccionRestaurante;
@property (weak, nonatomic) IBOutlet UIImageView *imagenRestaurante;

@end
