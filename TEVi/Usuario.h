//
//  Usuario.h
//  TEVi
//
//  Created by Angel  Solsona on 19/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Usuario : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * apPaterno;
@property (nonatomic, retain) NSString * apMaterno;
@property (nonatomic, retain) NSString * usuario;
@property (nonatomic, retain) NSString * correo;
@property (nonatomic, retain) NSString * pass;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSString * guid;
@property (nonatomic, retain) NSData * foto;
@property (nonatomic, retain) NSString * telefono;

@end
