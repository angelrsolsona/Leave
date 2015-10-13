//
//  UsuarioHelper.h
//  TEVi
//
//  Created by Angel  Solsona on 10/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSCoreDataManager.h"
#import "Usuario.h"
@interface UsuarioHelper : NSObject

@property(strong,nonatomic)Usuario *usuario;

-(id)init;

@end
