//
//  QRCodeReaderViewController.m
//  QRCodeReader
//
//  Created by Tsubasa Yonenaga on 2016/06/24.
//  Copyright © 2016年 Tsubasa Yonenaga. All rights reserved.
//

@interface QRCodeReaderViewController () <ZBarReaderDelegate> {
    ZBarImageScanner * barcodeScanner;
}

@end

@implementation QRCodeReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.supportedOrientationsMask = ZBarOrientationMaskAll;
    self.readerDelegate = self;
    barcodeScanner = self.scanner;
    [barcodeScanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
}

- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info {
    
    NSLog(@"the image picker is calling successfully %@",info);
    id <NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    NSString *hiddenData;
    for(symbol in results)
        hiddenData=[NSString stringWithString:symbol.data];

    [self presentViewController:barcodeScanner animated:YES completion:nil];
    
}
@end
