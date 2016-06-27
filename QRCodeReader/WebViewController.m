//
//  WebViewController.m
//  QRCodeReader
//
//  Created by Tsubasa Yonenaga on 2016/06/24.
//  Copyright © 2016年 Tsubasa Yonenaga. All rights reserved.
//

@interface WebViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate> {
    NSString *_webURL;
    UIWebView *_webView;
    NJKWebViewProgressView *_progressView;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    NJKWebViewProgress *webViewProgress = [[NJKWebViewProgress alloc] init];
    _webView.delegate = webViewProgress;
    webViewProgress.progressDelegate = self;
    
    CGRect navigationBar = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBar.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height, navigationBar.size.width, [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webURL]]];
}

- (void) cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [SVProgressHUD dismiss];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    [SVProgressHUD show];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
