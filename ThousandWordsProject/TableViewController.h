//
//  TableViewController.h
//  ThousandWordsProject
//
//  Created by Emmanuel Cuevas on 1/6/16.
//  Copyright © 2016 Emmanuel Cuevas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *albums;

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
