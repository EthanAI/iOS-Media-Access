//
//  ViewController.h
//  MediaAccess
//
//  Created by Ethan Smith on 10/13/14.
//  Copyright (c) 2014 MobiTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photos/Photos.h"
#import "AssetsLibrary/AssetsLibrary.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property UIImage* image;
@property NSString* location;

@end

