//
//  InicioRegistroViewController.h
//  TEVi
//
//  Created by Angel  Solsona on 18/08/15.
//  Copyright (c) 2015 Kelevrads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SloganCollectionViewCell.h"
//#import "RNEncryptor.h"
#import "JFAes256Codec.h"
#import "AESCrypt.h"
@interface InicioRegistroViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *vistaScroll;

@property (weak, nonatomic) IBOutlet UICollectionView *vistaCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pager;

@property(strong,nonatomic) NSTimer *timer;

@end
