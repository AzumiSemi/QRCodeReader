//
//  WebViewController.m
//  QRCodeReader
//
//  Created by Tsubasa Yonenaga on 2016/06/24.
//  Copyright © 2016年 Tsubasa Yonenaga. All rights reserved.
//

@interface WebViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate> {
    NSString                *_webURL;
    UIWebView               *_webView;
    NJKWebViewProgressView  *_progressView;
}

@end

@implementation WebViewController

- (id)initWithUrl:(NSString *)webUrl {
    self = [super init];
    if (self) {
        _webURL = [NSString stringWithString:webUrl];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissView)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, fullWidth, fullHeight)];
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    NJKWebViewProgress *progressProxy = [NJKWebViewProgress new];
    progressProxy.webViewProxyDelegate = self;
    progressProxy.progressDelegate = self;
    _webView.delegate = self;
    
    CGRect navigationBar = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBar.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height,
                                 navigationBar.size.width, [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webURL]]];
}

- (void) dismissView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:NO];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


@end
