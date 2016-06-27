//
//  QRCodeViewController.m
//  QRCodeReader
//
//  Created by Tsubasa Yonenaga on 2016/06/24.
//  Copyright © 2016年 Tsubasa Yonenaga. All rights reserved.
//


@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allheight = [[UIScreen mainScreen] bounds].size.height;
    self.allWidth = self.allheight;

    
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIFilter"];
    NSData *qrData = [[NSString stringWithFormat:@""] dataUsingEncoding:NSUTF8StringEncoding];
    [ciFilter setValue:qrData forKey:@""];
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    [[CIContext contextWithOptions:nil] createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    
}


@end
