//
//  PhotoTileViewController.h
//  Demo
//
//  Created by Rodrigo on 08/10/13.
//  Copyright (c) 2013 fctw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTileViewController : UIViewController

@property (nonatomic, copy) NSArray *assets;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic) BOOL shouldHideStatusBar;

- (IBAction)didTapView:(id)sender;

@end
