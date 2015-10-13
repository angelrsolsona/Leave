//
//  UsuarioHelper.m
//  TEVi
//
//  Created by Angel  Solsona on 10/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "UsuarioHelper.h"

@implementation UsuarioHelper

-(id)init{
    if(self==[super init]){
        
        NSArray *array=[NSCoreDataManager getDataWithEntity:@"Usuario" andManagedObjContext:[NSCoreDataManager getManagedContext]];
        if([array count]>0){
            _usuario=[array objectAtIndex:0];
        }
    }
    return self;
}
@end
