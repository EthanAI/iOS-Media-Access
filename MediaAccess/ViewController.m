//
//  ViewController.m
//  MediaAccess
//
//  Created by Ethan Smith on 10/13/14.
//  Copyright (c) 2014 MobiTV. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // PHAsset -> AVAsset rout
    PHFetchResult* fetchResult = [self getPHFetchResult];
    PHAsset* firstPHAssset = [self phFetchResultToPHAsset:fetchResult];
    //AVAsset* firstAVAsset = [self phAssetToAVAsset:firstPHAssset];
    //NSString* localMediaURLString = [self avAssetToLocalURLString:firstAVAsset];
    
    // PHAsset -> UIIMage rout
    UIImage* image = [self phAssetToUIImage:firstPHAssset];
    NSString* localMediaURLString = [self uiImageToLocalURLString:image];
    
    [self confirmUsableMedia:localMediaURLString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data Retrieval

-(PHFetchResult *) getPHFetchResult {
    PHFetchResult* phFetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    NSLog(@"Media count: %d", [phFetchResult count]);
    return phFetchResult;
}

-(PHAsset *) phFetchResultToPHAsset:(PHFetchResult *)phFetchResult {
    PHAsset* phAsset = [phFetchResult objectAtIndex:0];
    NSLog(@"Valid PHAsset: %d", !(phAsset == nil));
    return phAsset;
}

-(AVAsset *) phAssetToAVAsset:(PHAsset *)phAsset {
    // TODO
    // Appears no API call for this exists...
    return nil;
}

-(UIImage *) phAssetToUIImage:(PHAsset *)phAsset {
    PHImageManager *manager = [PHImageManager defaultManager];
    PHImageRequestOptions* options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES; // Force sequential work. We have nothing to do until this block returns.
    
    [manager requestImageForAsset:phAsset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage *resultImage, NSDictionary *info)
     {
         _image = resultImage;
         NSURL* fileURL = [info objectForKey:@"PHImageFileURLKey"];
         //NSLog([fileURL relativePath]);
         _location = [fileURL path];
     }];
    NSLog(@"Valid UIImage: %d", !(_image == nil));
    return _image;
}

-(NSString *) uiImageToLocalURLString:(UIImage *)image {
    NSString* tempDirectory = NSTemporaryDirectory();
    NSString* tempMediaName = [_location lastPathComponent];
    NSString* targetPath = [tempDirectory stringByAppendingPathComponent:tempMediaName];
    
    NSLog(@"%@, %@", image , targetPath);
    
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:targetPath atomically:YES];
    
    return targetPath;
}

-(void) getMPMediaItems {
    
}

-(void) mpMediaItemToAVAsset {
    
}

-(NSString *) avAssetToLocalURLString:(AVAsset *)avAsset {
    // TODO
    return nil;
}

-(void) confirmUsableMedia:(NSString *)localMediaURLString {
    UIImage* loadedImage = [UIImage imageWithContentsOfFile:localMediaURLString];
    self.imageView.image = loadedImage;
    NSLog(@"Loaded temp image from: %@", localMediaURLString);
}
@end
