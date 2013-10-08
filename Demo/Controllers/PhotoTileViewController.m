//
//  PhotoTileViewController.m
//  Demo
//
//  Created by Rodrigo on 08/10/13.
//  Copyright (c) 2013 fctw. All rights reserved.
//

#import "PhotoTileViewController.h"
#import "UIImage+BinPacking.h"
#import "ALAssetRepresentation+Size.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation PhotoTileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:self.assets.count];
    
    for(ALAsset *asset in self.assets)
    {
        ALAssetRepresentation *representation = asset.defaultRepresentation;
        UIImageBinPackingItem *item = [UIImageBinPackingItem packingItemWithSize:representation.aspectRatioDimensions fetchImageBlock:^UIImage *{
            return representation.aspectRatioFullResolutionImage;
        }];
        
        [arr addObject:item];
    }

    __weak UIImageView *weakImageView = self.imageView;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *image = [UIImage imageWithSize:weakImageView.frame.size andImages:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakImageView.image = image;
        });
    });
}

@end
