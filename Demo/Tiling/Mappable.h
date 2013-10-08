//
//  Mappable.h
//  CameraRollTest
//
//  Created by #pragmapilot on 21/09/13.
//  Copyright (c) 2013 #pragmapilot. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Mappable <NSObject>

@property (nonatomic, strong) NSNumber *mappableSize; // double
@property (nonatomic) CGRect mappableBounds;

@end