//
//  CollectionViewController.h
//  ThousandWordsProject
//
//  Created by Emmanuel Cuevas on 1/7/16.
//  Copyright © 2016 Emmanuel Cuevas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"


@interface CollectionViewController : UICollectionViewController

@property (strong,nonatomic) Album *album;

- (IBAction)cameraButtonItemPressed:(UIBarButtonItem *)sender;

@end
