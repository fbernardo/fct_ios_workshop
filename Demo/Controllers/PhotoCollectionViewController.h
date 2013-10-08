//
//  PhotoCollectionViewController.h
//  Demo
//
//  Created by Rodrigo on 08/10/13.
//  Copyright (c) 2013 fctw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALAssetsLibrary+AssetsAccess.h"

@interface PhotoCollectionViewController : UICollectionViewController <UICollectionViewDataSource>

@property (nonatomic, strong) ALAssetsLibrary *library;
@property (nonatomic, copy) NSArray *items;

@end
