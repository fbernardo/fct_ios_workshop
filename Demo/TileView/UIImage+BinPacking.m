//
//  UIImage+BinPacking.m
//  FCT1
//
//  Created by Fábio Bernardo on 19/09/13.
//  Copyright (c) 2013 Fábio Bernardo. All rights reserved.
//

#import "UIImage+BinPacking.h"
#import "BinaryLayoutTreemap.h"

@implementation UIImageBinPackingItem

@synthesize mappableSize, mappableBounds;

+ (id)packingItemWithSize:(CGSize)size fetchImageBlock:(UIImage * (^)())fetchImageBlock {
    UIImageBinPackingItem *item = [[UIImageBinPackingItem alloc] init];
    item.fetchImageBlock = fetchImageBlock;
    item.size = size;
    item.mappableSize = [NSNumber numberWithDouble:item.size.width * item.size.height];
    item.mappableBounds = (CGRect) {.size = size};
    return item;
}



@end

@implementation UIImage (BinPacking)

// fb's
/*
+ (UIImage *)drawImages:(NSArray *)images atRects:(NSArray *)rects onSize:(CGSize)size {
 #ifdef DEBUG
 NSDate *start = [NSDate date];
 #endif

    CGRect imageRect = (CGRect) {.size = size};
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor redColor] setFill];
    CGContextFillRect(ctx, imageRect);
    
    for (int i = 0; i < [rects count]; i++) {
        @autoreleasepool {
            UIImageBinPackingItem *item = images[i];
            CGRect rect = [rects[i] CGRectValue];
            
            UIImage *image = item.fetchImageBlock();
            
            CGSize imageSize = image.size;
            float ratio = MAX(CGRectGetHeight(rect) / imageSize.height, CGRectGetWidth(rect) / imageSize.width);
            imageSize.width = ceilf(imageSize.width * ratio);
            imageSize.height = ceilf(imageSize.height * ratio);
            
            CGRect frame = (CGRect) {
                .origin.x = rect.origin.x + floorf((rect.size.width-imageSize.width)/2.0),
                .origin.y = rect.origin.y + floorf((rect.size.height-imageSize.height)/2.0),
                .size = imageSize
            };
            
            {
                CGContextSaveGState(ctx);
                
                CGContextClipToRect(ctx, rect);
                [image drawInRect:frame];
                
                CGContextRestoreGState(ctx);
            }
        }
    }
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
 #ifdef DEBUG
 NSDate *end = [NSDate date];
 NSLog(@"%f", [end timeIntervalSinceDate:start]);
 #endif

    return finalImage;
}
*/

+ (UIImage *)drawImages:(NSArray *)images atRects:(NSArray *)rects onSize:(CGSize)size
{
#ifdef DEBUG
    NSDate *start = [NSDate date];
#endif

    CGRect imageRect = (CGRect) {.size = size};
    BOOL vertical = (size.height > size.width);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    BinaryLayoutTreemap *treemap = [[BinaryLayoutTreemap alloc] init];
    [treemap layout:images start:0 end:images.count-1 bounds:imageRect vertical:vertical];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor redColor] setFill]; // @fb: wtf? Is this some alien experiment leftovers? :-P
    
    CGContextFillRect(ctx, imageRect);

    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        @autoreleasepool {
            UIImageBinPackingItem *item = (UIImageBinPackingItem*) obj;
            UIImage *image = item.fetchImageBlock();
            CGContextSaveGState(ctx);
            
            CGContextClipToRect(ctx, item.mappableBounds); // @fb: is this correct? I'm in doubt
            [image drawInRect:item.mappableBounds];
            
            CGContextRestoreGState(ctx);
            }
    }];

    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

#ifdef DEBUG
    NSDate *end = [NSDate date];
    NSLog(@"%f", [end timeIntervalSinceDate:start]);
#endif
    
    return finalImage;
}

CGFloat valueForSize(CGSize size) {
    return size.width * size.height * 0.1f;
}

+ (NSArray *)rectsForImageSizes:(NSArray *)imageSizes onBounds:(CGRect)bounds {
    //Base case, the image has all the content bounds
    if ([imageSizes count] == 1) {
        return @[[NSValue valueWithCGRect:bounds]];
    }
    
    //Calculate total and half area
    CGFloat totalArea = 0;
    for (NSValue *sizeValue in imageSizes) {
        CGSize size = [sizeValue CGSizeValue];
        totalArea += valueForSize(size);
    }
    CGFloat abTotal = totalArea;
    CGFloat half = totalArea / 2.0;
    
    //Find the middle,
    totalArea = 0;
    int middle = [imageSizes count] - 1;
    for (int i = 0; i < [imageSizes count]; i++) {
        if (totalArea > half) {
            middle = i;
            break;
        }
        
        CGSize size = [imageSizes[i] CGSizeValue];
        totalArea += valueForSize(size);
    }
    middle = middle < 1 ? 1 : middle;
    
    assert(totalArea != 0);
    
    //Divide the array in two
    NSArray *aArray = [imageSizes subarrayWithRange:NSMakeRange(0, middle)];
    NSArray *bArray = [imageSizes subarrayWithRange:NSMakeRange(middle, [imageSizes count] - middle)];
    
    //Calculate the total of A and the total of B
    CGFloat aTotal = 0;
    CGFloat bTotal = 0;
    for (NSValue *sizeValue in aArray) {
        CGSize size = [sizeValue CGSizeValue];
        aTotal+=valueForSize(size);
    }
    
    for (NSValue *sizeValue in bArray) {
        CGSize size = [sizeValue CGSizeValue];
        bTotal+=valueForSize(size);
    }
    
    //Calculate the ratio of A
    CGFloat aRatio;
    if (abTotal > 0) {
        aRatio = aTotal / abTotal;
    } else aRatio = 0.5;
    
    CGRect aRect, bRect;
    
    //Divide bounds in two, either horizontal or vertical
    CGFloat totalWidth = bounds.size.width;
    CGFloat totalHeight = bounds.size.height;
    BOOL horizontal = (totalWidth > totalHeight);

    if (horizontal) {
        //divide bounds horizontaly
        CGFloat aWidth = ceilf(totalWidth * aRatio);
        CGFloat bWidth = totalWidth - aWidth;
        aRect = CGRectMake(bounds.origin.x, bounds.origin.y, aWidth, totalHeight);
        bRect = CGRectMake(bounds.origin.x + aWidth, bounds.origin.y, bWidth, totalHeight);
    } else {
        assert(totalArea != 0);
        //divide bounds verticaly
        CGFloat aHeight = ceilf(totalHeight * aRatio);
        CGFloat bHeight = totalHeight - aHeight;
        aRect = CGRectMake(bounds.origin.x, bounds.origin.y, totalWidth, aHeight);
        bRect = CGRectMake(bounds.origin.x, bounds.origin.y + aHeight, totalWidth, bHeight);
    }
    
    
    CGFloat minW = 50;
    CGFloat minH = 80;
    NSArray *arr;
    if (bRect.size.height < minH || bRect.size.width < minW) {
        aRect = CGRectUnion(aRect, bRect);
        //Return left + right side (recursive)
        arr = [self rectsForImageSizes:aArray onBounds:aRect];
    } else if (aRect.size.height < minH || aRect.size.width < minW) {
        bRect = CGRectUnion(aRect, bRect);
        //Return left + right side (recursive)
        arr = [self rectsForImageSizes:bArray onBounds:bRect];
    } else {
        //Return left + right side (recursive)
        NSArray *aRects = [self rectsForImageSizes:aArray onBounds:aRect];
        NSArray *bRects = [self rectsForImageSizes:bArray onBounds:bRect];
        
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:[aRects count] + [bRects count]];
        [mArr addObjectsFromArray:aRects];
        [mArr addObjectsFromArray:bRects];
        arr = [mArr copy];
    }
    
    return arr;
}

+ (UIImage *)imageWithSize:(CGSize)size andImages:(NSArray *)images {
    CGRect rect = (CGRect){.size = size};
    
    NSMutableArray *sizes = [NSMutableArray arrayWithCapacity:[images count]];
    for (UIImageBinPackingItem *item in images) {
        [sizes addObject:[NSValue valueWithCGSize:item.size]];
    }
    
    NSArray *frames = [self rectsForImageSizes:sizes onBounds:rect];
    return [self drawImages:images
                    atRects:frames
                     onSize:size];
        
}

@end
