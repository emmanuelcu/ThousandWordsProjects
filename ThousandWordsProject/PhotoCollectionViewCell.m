//
//  PhotoCollectionViewCell.m
//  ThousandWordsProject
//
//  Created by Emmanuel Cuevas on 1/7/16.
//  Copyright © 2016 Emmanuel Cuevas. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#define IMAGEVIEW_BORDER_LENGTH 5

@implementation PhotoCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //Initialization code
    
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self; 
}

-(void)setup
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, IMAGEVIEW_BORDER_LENGTH, IMAGEVIEW_BORDER_LENGTH)];
    [self.contentView addSubview:self.imageView];
}

@end
