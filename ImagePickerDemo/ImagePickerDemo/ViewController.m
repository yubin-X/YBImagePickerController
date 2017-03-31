//
//  ViewController.m
//  ImagePickerDemo
//
//  Created by Yubin on 2017/3/30.
//  Copyright © 2017年 X. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "YBImagePickerController.h"
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import <MediaPlayer/MPMoviePlayerController.h>

@interface ViewController ()
@property (nonatomic, strong) YBImagePickerController *YBPicker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.YBPicker = [[YBImagePickerController alloc] init];
}

- (IBAction)selectImage:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    [self.YBPicker configureForSelectImageFromPhotos];
    self.YBPicker.didFinishBlock = ^(id data){
        UIImage *image = (UIImage *)data;
        weakSelf.imageView.image = image;
    };
    self.YBPicker.didFailBlock = ^(NSError *error)
    {
        NSLog(@"没有获取到资源");
    };
    [self presentViewController:self.YBPicker animated:YES completion:nil];
    
}
- (IBAction)takeAPhoto:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self.YBPicker configureForTakeAPhoto];
    self.YBPicker.didFinishBlock = ^(id data){
        UIImage *image = (UIImage *)data;
        weakSelf.imageView.image = image;
    };
    self.YBPicker.didFailBlock = ^(NSError *error)
    {
        NSLog(@"没有获取到资源");
    };
    [self presentViewController:self.YBPicker animated:YES completion:nil];
}

- (IBAction)selectVideo:(id)sender {
    [self.YBPicker configureForSelectVideoFromPhotos];
    __weak typeof(self) weakSelf = self;
    self.YBPicker.didFinishBlock = ^(id data){
        NSURL *url = (NSURL *)data;
        NSLog(@"%@",url);        
        MPMoviePlayerViewController *mpp = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [weakSelf presentMoviePlayerViewControllerAnimated:mpp];
    };
    self.YBPicker.didFailBlock = ^(NSError *error)
    {
        NSLog(@"没有获取到资源");
    };
    [self presentViewController:self.YBPicker animated:YES completion:nil];
}

- (IBAction)takeAVideo:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self.YBPicker configureForTakeAVideo];
    self.YBPicker.didFinishBlock = ^(id data){
        NSURL *url = (NSURL *)data;
        
        NSLog(@"%@",url);
        MPMoviePlayerViewController *mpp = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [weakSelf presentMoviePlayerViewControllerAnimated:mpp];    };
    self.YBPicker.didFailBlock = ^(NSError *error)
    {
        NSLog(@"没有获取到资源");
    };
    [self presentViewController:self.YBPicker animated:YES completion:nil];

}
- (IBAction)saveVideo:(id)sender {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"abcd" withExtension:@"MOV"];
    NSLog(@"%@",url);
    if (url == nil) {
        return;
    }
    [self.YBPicker saveVideoToSavedPhotosAlbum:url.path Success:^(id  _Nonnull data) {
        NSLog(@"存储视频成功");
    } failure:^(NSError * _Nullable error) {
        NSLog(@"存储视频失败");
    }];
}
- (IBAction)saveImage:(id)sender {
    UIImage *image = [UIImage imageNamed:@"save"];
    [self.YBPicker saveImageToSavedPhotosAlbum:image success:^(id  _Nonnull data) {
        NSLog(@"存储照片成功");
    } failure:^(NSError * _Nullable error) {
        NSLog(@"存储照片失败");
    }];

}

@end
