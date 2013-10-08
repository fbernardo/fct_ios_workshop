//
//  UIImage+BinPacking.h
//  FCT1
//
//  Created by Fábio Bernardo on 19/09/13.
//  Copyright (c) 2013 Fábio Bernardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mappable.h"

@interface UIImageBinPackingItem : NSObject <Mappable>

@property (nonatomic, readwrite) CGSize size;
@property (nonatomic, strong) UIImage* (^fetchImageBlock)();

+ (id)packingItemWithSize:(CGSize)size fetchImageBlock:(UIImage * (^)())fetchImageBlock;

@end

@interface UIImage (BinPacking)

+ (UIImage *)imageWithSize:(CGSize)size andImages:(NSArray *)images;

@end
