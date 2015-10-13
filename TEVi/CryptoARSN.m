//
//  CryptoARSN.m
//  BPM
//
//  Created by Angel  Solsona on 19/03/15.
//  Copyright (c) 2015 Angel  Solsona. All rights reserved.
//

#import "CryptoARSN.h"
#import <CommonCrypto/CommonDigest.h>
@implementation CryptoARSN

-(id)initCriptoARSNSHA256{
    
    if (self=[super init]) {
        
        NSString *key=@"AbcDefGhILmnoPQr";
        const char *str=[key UTF8String];
        unsigned char result[CC_SHA256_DIGEST_LENGTH];
        CC_SHA256(str, strlen(str), result);
        
        NSMutableString *ret=[NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
        for (int i=0;i<CC_SHA256_DIGEST_LENGTH; i++) {
            
            [ret appendFormat:@"%02x",result[i]];
        }
        _keySHA256=[ret substringWithRange:NSMakeRange(0, 16)];
        NSLog(@"llave %@",_keySHA256);
        
    }
    
    return self;
}
-(id)initCriptoARSN256{
    
    if (self=[super init]) {
        NSBundle *mainBundle=[NSBundle mainBundle];
        //NSString *string=[[mainBundle objectForInfoDictionaryKey:@"Tevi"] objectForKey:@"key"];
        _key=@"4D5phrNL?|?Jp2@Rhgu7Y1_aV+s8o~`)";
        /*const char *var=[string UTF8String];
        _key=[[NSString alloc] initWithBytes:var length:strlen(var) encoding:NSUTF8StringEncoding];
        NSLog(@"key %@",_key);*/
        
        
        
    }
    
    return self;
}

-(id)initCriptoARSN256WithKey:(NSString *)key{
    
    if (self=[super init]) {
        
        _key=key;
 
    }
    
    return self;
    
}

-(NSString *)EncriptARSN256:(NSString *)cadena{
    
    /*NSData *dataCadena=[cadena dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *datasinFormato=[JFAes256Codec encryptData:dataCadena withKey:@"X[oAsC-qFXy7;gk@daHn3.}?4dBg&3a,"];
    NSData *data64=[datasinFormato base64EncodedDataWithOptions:0];
    NSString *string2=[[NSString alloc] initWithData:data64 encoding:NSUTF8StringEncoding];
    //NSLog(@"\ncadena encriptada2 %@  ",string2);
    return string2;*/
    
    NSString *cadenaARSN=[AESCrypt encrypt:cadena password:_key];
    
    return cadenaARSN;
    
}
-(NSString *)DesencriptARSN256:(NSString *)cadena{
    
    NSString *cadenaARSN=[AESCrypt decrypt:cadena password:_key];
    
    return cadenaARSN;
    
}

+(NSString *)CryptSha256:(NSString *)cadena{
    
        //NSString *key=@"AbcDefGhILmnoPQr";
        NSString *key=cadena;
        const char *str=[key UTF8String];
        unsigned char result[CC_SHA256_DIGEST_LENGTH];
        CC_SHA256(str, strlen(str), result);
        
        NSMutableString *ret=[NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
        for (int i=0;i<CC_SHA256_DIGEST_LENGTH; i++) {
            
            [ret appendFormat:@"%02x",result[i]];
        }
    NSString *keySHA256=[NSString stringWithFormat:@"%@",ret];
        NSLog(@"llave %@",keySHA256);
        
    return keySHA256;
    
}

+(NSString *)Bcrypt:(NSString *)pass costo:(NSInteger)n{
    
    NSString *salt=[JFBCrypt generateSaltWithNumberOfRounds:n];
    NSString *hash=[JFBCrypt hashPassword:pass withSalt:salt];
    
    return hash;
    
}



@end
