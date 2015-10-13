//
//  InicioViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 18/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "InicioViewController.h"

@interface InicioViewController ()

@end

@implementation InicioViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_collectionView registerNib:[UINib nibWithNibName:@"PassbookCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    [_collectionView setCollectionViewLayout:[[PassbookLayout alloc] initWithWidth:320 Height:200]];
    _btnPagar=[[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width/2)-120,self.view.bounds.size.height-150,250,40)];
    [_btnPagar setBackgroundImage:[UIImage imageNamed:@"BotonPagoBlanco"] forState:UIControlStateNormal];
    //[_btnPagar setTintColor:[UIColor blackColor]];
    //[_btnPagar setTitle:@"Paga" forState:UIControlStateNormal];
    [_btnPagar addTarget:self action:@selector(Pagar) forControlEvents:UIControlEventTouchUpInside];
    [_btnPagar setHidden:YES];
    [self.view addSubview:_btnPagar];
    _arrayTarjetas=[[NSMutableArray alloc] init];
    
}

-(void)viewWillAppear:(BOOL)animated{
    _datosAlm=[NSUserDefaults standardUserDefaults];
    _arrayTarjetas=[TarjetasHelper ObtenTarjetas];
    BOOL login=[[_datosAlm objectForKey:@"login"] boolValue];
    if (login) {
        // Ya esta logueado
        _arrayTarjetas=[TarjetasHelper ObtenTarjetas];
        
        
    }else{
        BOOL estaRegistrado=[[_datosAlm objectForKey:@"estaRegistrado"] boolValue];
        if (estaRegistrado) {
            // Enviar a login ya tiene cuenta
        }else{
            // Enviar a login y registro
            [self performSegueWithIdentifier:@"inicioregistro_segue" sender:self];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"altaFicha"]) {
        
        AltaTarjetaViewController *VC=[segue destinationViewController];
        [VC setEsAltaFicha:YES];
    }
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return [_arrayTarjetas count];
    //return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PassbookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //[cell.imagenFondo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"FondoTarjeta%d",(indexPath.row+1)]]];
    Tarjeta *tarjeta=[_arrayTarjetas objectAtIndex:indexPath.row];
    [cell.imagenFondo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"FondoTarjeta%@",tarjeta.idFondoFicha]]];
    cell.noTarjeta.text=tarjeta.noFichaHidden;
    cell.fechaValido.text=tarjeta.vigencia;
    cell.banco.text=tarjeta.nombreBanco;
    cell.alias.text=tarjeta.tituloFicha;
    cell.nombreTitular.text=tarjeta.nombreTitular;
    cell.afiliacionImagen.image=tarjeta.afiliacionFichaImagen;
    /*[cell.noTarjeta setText:tarjeta.numTarjeta];
     [cell.fechaValido setText:tarjeta.fechaVencimiento];
     if (tarjeta.imagenFondo!=Nil) {
     [cell.imagenFondo setImage:[UIImage imageNamed:tarjeta.imagenFondo]];
     
     }*/
    
    // Configure the cell
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Alternates selection. Deselects all selected cells, and if there's none, it just accepts the selection
    BOOL shouldSelect = YES;
    
    for (NSIndexPath *indexPath in [collectionView indexPathsForSelectedItems])
    {
        // Freaking collection views, you need to tell it that the thing got deselected
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
        shouldSelect = NO;
    }
    
    return shouldSelect;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView performBatchUpdates:nil completion:nil];
    [collectionView setScrollEnabled:YES];
    _tarjetaActual=Nil;
    [_btnPagar setHidden:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView performBatchUpdates:nil completion:^(BOOL finished) {
        [_btnPagar setHidden:NO];
    }];
    [collectionView setScrollEnabled:NO];
    //_tarjetaActual=[_arrayTarjetas objectAtIndex:indexPath.row];
    
}


#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

-(void)Pagar{
    NSLog(@"Pagar");
}

@end
