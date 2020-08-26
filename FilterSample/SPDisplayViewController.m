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
@property (nonatomic, strong) GPUImagePicture *sourcePicture;
@property (nonatomic, strong) GPUImageView *imageView;
@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, strong) GPUImageFilter *filter;
@end

@implementation SPDisplayViewController
{
    NSString *_title;
    CGFloat _maximumValue;
    CGFloat _minimumValue;
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        _title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _title;
    
    [self.view addSubview:self.imageView];
    
    [self createFilter];
    [self.view addSubview:self.slider];
}

- (void)createFilter {
    if ([_title isEqualToString:@"亮度"]) {
        _maximumValue = 1;
        _minimumValue = -1;
        if (!self.filter) {
            self.filter = [[GPUImageBrightnessFilter alloc] init];
             [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
             [self.sourcePicture addTarget:self.filter];
             [self.filter addTarget:self.imageView];
        }
        ((GPUImageBrightnessFilter *)self.filter).brightness = 0;
        self.slider.value = 0;
    }
    
    if ([_title isEqualToString:@"曝光度"]) {
        _maximumValue = 10;
        _minimumValue = -10;
        if (!self.filter) {
            self.filter = [[GPUImageExposureFilter alloc] init];
             [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
             [self.sourcePicture addTarget:self.filter];
             [self.filter addTarget:self.imageView];
        }
        ((GPUImageExposureFilter *)self.filter).exposure = 0;
        self.slider.value = 0;
    }
    
    if ([_title isEqualToString:@"对比度"]) {
        _maximumValue = 4;
        _minimumValue = 0;
        if (!self.filter) {
            self.filter = [[GPUImageContrastFilter alloc] init];
             [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
             [self.sourcePicture addTarget:self.filter];
             [self.filter addTarget:self.imageView];
        }
        ((GPUImageContrastFilter *)self.filter).contrast = 1;
        self.slider.value = 1;
    }
    
    if ([_title isEqualToString:@"饱和度"]) {
         _maximumValue = 2;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageSaturationFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
         ((GPUImageSaturationFilter *)self.filter).saturation = 1;
         self.slider.value = 1;
     }
    
    if ([_title isEqualToString:@"伽马线"]) {
         _maximumValue = 3;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageGammaFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
         ((GPUImageGammaFilter *)self.filter).gamma = 1;
         self.slider.value = 1;
     }
    
    if ([_title isEqualToString:@"素描"]) {
         if (!self.filter) {
             self.filter = [[GPUImageSketchFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        
         self.slider.hidden = YES;
     }
    
    if ([_title isEqualToString:@"卡通"]) {
         _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageToonFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImageToonFilter *)self.filter).threshold = 0.2;
        self.slider.value = 0.2;
     }
    
    if ([_title isEqualToString:@"细腻卡通"]) {
         _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageSmoothToonFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
         ((GPUImageSmoothToonFilter *)self.filter).threshold = 0.2;
         self.slider.value = 0.2;
     }
    
    
    if ([_title isEqualToString:@"桑原"]) {
         _maximumValue = 5;
         _minimumValue = 1;
         if (!self.filter) {
             self.filter = [[GPUImageKuwaharaFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
         ((GPUImageKuwaharaFilter *)self.filter).radius = 3;
         self.slider.value = 3;
     }
    
    if ([_title isEqualToString:@"马赛克"]) {
        _maximumValue = 3;
         _minimumValue = 1;
         if (!self.filter) {
             self.filter = [[GPUImageMosaicFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
         ((GPUImageMosaicFilter *)self.filter).numTiles = 1;
         self.slider.value = 0;
     }
    
    
    if ([_title isEqualToString:@"像素化"]) {
        _maximumValue = 0.5;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImagePixellateFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
         ((GPUImagePixellateFilter *)self.filter).fractionalWidthOfAPixel = 0;
         self.slider.value = 0;
     }
    
    
    if ([_title isEqualToString:@"同心圆像素化"]) {
        _maximumValue = 2;
         _minimumValue = -2;
         if (!self.filter) {
             self.filter = [[GPUImagePolarPixellateFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImagePolarPixellateFilter *)self.filter).pixelSize = CGSizeMake(0.05, 0.05);
        self.slider.value = 0.05;
     }
    
    if ([_title isEqualToString:@"交叉线阴影"]) {
        _maximumValue = 0.1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageCrosshatchFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImageCrosshatchFilter *)self.filter).crossHatchSpacing = 0.03;
        self.slider.value = 0.03;
     }
    
    
    if ([_title isEqualToString:@"晕影"]) {
        _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageVignetteFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        
        ((GPUImageVignetteFilter *)self.filter).vignetteStart = 0.5;
     }
    
    if ([_title isEqualToString:@"漩涡"]) {
        _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageSwirlFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        
        ((GPUImageSwirlFilter *)self.filter).radius = 0.5;
     }
    
    if ([_title isEqualToString:@"凸面镜"]) {
        _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageBulgeDistortionFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImageBulgeDistortionFilter *)self.filter).radius = 0.25;
        self.slider.value = 0.25;
     }
    
    
    if ([_title isEqualToString:@"凹面镜"]) {
        _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImagePinchDistortionFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImagePinchDistortionFilter *)self.filter).radius = 0.25;
        self.slider.value = 0.25;
     }
    
    if ([_title isEqualToString:@"水晶球"]) {
        _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageGlassSphereFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImageGlassSphereFilter *)self.filter).radius = 0.25;
        self.slider.value = 0.25;
     }
    
    
    [self.sourcePicture processImage];
}

- (void)processImageWithValue:(CGFloat)value {
    
    if ([_title isEqualToString:@"亮度"]) {
        ((GPUImageBrightnessFilter *)self.filter).brightness = value;
    }
    
    if ([_title isEqualToString:@"曝光度"]) {

        ((GPUImageExposureFilter *)self.filter).exposure = value;
    }
    
    if ([_title isEqualToString:@"对比度"]) {
        ((GPUImageContrastFilter *)self.filter).contrast = value;
    }
    
    if ([_title isEqualToString:@"饱和度"]) {
         ((GPUImageSaturationFilter *)self.filter).saturation = value;
     }
    
    if ([_title isEqualToString:@"伽马线"]) {
         ((GPUImageGammaFilter *)self.filter).gamma = value;
     }
    
    if ([_title isEqualToString:@"卡通"]) {
        ((GPUImageToonFilter *)self.filter).threshold = value;
     }
    
    if ([_title isEqualToString:@"细腻卡通"]) {
         ((GPUImageSmoothToonFilter *)self.filter).threshold = value;
     }
    
    if ([_title isEqualToString:@"桑原"]) {
         ((GPUImageKuwaharaFilter *)self.filter).radius = value;
     }
    
    
    if ([_title isEqualToString:@"马赛克"]) {
        ((GPUImageMosaicFilter *)self.filter).numTiles = self.slider.value;
     }
    
    if ([_title isEqualToString:@"像素化"]) {
         ((GPUImagePixellateFilter *)self.filter).fractionalWidthOfAPixel = value;
     }
    
    if ([_title isEqualToString:@"同心圆像素化"]) {
        ((GPUImagePolarPixellateFilter *)self.filter).pixelSize = CGSizeMake(self.slider.value, self.slider.value);
     }
    
    if ([_title isEqualToString:@"交叉线阴影"]) {
        ((GPUImageCrosshatchFilter *)self.filter).crossHatchSpacing = self.slider.value;
     }
    
    if ([_title isEqualToString:@"晕影"]) {
        ((GPUImageVignetteFilter *)self.filter).vignetteStart = self.slider.value;
     }
    
    
    if ([_title isEqualToString:@"漩涡"]) {
        ((GPUImageSwirlFilter *)self.filter).radius = self.slider.value;
     }
    
    if ([_title isEqualToString:@"凸面镜"]) {
        ((GPUImageBulgeDistortionFilter *)self.filter).radius = self.slider.value;
     }
    
    
    if ([_title isEqualToString:@"凹面镜"]) {
        ((GPUImagePinchDistortionFilter *)self.filter).radius = self.slider.value;
     }
    
    if ([_title isEqualToString:@"水晶球"]) {
        ((GPUImageGlassSphereFilter *)self.filter).radius = self.slider.value;
     }
    
    [self.sourcePicture processImage];
}

- (void)valueChanged {
    [self processImageWithValue:self.slider.value];
}

#pragma mark -

- (GPUImagePicture *)sourcePicture {
    if (!_sourcePicture) {
        UIImage *inputImage = [UIImage imageNamed:@"WID-small.jpg"];
        _sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];
    }
    return _sourcePicture;
}

- (GPUImageView *)imageView {
    if (!_imageView) {
        _imageView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-200-NAV_HEIGHT)];
    }
    return _imageView;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height-100, self.view.frame.size.width-50, 50)];
        _slider.maximumValue = _maximumValue;
        _slider.minimumValue = _minimumValue;
        [_slider addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

@end
