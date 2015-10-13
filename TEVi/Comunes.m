//
//  Comunes.m
//  TEVi
//
//  Created by Angel  Solsona on 18/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "Comunes.h"

NSString *const k_website=@"http://puga.bosc.com.mx/api_tevi/";
NSString *const k_websiteLEAVE=@"http://puga.bosc.com.mx/api_leave/";
NSString *const k_WS_Registro=@"registro";
NSString *const k_WS_Restaurantes=@"obtencionRestaurante";


NSString *const REGEX_BASICO=@"^.{1,20}$";
NSString *const REGEX_EMAIL=@"[A-Z0-9a-z\\.-]{6,30}@[A-Z0-9a-z]{2,14}\\.[A-Za-z]{2,4}(\\.[A-Za-z]{2,4})?";
NSString *const REGEX_PHONE_DEFAULT=@"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}";
NSString *const REGEX_PASS=@"(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9])[^ ]{8,25}";
NSString *const REGEX_NOMBRE=@"[A-ZÑÁÉÍÓÚÄËÏÖÜÂÊÎÔÛÀÈÌÒÙÂÊÎÔÛ][\\p{L} ]{1,19}";
NSString *const REGEX_USUARIO=@"[A-Za-z0-9-\\.]{6,30}";
NSString *const REGEX_FOLIO=@"[A-Za-z0-9]{13}";