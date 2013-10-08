//
//  PhotoCollectionViewController.m
//  Demo
//
//  Created by Rodrigo on 08/10/13.
//  Copyright (c) 2013 fctw. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoTileViewController.h"

static NSString *const CellIdentifier = @"PhotoCellIdentifier";

#define kPhotosTableViewControllerMinimum 5
#define kPhotosTableViewControllerMaximum 25

@implementation PhotoCollectionViewController

#pragma mark - View

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.collectionView.allowsMultipleSelection = YES;
    
    self.library = [[ALAssetsLibrary alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(! self.items.count)
    {
        __weak PhotoCollectionViewController *weakSelf = self;
        
        [self.library cameraRollPhotosAssetsWithSuccess:^(NSArray *items) {
            weakSelf.items = items;
            [weakSelf.collectionView reloadData];
        } error:^(NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Dang!" message:@"Something went wrong with your pretty pics..." delegate:nil cancelButtonTitle:@"Fuck..." otherButtonTitles: nil];
            [alertView show];
        }];
    }
}

#pragma  mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"pushTileVC"])
    {
        NSArray *indexPaths = self.collectionView.indexPathsForSelectedItems;
        NSMutableArray *assets = [NSMutableArray arrayWithCapacity:indexPaths.count];
        
        [indexPaths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSIndexPath *indexPath = (NSIndexPath*) obj;
            [assets addObject:self.items[indexPath.row]];
        }];
        
        PhotoTileViewController *photoCollectionVC = (PhotoTileViewController *) segue.destinationViewController;
        photoCollectionVC.assets = assets;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ALAsset *asset = self.items[indexPath.row];
    
    cell.imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
    
    return cell;
}


@end
