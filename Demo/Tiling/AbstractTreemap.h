//
//  AbstractTreemap.h
//  CameraRollTest
//
//  Created by Rodrigo on 21/09/13.
//  Copyright (c) 2013 CRT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractTreemap : NSObject

+ (NSArray*)sortDescending:(NSArray*)items;

+ (NSNumber*)sum:(NSArray*)items start:(NSNumber*)start end:(NSNumber*)end;

@end
