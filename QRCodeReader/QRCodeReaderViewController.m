//
//  QRCodeReaderViewController.m
//  QRCodeReader
//
//  Created by Tsubasa Yonenaga on 2016/06/24.
//  Copyright © 2016年 Tsubasa Yonenaga. All rights reserved.
//

@interface QRCodeReaderViewController () <ZBarReaderDelegate>
@end

@implementation QRCodeReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"Scanning...");
    _resultTextView.text = @"Scanning...";
    
    self.readerDelegate = self;
    self.supportedOrientationsMask = ZBarOrientationMaskAll;

    ZBarImageScanner * barcodeScanner = self.scanner;
    [barcodeScanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
//    [self presentViewController: self animated:YES completion:nil];

}

- (void) readerControllerDidFailToRead:(ZBarReaderController *)reader withRetry:(BOOL)retry {
    NSLog(@"the image picker failing to reader");
}

- (void) reader: (QRCodeViewController *) reader didScanResult: (NSString *) result {
    
}

-(BOOL)hasQRCode:(UIImage *)image
{
    ZBarImage *zbarimg = [[ZBarImage alloc] initWithCGImage:image.CGImage];
    ZBarImageScanner *Scanner = [[ZBarImageScanner alloc] init];
    BOOL hasqr = [Scanner scanImage:zbarimg];
    return hasqr;
}

- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info {
    
    NSLog(@"the image picker is calling successfully %@",info);
    id <NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    NSLog(@"%@",symbol.data);
    
    

    [reader dismissViewControllerAnimated:YES completion:nil];
    
}

//- (void) viewController: (UIViewController *) viewController {
//    WebViewController *webVC = [WebViewController new];
//    [self presentViewController: webVC animated:YES completion:nil];
//}

@end
