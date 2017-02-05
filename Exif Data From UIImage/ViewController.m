//
//  ViewController.m
//  Exif Data From UIImage
//
//  Created by Jaffer Sheriff U on 22/11/16.
//  Copyright © 2016 Jaffer Sheriff U. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *openButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [openButton addTarget:self action:@selector(openGallery) forControlEvents:UIControlEventTouchUpInside];
    [openButton setTitle:@"Open Gallery" forState:UIControlStateNormal];
    [openButton setBackgroundColor:[UIColor yellowColor]];
    [openButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:openButton];
    
    [openButton setCenter:self.view.center];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)openGallery
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
    PHAsset *asset = fetchResult.firstObject;

    
    NSString *latitude = [NSString stringWithFormat:@"Lati = %f  Longi = %f", asset.location.coordinate.latitude, asset.location.coordinate.longitude];
    NSString *dateStr = [NSString stringWithFormat:@" Date =  %@",asset.creationDate];
    
    NSString *resultStr = [NSString stringWithFormat:@"%@ \n %@",latitude,dateStr];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Info" message:resultStr preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:alert animated:YES completion:nil];
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
