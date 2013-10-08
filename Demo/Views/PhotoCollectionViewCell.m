//
//  PhotoCollectionViewCell.m
//  Demo
//
//  Created by Rodrigo on 08/10/13.
//  Copyright (c) 2013 fctw. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if(selected)
    {
        self.imageView.alpha = 0.7;
        self.checkmarkView.hidden = NO;
    }
    else
    {
        self.imageView.alpha = 1.0;
        self.checkmarkView.hidden = YES;
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.imageView.alpha = 1;
    self.checkmarkView.hidden = YES;
}

@end
