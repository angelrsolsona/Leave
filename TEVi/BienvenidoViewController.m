//
//  BienvenidoViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 16/09/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "BienvenidoViewController.h"

@implementation BienvenidoViewController


-(void)viewDidLoad{
    
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

- (IBAction)Siguiente:(id)sender {
    
    [self performSegueWithIdentifier:@"identificacion_segue" sender:self];
}
@end
