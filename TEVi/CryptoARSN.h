//
//  CryptoARSN.h
//  BPM
//
//  Created by Angel  Solsona on 19/03/15.
//  Copyright (c) 2015 Angel  Solsona. All rights reserved.
//

#import <Foundation/Foundation.h>
/*#import "NSData+AES.h"
#import "NSString+AES.h"*/
//#import "JFAes256Codec.h"
#import "AESCrypt.h"
#import "JFBCrypt.h"
@interface CryptoARSN : NSObject

@property(strong,nonatomic)NSString *keySHA256;
@property(strong,nonatomic)NSString *key;

-(id)initCriptoARSN256;
-(id)initCriptoARSN256WithKey:(NSString *)key;
-(id)initCriptoARSNSHA256;
-(NSString *)EncriptARSN256:(NSString *)cadena;
-(NSString *)DesencriptARSN256:(NSString *)cadena;
//-(NSString *)DesencriptAESSHA256:(NSString *)cadena;

+(NSString *)CryptSha256:(NSString *)cadena;

+(NSString *)Bcrypt:(NSString *)pass costo:(NSInteger)n;


@end
