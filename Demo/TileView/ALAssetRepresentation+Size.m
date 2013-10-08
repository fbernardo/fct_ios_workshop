//
//  ALAssetRepresentation+Size.m
//  FCT1
//
//  Created by Fábio Bernardo on 22/09/13.
//  Copyright (c) 2013 Fábio Bernardo. All rights reserved.
//

#import "ALAssetRepresentation+Size.h"

@implementation ALAssetRepresentation (Size)

- (CGSize)aspectRatioDimensions {
    CGSize dimensions = self.dimensions;
    ALAssetOrientation orientation = self.orientation;
    switch (orientation) {
        case ALAssetOrientationLeft:
        case ALAssetOrientationRight:
        case ALAssetOrientationLeftMirrored:
        case ALAssetOrientationRightMirrored:
            return CGSizeMake(dimensions.height, dimensions.width);
        default:
            break;
    }
    return dimensions;
}

- (UIImage *)aspectRatioFullResolutionImage {
    UIImageOrientation orientation;
    switch (self.orientation) {
        case ALAssetOrientationUp:
            orientation = UIImageOrientationUp;
            break;
        case ALAssetOrientationLeft:
            orientation = UIImageOrientationLeft;
            break;
        case ALAssetOrientationRight:
            orientation = UIImageOrientationRight;
            break;
        case ALAssetOrientationDown:
            orientation = UIImageOrientationDown;
            break;
        case ALAssetOrientationUpMirrored:
            orientation = UIImageOrientationUpMirrored;
            break;
        case ALAssetOrientationLeftMirrored:
            orientation = UIImageOrientationLeftMirrored;
            break;
        case ALAssetOrientationRightMirrored:
            orientation = UIImageOrientationRightMirrored;
            break;
        case ALAssetOrientationDownMirrored:
            orientation = UIImageOrientationDownMirrored;
            break;
        default:
            orientation = UIImageOrientationUp;
            break;
    }
    return [UIImage imageWithCGImage:self.fullResolutionImage scale:self.scale orientation:orientation];
}

@end
