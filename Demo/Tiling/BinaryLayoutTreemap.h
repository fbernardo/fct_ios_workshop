//
//  BinaryLayoutTreemap.h
//  CameraRollTest
//
//  Created by Rodrigo on 23/09/13.
//  Copyright (c) 2013 CRT. All rights reserved.
//

#import "AbstractTreemap.h"

@interface BinaryLayoutTreemap : AbstractTreemap

- (void)layout:(NSArray*)items start:(int)start end:(int)end bounds:(CGRect)bounds vertical:(BOOL)vertical;

// To be overridden in subclasses to define min scale factor
// 0 - no scale: images are made the optimal size, best tiling (original algorithm behaviour)
// 0.3 - default implementation value 
// 1 - normal scale (no tiling)
- (double)minimumScaleFactor;

@end

