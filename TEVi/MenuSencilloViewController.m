//
//  MenuSencilloViewController.m
//  Sorprais
//
//  Created by Angel  Solsona on 26/11/14.
//  Copyright (c) 2014 Angel  Solsona. All rights reserved.
//

#import "MenuSencilloViewController.h"

@interface MenuSencilloViewController ()

@end

@implementation MenuSencilloViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(IBAction)Inicio:(id)sender{
    NavigationViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    InicioViewController *IVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InicioController"];
    navigationController.viewControllers = @[IVC];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    IVC=nil;
    navigationController=nil;
}*/




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*-(void)Perfil:(UIGestureRecognizer *)gesture{
    NavigationViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    PerfilViewController *PVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InicioController"];
    navigationController.viewControllers = @[PVC];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    PVC=nil;
    navigationController=nil;

}

-(IBAction)Avisos:(id)sender{
    
     NavigationViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
     AvisosTableViewController *ATVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AvisosTableController"];
     navigationController.viewControllers = @[ATVC];
     self.frostedViewController.contentViewController = navigationController;
     [self.frostedViewController hideMenuViewController];
    navigationController=nil;
    ATVC=nil;

    
}
-(IBAction)Castings:(id)sender{
    
    NavigationViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    CastingsTableViewController *CaTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CastingTableController"];
    navigationController.viewControllers = @[CaTVC];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    navigationController=nil;
    CaTVC=nil;

    
}
-(IBAction)CheckIn:(id)sender{
    
    NavigationViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    CheckInTableViewController *CTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckInTableController"];
    navigationController.viewControllers = @[CTVC];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    navigationController=nil;
    CTVC=nil;
    
}

-(IBAction)CerrarSesion:(id)sender{
    
    [_managedObject deleteObject:_usuarioActual];
    NSError *deleteError=nil;
    [_managedObject save:&deleteError];
    NSUserDefaults *datosAlm=[NSUserDefaults standardUserDefaults];
    [datosAlm setBool:NO forKey:@"login"];
    [datosAlm synchronize];
    
    NavigationViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    PerfilViewController *PVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InicioController"];
    navigationController.viewControllers = @[PVC];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    navigationController=nil;
    PVC=nil;
}*/

@end
