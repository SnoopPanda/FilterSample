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
    
    if ([_title isEqualToString:@"反色"]) {
         if (!self.filter) {
             self.filter = [[GPUImageColorInvertFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
         self.slider.hidden = YES;
     }
    
    if ([_title isEqualToString:@"褐色(怀旧)"]) {
         if (!self.filter) {
             self.filter = [[GPUImageSepiaFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
         self.slider.hidden = YES;
     }
    
    if ([_title isEqualToString:@"色阶"]) {
         if (!self.filter) {
             self.filter = [[GPUImageLevelsFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
         self.slider.hidden = YES;
     }
    
    if ([_title isEqualToString:@"灰度"]) {
          if (!self.filter) {
              self.filter = [[GPUImageGrayscaleFilter alloc] init];
               [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
               [self.sourcePicture addTarget:self.filter];
               [self.filter addTarget:self.imageView];
          }
          self.slider.hidden = YES;
      }

    
    if ([_title isEqualToString:@"色彩直方图"]) { // TODO
         _maximumValue = 16;
         _minimumValue = 1;
         if (!self.filter) {
             self.filter = [[GPUImageHistogramFilter alloc] initWithHistogramType:kGPUImageHistogramRed];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
//        ((GPUImageHistogramFilter *)self.filter).downsamplingFactor = 16;
        self.slider.value = 16;
     }
    
    if ([_title isEqualToString:@"RGB"]) {
         _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageRGBFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImageRGBFilter *)self.filter).red = 1;
        ((GPUImageRGBFilter *)self.filter).green = 1;
        ((GPUImageRGBFilter *)self.filter).blue = 1;
        self.slider.value = 1;
     }
    
    if ([_title isEqualToString:@"色调曲线"]) {
         if (!self.filter) {
             self.filter = [[GPUImageToneCurveFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        self.slider.hidden = YES;
     }
    
    if ([_title isEqualToString:@"单色"]) {
         _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageMonochromeFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
//        ((GPUImageMonochromeFilter *)self.filter).red = 1;
        self.slider.value = 1;
     }
    
    if ([_title isEqualToString:@"不透明度"]) {
         _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageOpacityFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImageOpacityFilter *)self.filter).opacity = 1;
        self.slider.value = 1;
     }
    
    if ([_title isEqualToString:@"提亮阴影"]) {
         _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageHighlightShadowFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImageHighlightShadowFilter *)self.filter).shadows = 0;
        self.slider.value = 0;
     }
    
    if ([_title isEqualToString:@"提亮阴影"]) {
         _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageFalseColorFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImageFalseColorFilter *)self.filter).shadows = 0;
        self.slider.value = 0;
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
    
    if ([_title isEqualToString:@"球型折射"]) {
        _maximumValue = 1;
         _minimumValue = 0;
         if (!self.filter) {
             self.filter = [[GPUImageSphereRefractionFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImageSphereRefractionFilter *)self.filter).radius = 0.25;
        self.slider.value = 0.25;
     }
    
    if ([_title isEqualToString:@"色调分离"]) {
        _maximumValue = 256;
         _minimumValue = 1;
         if (!self.filter) {
             self.filter = [[GPUImagePosterizeFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        ((GPUImagePosterizeFilter *)self.filter).colorLevels = 10;
        self.slider.value = 10;
     }
    
    if ([_title isEqualToString:@"CGA色彩滤镜"]) {
         if (!self.filter) {
             self.filter = [[GPUImageCGAColorspaceFilter alloc] init];
              [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
              [self.sourcePicture addTarget:self.filter];
              [self.filter addTarget:self.imageView];
         }
        self.slider.hidden = YES;
     }
    
    if ([_title isEqualToString:@"柏林燥点"]) {
         _maximumValue = 1;
          _minimumValue = -1;
          if (!self.filter) {
              self.filter = [[GPUImagePerlinNoiseFilter alloc] init];
               [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
               [self.sourcePicture addTarget:self.filter];
               [self.filter addTarget:self.imageView];
          }
        ((GPUImagePerlinNoiseFilter *)self.filter).scale = 0;
        self.slider.value = 0;
     }
    
    if ([_title isEqualToString:@"3x3卷积"]) {
          if (!self.filter) {
              self.filter = [[GPUImage3x3ConvolutionFilter alloc] init];
               [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
               [self.sourcePicture addTarget:self.filter];
               [self.filter addTarget:self.imageView];
          }
        self.slider.hidden = YES;
     }
    
    if ([_title isEqualToString:@"浮雕"]) {
        _maximumValue = 4;
        _minimumValue = 0;
        if (!self.filter) {
            self.filter = [[GPUImageEmbossFilter alloc] init];
             [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
             [self.sourcePicture addTarget:self.filter];
             [self.filter addTarget:self.imageView];
        }
        ((GPUImageEmbossFilter *)self.filter).intensity = 1;
        self.slider.value = 1;
     }
    
    if ([_title isEqualToString:@"像素圆点花样"]) {
        _maximumValue = 1;
        _minimumValue = 0;
        if (!self.filter) {
            self.filter = [[GPUImagePolkaDotFilter alloc] init];
             [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
             [self.sourcePicture addTarget:self.filter];
             [self.filter addTarget:self.imageView];
        }
        ((GPUImagePolkaDotFilter *)self.filter).dotScaling = 1;
        self.slider.value = 1;
     }
    
    if ([_title isEqualToString:@"点染"]) {

        if (!self.filter) {
            self.filter = [[GPUImageHalftoneFilter alloc] init];
             [self.filter forceProcessingAtSize:self.imageView.sizeInPixels];
             [self.sourcePicture addTarget:self.filter];
             [self.filter addTarget:self.imageView];
        }
        self.slider.hidden = YES;
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
    
    if ([_title isEqualToString:@"色彩直方图"]) {
        ((GPUImageHistogramFilter *)self.filter).downsamplingFactor = value;
     }
    
    if ([_title isEqualToString:@"RGB"]) {
        ((GPUImageRGBFilter *)self.filter).red = value;
        ((GPUImageRGBFilter *)self.filter).green = value;
        ((GPUImageRGBFilter *)self.filter).blue = value;
     }
    
    if ([_title isEqualToString:@"不透明度"]) {
        ((GPUImageOpacityFilter *)self.filter).opacity = value;
     }
    
    if ([_title isEqualToString:@"提亮阴影"]) {
        ((GPUImageHighlightShadowFilter *)self.filter).shadows = value;
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
        ((GPUImageMosaicFilter *)self.filter).numTiles = value;
     }
    
    if ([_title isEqualToString:@"像素化"]) {
         ((GPUImagePixellateFilter *)self.filter).fractionalWidthOfAPixel = value;
     }
    
    if ([_title isEqualToString:@"同心圆像素化"]) {
        ((GPUImagePolarPixellateFilter *)self.filter).pixelSize = CGSizeMake(value, value);
     }
    
    if ([_title isEqualToString:@"交叉线阴影"]) {
        ((GPUImageCrosshatchFilter *)self.filter).crossHatchSpacing = value;
     }
    
    if ([_title isEqualToString:@"晕影"]) {
        ((GPUImageVignetteFilter *)self.filter).vignetteStart = value;
     }
    
    
    if ([_title isEqualToString:@"漩涡"]) {
        ((GPUImageSwirlFilter *)self.filter).radius = value;
     }
    
    if ([_title isEqualToString:@"凸面镜"]) {
        ((GPUImageBulgeDistortionFilter *)self.filter).radius = value;
     }
    
    
    if ([_title isEqualToString:@"凹面镜"]) {
        ((GPUImagePinchDistortionFilter *)self.filter).radius = value;
     }
    
    if ([_title isEqualToString:@"水晶球"]) {
        ((GPUImageGlassSphereFilter *)self.filter).radius = value;
     }
    
    if ([_title isEqualToString:@"球型折射"]) {
        ((GPUImageSphereRefractionFilter *)self.filter).radius = value;
     }
    
    if ([_title isEqualToString:@"色调分离"]) {
        ((GPUImagePosterizeFilter *)self.filter).colorLevels = value;
     }
    
    
    if ([_title isEqualToString:@"柏林燥点"]) {
        ((GPUImagePerlinNoiseFilter *)self.filter).scale = value;
     }
    
    if ([_title isEqualToString:@"浮雕"]) {
        ((GPUImageEmbossFilter *)self.filter).intensity = value;
     }
    
    if ([_title isEqualToString:@"像素圆点花样"]) {
        ((GPUImagePolkaDotFilter *)self.filter).dotScaling = value;
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
