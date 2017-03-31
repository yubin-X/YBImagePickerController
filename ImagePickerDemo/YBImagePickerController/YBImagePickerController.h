//
//  YBImagePickerController.h
//  ImagePicker
//
//  Created by Yubin on 2017/3/30.
//  Copyright © 2017年 X. All rights reserved.
//

/*
 功能清单：
 
 1.从相册中选择图片
 2.从相册中选择视频
 3.拍照
 4.拍摄视频
 5.将图片存储到相册
 6.将图片存储到相册
 
 PS: 本类库不支持多选，以上操作每次只能获取一张图片或者一个视频，
 */

#import <UIKit/UIKit.h>

typedef void(^Success)(id _Nonnull data);
typedef void(^Failure)(NSError *_Nullable error);
@interface YBImagePickerController : UIImagePickerController

// 选取图片或者视频成功或者失败的回调
@property (nonatomic, copy) Success _Nonnull didFinishBlock;
@property (nonatomic, copy) Failure _Nullable didFailBlock;
/** 从相册中选择一张照片 */
- (void) configureForSelectImageFromPhotos;
/** 拍摄一张照片 */
- (void) configureForTakeAPhoto;
/** 从相册中选择一个视频 */
- (void) configureForSelectVideoFromPhotos;
/** 拍摄一个视频 */
- (void) configureForTakeAVideo;


- (void)saveImageToSavedPhotosAlbum:(UIImage *_Nonnull)image success:(Success _Nullable)success failure:(Failure _Nullable)failure;
- (void)saveVideoToSavedPhotosAlbum:(NSString *_Nonnull)path Success:(Success _Nullable)success failure:(Failure _Nullable)failure;

@end
