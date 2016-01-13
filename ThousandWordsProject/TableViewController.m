//
//  TableViewController.m
//  ThousandWordsProject
//
//  Created by Emmanuel Cuevas on 1/6/16.
//  Copyright © 2016 Emmanuel Cuevas. All rights reserved.
//

#import "TableViewController.h"
#import "Album.h"
#import "CoreDataHelper.h"
#import "CollectionViewController.h"

@interface TableViewController () <UIAlertViewDelegate>

@end

@implementation TableViewController

-(NSMutableArray *)albums
{
    if (!_albums) _albums = [[NSMutableArray alloc] init];
    return _albums;
}

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender {
    UIAlertView *newAlertView = [[UIAlertView alloc] initWithTitle:@"Enter New Album Name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    
    [newAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [newAlertView show];
}

-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if(self){
        //Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
    //This lines of code were removed becaused the CoreDataHelper was added.
//    id delegate = [[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSError *error = nil;
    //The word context was replaced for the class imported from the CoreDataHelper
    NSArray *fetchAlbums = [/*context*/ [CoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    
    self.albums = [fetchAlbums mutableCopy];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

#pragma mark - Helper Methods

-(Album *)albumWithName:(NSString *)name
{
    //This lines of code were removed becaused the CoreDataHelper was added.
//    id delegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [CoreDataHelper managedObjectContext]/*[delegate managedObjectContext] "The value of this variable was replaced by the new class CoreDataHelper" */;
    
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    album.name = name;
    album.date = [NSDate date];
    
    NSError *error = nil;
    if (![context save:&error])
    {
        //We have an error!
        NSLog(@"%@", error);
    }
    return album;
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1){
        NSString *alertText = [alertView textFieldAtIndex:0].text;
//        NSLog(@"My new album is %@", alertText);
        [self.albums addObject:[self albumWithName:alertText]];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.albums count] - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        
//        Album *newAlbum = [self albumWithName:alertText];
//        [self.albums addObject:newAlbum];
//        [self.tableView reloadData];
        
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Album *selectedAlbum = self.albums[indexPath.row];
    cell.textLabel.text = selectedAlbum.name;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"Album Chosen"])
    {
        if ([segue.destinationViewController isKindOfClass:[CollectionViewController class]])
        {
            NSIndexPath *path = [self.tableView indexPathForSelectedRow];
            
            CollectionViewController *targetViewController = segue.destinationViewController;
            targetViewController.album = self.albums[path.row];
        }
    }
    
    
}


@end
