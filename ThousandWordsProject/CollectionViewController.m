//
//  CollectionViewController.m
//  ThousandWordsProject
//
//  Created by Emmanuel Cuevas on 1/7/16.
//  Copyright © 2016 Emmanuel Cuevas. All rights reserved.
//

#import "CollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "Photo.h"
#import "PictureDataTransformer.h"
#import "CoreDataHelper.h"

@interface CollectionViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong,nonatomic) NSMutableArray *photos; // Of UIImages

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
        
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)cameraButtonItemPressed:(UIBarButtonItem *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark - Helper Methods


-(Photo *)photoFromImage:(UIImage *)image
{
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[CoreDataHelper managedObjectContext ]];
    photo.image = image;
    photo.date = [NSDate date];
    photo.albumBook = self.album;
    
    NSError *error = nil;
    
    if (![[photo managedObjectContext] save:&error])
    {
        //Error in saving
        
        NSLog(@"%@", error);
    }
    return photo;
    
}




#pragma mark - UICollectionViewDataSource



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotoCell";
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Adding the Photo class because the image is not the same class than a photo.
    
    Photo *photo = self.photos[indexPath.row];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image =  photo.image;  //this code was removed -- self.photos[indexPath.row];  //we change the current method. The one that war programatically was [UIImage imageNamed:@"Cute_dog"]
    
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count]; //this was updated to a selected number of photos to the count of number of photos in the album.
}

#pragma mark <UICollectionViewDelegate>


//In this two methods we make the option to enter the picture collection and select one picture.

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"Finished Picking!");
    
    UIImage *image = info [UIImagePickerControllerEditedImage];
    if (!image) image = info[UIImagePickerControllerOriginalImage];
    
    //Until here all the project works very well. Since this point it could crash.
    
    [self.photos addObject: [self photoFromImage:image/*image*/]];
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Cancel");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
