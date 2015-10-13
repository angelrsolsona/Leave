//
//  AltaTarjetaViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 21/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "AltaTarjetaViewController.h"

@interface AltaTarjetaViewController ()

@end

@implementation AltaTarjetaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [CardIOUtilities preload];
    _capturoFicha=NO;
}

-(void)viewWillAppear:(BOOL)animated{

    if(!_capturoFicha){
        CardIOPaymentViewController *cardIO=[[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
        [cardIO setHideCardIOLogo:YES];
        [self presentViewController:cardIO animated:YES completion:nil];
    }
    
}

-(IBAction)Escanea:(id)sender{
    _capturoFicha=NO;
    CardIOPaymentViewController *cardIO=[[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    [cardIO setHideCardIOLogo:YES];
    [self presentViewController:cardIO animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews
{
    [_vistaScroll setContentSize:CGSizeMake(320,850)];
    //[_containerView setFrame:CGRectMake(0, 100, 320, 228)];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SeleccionaColor:(UIButton *)sender {
    _tarjetaActual.idFondoFicha=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    [_fondoTarjeta setImage:[UIImage imageNamed:[NSString stringWithFormat:@"FondoTarjeta%ld",(long)sender.tag]]];
    
}

- (IBAction)Siguiente:(id)sender {
    _tarjetaActual.nombreTitular=_nombreTitular.text;
    _tarjetaActual.tituloFicha=_tituloTarjeta.text;
    _tarjetaActual.nombreBanco=_nombreBanco.text;
    NSDictionary *dic=[TarjetasHelper GuardaFicha:_tarjetaActual];
    
    Tarjetas *tarjetas=[dic objectForKey:@"tarjetas"];
    
    BOOL exito=[NSCoreDataManager SaveData];
    if (exito) {
        if (_esAltaFicha) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            NSUserDefaults *datosAlm=[[NSUserDefaults alloc] init];
            [datosAlm setBool:YES forKey:@"login"];
            [datosAlm setBool:YES forKey:@"estaRegistrado"];
            [datosAlm synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        NSLog(@"Error al guardar ficha");
    }

    
}

#pragma mark - UITexfieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect rc=[textField bounds];
    rc=[textField convertRect:rc toView:_vistaScroll];
    CGPoint pt=rc.origin;
    pt.x=0;
    pt.y-=200;
    [_vistaScroll setContentOffset:pt animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [_vistaScroll setContentOffset:CGPointMake(0, 0)animated:YES];
    return YES;
}

#pragma mark - Delegate CardIO

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    NSLog(@"User canceled payment info");
    // Handle user cancellation here...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    // The full card number is available as info.cardNumber, but don't log that!
    NSLog(@"Received card info. Number: %@, expiry: %02i/%i, cvv: %@. tipo %@", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv,[CardIOCreditCardInfo displayStringForCardType:info.cardType usingLanguageOrLocale:@"es_MX"]);
    // Use the card info...
    
    _tarjetaActual=[[Tarjeta alloc] init];
    _tarjetaActual.noFicha=info.cardNumber;
    _tarjetaActual.vigencia=[NSString stringWithFormat:@"%02lu/%lu",(unsigned long)info.expiryMonth,(unsigned long)info.expiryYear];
    _tarjetaActual.cvv=info.cvv;
    NSString *afiliacion=[CardIOCreditCardInfo displayStringForCardType:info.cardType usingLanguageOrLocale:@"es_MX"];
    if([afiliacion isEqualToString:@"MasterCard"]){
         _tarjetaActual.afiliacionFichaID=@"2";
    }else if([afiliacion isEqualToString:@"Visa"]){
        _tarjetaActual.afiliacionFichaID=@"1";
    }
    _tarjetaActual.afiliacionFichaImagen=[CardIOCreditCardInfo logoForCardType:info.cardType];
    _tarjetaActual.fotoFicha=info.cardImage;
    _tarjetaActual.noFichaHidden=info.redactedCardNumber;
    [_tarjetaActual ObtenBin];
    _capturoFicha=YES;
    [scanViewController dismissViewControllerAnimated:YES completion:^{
        [self ActualizaDatosFicha:_tarjetaActual];
    }];
}

-(void)ActualizaDatosFicha:(Tarjeta *)ficha{
    
    [_numTarjeta setText:ficha.noFichaHidden];
    [_vigencia setText:ficha.vigencia];
    [_producto setImage:ficha.afiliacionFichaImagen];
    
    
    
}

-(void)InicializaTextField{
    
    [_tituloTarjeta setPresentInView:self.view];
    [_nombreBanco setPresentInView:self.view];
    [_nombreTitular setPresentInView:self.view];
}

-(IBAction)popVista{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}




@end
