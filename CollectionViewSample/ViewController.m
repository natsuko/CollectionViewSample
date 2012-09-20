//
//  ViewController.m
//  CollectionViewSample
//
//  Created by Natsuko Nishikata on 2012/09/17.
//  Copyright (c) 2012年 Natsuko Nishikata. All rights reserved.
//

#import "ViewController.h"
#import "CollectionCell.h"
#import "HeaderView.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *photos;
@end

@implementation ViewController

- (void)loadTestPhotos {
    
    NSMutableArray *parisPhotos = [NSMutableArray array];
    for (int i = 1; i <= 8; i++) {
        NSString *filename = [NSString stringWithFormat:@"p%d.jpg", i];
        [parisPhotos addObject:[UIImage imageNamed:filename]];
    }
    NSMutableArray *msmPhotos = [NSMutableArray array];
    for (int i = 1; i <= 11; i++) {
        NSString *filename = [NSString stringWithFormat:@"m%d.jpg", i];
        [msmPhotos addObject:[UIImage imageNamed:filename]];
    }
    self.photos = @[parisPhotos, msmPhotos];
    self.titles = @[@"Paris", @"Mont Saint-Michel"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // サンプルデータの読み込み
    [self loadTestPhotos];
    
    // contentViewにcellのクラスを登録
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"MY_CELL"];
    
    // contentViewにheaderのnibを登録
    UINib *headerNib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MY_HEADER"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.photos = nil;
    self.title = nil;
}

/*
 iOS 6.0以降では、shouldAutoRotateToInterfaceOrientation:はdeprecated.
 代わりにsupportedInterfaceOrientationsをオーバーライドする。
 デフォルト値）iPad: UIInterfaceOrientationMaskAll
             iPhone: UIInterfaceOrientationMaskAllButUpsideDown
 */
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - 
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.photos objectAtIndex:section] count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    /*
     コレクションビューのセルを生成。
     dequeueReusableCellWithReuseIdentifier:forIndexPath:は、再利用可能なセルがある場合はそのセルを、ない場合は新規にセルを生成して返す。
     新規セルはinitWithFrame:メソッドもしくはnibからの読み込みで生成される。
     再利用可能なセルがある場合、prepareForReuseが呼ばれる。
     
     注意：
     あらかじめ、registerClass:forCellWithReuseIdentifier:
     もしくは、registerNib:forCellWithReuseIdentifier:
     メソッドにてセルのクラスまたはnibファイルを登録しておく必要がある（viewDidLoad参照）。
     */
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    
    cell.imageView.image = [[self.photos objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.photos count];
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    /*
     コレクションビューのヘッダーを生成。
     dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:indexPathは、
     再利用可能なビューがある場合はそのビューを、ない場合は新規にビューを生成して返す。
     新規ビューはinitWithFrame:メソッドもしくはnibからの読み込みで生成される。
     再利用可能なビューがある場合、prepareForReuseが呼ばれる。
     
     注意：
     あらかじめ、registerClass:forSupplementaryViewOfKind:withReuseIdentifier:
     もしくは、registerNib:forSupplementaryViewOfKind:withReuseIdentifier:
     メソッドにてビューのクラスまたはnibファイルを登録しておく必要がある（viewDidLoad参照）。
     */
    HeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MY_HEADER" forIndexPath:indexPath];
    
    headerView.label.text = [self.titles objectAtIndex:indexPath.section];
    return headerView;
}

#pragma mark - 
#pragma mark UICollectionViewDelegateFlowLayout
/* 
 セルのサイズをアイテムごとに可変とするためのdelegateメソッド
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *image = [[self.photos objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    return CGSizeMake(image.size.width / 2, image.size.height / 2);
}

@end
