//
//  QRCodeReaderViewController.h
//  QRCodeReader
//
//  Created by Tsubasa Yonenaga on 2016/06/24.
//  Copyright © 2016年 Tsubasa Yonenaga. All rights reserved.
//

#import <ZBarSDK/ZBarSDK.h>

@interface QRCodeReaderViewController : ZBarReaderViewController

@property (nonatomic, strong) UITextView  *resultTextView;

@end
