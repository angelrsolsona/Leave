//
//  InicioRegistroViewController.m
//  TEVi
//
//  Created by Angel  Solsona on 18/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import "InicioRegistroViewController.h"

@interface InicioRegistroViewController ()

@end

@implementation InicioRegistroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    NSDictionary *dic=[[NSBundle mainBundle] infoDictionary];
    NSLog(@"dic %@ ",[dic description]);
    
    NSBundle *mainBundle=[NSBundle mainBundle];
    
    NSLog(@"apikey= %@",[mainBundle objectForInfoDictionaryKey:@"APIKEYTEVi"]);
    
}

-(void)viewWillAppear:(BOOL)animated{
    _timer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(CambiaSlogan) userInfo:nil repeats:YES];
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
    [_timer invalidate];
    _timer=nil;
    
}


#pragma mark - Delegate Collection View

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SloganCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Celda" forIndexPath:indexPath];
    UIImage *imgSlogan=[UIImage imageNamed:[NSString stringWithFormat:@"Slogan%d",indexPath.row+1]];
    
    cell.slogan.image=imgSlogan;
    
    return cell;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point=[_vistaCollectionView contentOffset];
    [_pager setCurrentPage:point.x/_vistaCollectionView.frame.size.width];
}

-(void)CambiaSlogan{
    NSInteger actual=_pager.currentPage;
    NSArray *arrayVisibles=[_vistaCollectionView indexPathsForVisibleItems];
    NSIndexPath *currentItem=[arrayVisibles objectAtIndex:0];
    
    if(actual==2){
        [_pager setCurrentPage:0];
        NSIndexPath *nextItem=[NSIndexPath indexPathForItem:0 inSection:currentItem.section];
        [_vistaCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }else{
        actual++;
        [_pager setCurrentPage:actual];
         NSIndexPath *nextItem=[NSIndexPath indexPathForItem:actual inSection:currentItem.section];
        [_vistaCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    
}

@end
