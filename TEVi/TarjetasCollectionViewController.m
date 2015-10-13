//
//  TarjetasCollectionViewController.m
//  BPM
//
//  Created by Angel  Solsona on 18/05/15.
//  Copyright (c) 2015 Angel  Solsona. All rights reserved.
//

#import "TarjetasCollectionViewController.h"

@interface TarjetasCollectionViewController ()

@end

@implementation TarjetasCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PassbookCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
    _appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    _managedObject=[_appDelegate managedObjectContext];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    ///self.collectionView.collectionViewLayout=[[PassbookLayout alloc] initWithWidth:375 Height:200]; Medidas para iphone 6
    self.collectionView.collectionViewLayout=[[PassbookLayout alloc] initWithWidth:320 Height:200]; //Medidas para iphone 5
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    _tarjetaActual=nil;
    [self.navigationController setNavigationBarHidden:NO];
    _arrayTarjetas=[[NSMutableArray alloc] initWithArray:[NSCoreDataManager getDataWithEntity:@"Tarjetas" andManagedObjContext:_managedObject]];
    [self.collectionView reloadData];
    
    if (_esPago) {
        
        [_btnAccion setTitle:@"Siguiente"];
    }else{
        [_btnAccion setTitle:@"Nueva"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Avanza:(id)sender{
    
   
        if (_esPago) {
             if (_tarjetaActual!=Nil) {
                [self performSegueWithIdentifier:@"dispositivos_segue" sender:self];
             }else{
                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Debes elegir una tarjeta" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
                 [alert show];
             }
        }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return [_arrayTarjetas count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PassbookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Tarjetas *tarjeta=[_arrayTarjetas objectAtIndex:indexPath.row];

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
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView performBatchUpdates:nil completion:nil];
    [collectionView setScrollEnabled:NO];
    _tarjetaActual=[_arrayTarjetas objectAtIndex:indexPath.row];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

@end
