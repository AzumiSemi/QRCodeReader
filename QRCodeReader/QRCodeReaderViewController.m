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
    
    _resultTextView.text = @"Scanning...";
    self.readerDelegate = self;
    self.supportedOrientationsMask = ZBarOrientationMaskAll;

    ZBarImageScanner * barcodeScanner = self.scanner;
    [barcodeScanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
}

- (void) readerControllerDidFailToRead:(ZBarReaderController *)reader withRetry:(BOOL)retry {
    NSLog(@"the image picker failing to reader");
}

- (void) reader: (QRCodeViewController *) reader didScanResult: (NSString *) result {
    
}

-(BOOL)hasQRCode:(UIImage *)image
{
    ZBarImage *zbarimg = [[ZBarImage alloc] initWithCGImage:image.CGImage];
    ZBarImageScanner *Scanner = [ZBarImageScanner new];
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
    
    NSString * firstLink = @"https://www.amazon.co.jp/s/ref=nb_sb_noss?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&url=search-alias%3Daps&field-keywords=";
    
    WebViewController *webVC = [[WebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",firstLink,symbol.data]];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

@end
