//
//  AbstractTreemap.m
//  CameraRollTest
//
//  Created by Rodrigo on 21/09/13.
//  Copyright (c) 2013 CRT. All rights reserved.
//

#import "AbstractTreemap.h"
#import "Mappable.h"

@implementation AbstractTreemap

+ (NSArray*)sortDescending:(NSArray*)items
{
    return [items sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        id<Mappable> first = (id<Mappable>) obj1;
        id<Mappable> second = (id<Mappable>) obj2;
        
        return [first.mappableSize compare:second.mappableSize];
    }];
}

+ (NSNumber*)sum:(NSArray*)items start:(NSNumber*)start end:(NSNumber*)end
{
    __block double s = 0;
    
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(idx >= [start intValue] && idx <= [end intValue])
        {
            s+= [((id<Mappable>)obj).mappableSize doubleValue];
        }
    }];
    
    return [NSNumber numberWithDouble:s];
}

@end



