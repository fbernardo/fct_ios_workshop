//
//  BinaryLayoutTreemap.m
//  CameraRollTest
//
//  Created by Rodrigo on 23/09/13.
//  Copyright (c) 2013 CRT. All rights reserved.
//

#import "BinaryLayoutTreemap.h"
#import "Mappable.h"

@implementation BinaryLayoutTreemap

- (void)layout:(NSArray*)items start:(int)start end:(int)end bounds:(CGRect)bounds vertical:(BOOL)vertical
{
    if(start <= end)
    {
        if(start == end)
        {
            ((id<Mappable>)items[start]).mappableBounds = bounds;
        }
        else
        {
            int mid = (start + end) / 2;
            
            double total = [self sum:items start:start end:end];
            double first = [self sum:items start:start end:mid];
            
            double a = MAX([self minimumScaleFactor], first/total);//first / total;
            CGFloat x = bounds.origin.x;
            CGFloat y = bounds.origin.y;
            CGFloat w = bounds.size.width;
            CGFloat h = bounds.size.height;
            
            if(vertical)
            {
                CGRect b1 = CGRectMake(x, y, w*a, h);
                CGRect b2 = CGRectMake(x+w*a, y, w*(1-a), h);
                [self layout:items start:start end:mid bounds:b1 vertical:!vertical];
                [self layout:items start:mid+1 end:end bounds:b2 vertical:!vertical];
            }
            else
            {
                CGRect b1 = CGRectMake(x, y, w, h*a);
                CGRect b2 = CGRectMake(x, y+h*a, w,h*(1-a));
                [self layout:items start:start end:mid bounds:b1 vertical:!vertical];
                [self layout:items start:mid+1 end:end bounds:b2 vertical:!vertical];
            }
        }
    }
}

#pragma mark - Overrides

- (double)minimumScaleFactor
{
    return 0.3;
}

#pragma mark - Private methods

- (double)sum:(NSArray*)items start:(int)start end:(int)end
{
    __block double result = 0;
    
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(idx >= start && idx <= end )
        {
            result+= [((id<Mappable>)obj).mappableSize doubleValue];
        }
    }];
    
    return result;
}

@end