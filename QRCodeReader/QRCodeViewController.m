//
//  QRCodeViewController.m
//  QRCodeReader
//
//  Created by Tsubasa Yonenaga on 2016/06/24.
//  Copyright © 2016年 Tsubasa Yonenaga. All rights reserved.
//


@interface QRCodeViewController () {
    UIImage *_image;
    UIImageView *_imageView;
}

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSData *qrData = [[NSString stringWithFormat:@"https://github.com/SVProgressHUD/SVProgressHUD"] dataUsingEncoding:NSUTF8StringEncoding];
    [ciFilter setValue:qrData forKey:@"inputMessage"];
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    [[CIContext contextWithOptions:nil] createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    
    _image = [UIImage imageWithCGImage:cgImage scale:1.0f orientation:UIImageOrientationUp];
    UIGraphicsBeginImageContext(CGSizeMake(fullWidth, fullWidth));
    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), kCGInterpolationNone);
    [_image drawInRect:CGRectMake(0, 0, fullWidth, fullWidth)];
    _image = UIGraphicsGetImageFromCurrentImageContext();
    
    _imageView = [UIImageView new];
    _imageView.layer.magnificationFilter = kCAFilterNearest;
    _imageView.frame = self.view.bounds;
    _imageView.image = _image;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
}


@end
