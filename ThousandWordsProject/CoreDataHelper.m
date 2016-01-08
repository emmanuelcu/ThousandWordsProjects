//
//  CoreDataHelper.m
//  ThousandWordsProject
//
//  Created by Emmanuel Cuevas on 1/7/16.
//  Copyright © 2016 Emmanuel Cuevas. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper

+(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}


@end
