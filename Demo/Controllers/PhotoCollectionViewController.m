//
//  PhotoCollectionViewController.m
//  Demo
//
//  Created by Rodrigo on 08/10/13.
//  Copyright (c) 2013 fctw. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"

static const NSString* kCellIdentifier = @"PhotoCellIdentifier";

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

#pragma mark - UICollectionViewDataSource



@end
