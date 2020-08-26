//
//  SPDisplayViewController.m
//  FilterSample
//
//  Created by 王杰 on 2020/8/26.
//  Copyright © 2020 SP. All rights reserved.
//

#import "SPDisplayViewController.h"
#import "GPUImage.h"

#define NAV_HEIGHT self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height
#define STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

@interface SPDisplayViewController ()
@property (nonatomic, strong) GPUImageView *imageView;
@property (nonatomic, strong) UISlider *slider;
@end

@implementation SPDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.slider];
    
    UIImage *inputImage = [UIImage imageNamed:@"WID-small.jpg"];
    [self processImage:inputImage];
}

- (void)processImage:(UIImage *)inputImage {
    GPUImagePicture  *sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];

    GPUImageTiltShiftFilter *sepiaFilter = [[GPUImageTiltShiftFilter alloc] init];

    [sepiaFilter forceProcessingAtSize:self.imageView.sizeInPixels];

    [sourcePicture addTarget:sepiaFilter];
    [sepiaFilter addTarget:self.imageView];

    [sourcePicture processImage];
}

- (UIImage *)addSketchFilter:(UIImage *)oldImg {
    
     // 获取数据源
     GPUImagePicture *stillImgSrc = [[GPUImagePicture alloc] initWithImage:oldImg];
    
    // 创建一个素描滤镜
    GPUImageTiltShiftFilter *filter = [[GPUImageTiltShiftFilter alloc] init];
       
    // 设置将要渲染的区域
    [filter forceProcessingAtSize:oldImg.size];
    [filter useNextFrameForImageCapture];
     // 添加滤镜
     [stillImgSrc addTarget:filter];
     // 开始渲染
     [stillImgSrc processImage];
    
     UIImage *newImg = [filter imageFromCurrentFramebuffer];
    return newImg;
}

#pragma mark -

- (GPUImageView *)imageView {
    if (!_imageView) {
        _imageView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-200-NAV_HEIGHT)];
    }
    return _imageView;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height-100, self.view.frame.size.width-50, 50)];
    }
    return _slider;
}

@end
