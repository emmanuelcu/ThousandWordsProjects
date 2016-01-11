//
//  PictureDataTransformer.m
//  ThousandWordsProject
//
//  Created by Emmanuel Cuevas on 1/11/16.
//  Copyright © 2016 Emmanuel Cuevas. All rights reserved.
//

#import "PictureDataTransformer.h"

@implementation PictureDataTransformer

+(Class)transformedValueClass
{
    return [NSData class];
}

+(BOOL)allowsReverseTransformation
{
    return YES;
}

-(id)transformedValue:(id)value
{
    return UIImagePNGRepresentation(value);
}

-(id)reverseTransformedValue:(id)value
{
    UIImage *image = [UIImage imageWithData:value];
    return image;
}

@end
