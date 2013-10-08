//
//  ALAssetRepresentation+Size.h
//  FCT1
//
//  Created by Fábio Bernardo on 22/09/13.
//  Copyright (c) 2013 Fábio Bernardo. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAssetRepresentation (Size)
- (CGSize)aspectRatioDimensions;
- (UIImage *)aspectRatioFullResolutionImage;
@end
