//
//  WKWindowController.m
//  WKWebViewJSBridge
//
//  Created by ma on 6/29/20.
//  Copyright © 2020 My. All rights reserved.
//

#import "WKWindowController.h"
#import "MAUDWKWebView.h"
#import "NAJSMethodController.h"
#import "MAUDWKWVDelegate.h"

#import <WebKit/WebKit.h>

@interface WKWindowController () <NSWindowDelegate>
@property (nonatomic, strong) MAUDWKWebView *webView;
@property (nonatomic, strong) NAJSMethodController *jsController;
@property (nonatomic, strong) MAUDWKWVDelegate *webViewDelegate;
@end

@implementation WKWindowController

- (void)dealloc {
    NSLog(@"WKWindowController--dealloc");
}

- (void)windowDidLoad {
    [super windowDidLoad];
    self.window.delegate = self;
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    [self.window.contentView addSubview:self.webView];
    [self.webView setFrame:self.window.contentView.frame];
    [self loadTestUrl];
}

- (void)loadTestUrl {
    NSString *fileName = @"testMouse.html";
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", [NSURL fileURLWithPath:[NSBundle mainBundle].resourcePath].absoluteString, fileName];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

#pragma mark - NSWindowDelegate
- (void)windowWillClose:(NSNotification *)notification {
    [self.webView disposeResource];
    if ([self.closeDelegate respondsToSelector:@selector(windowWillClose)]) {
        [self.closeDelegate windowWillClose];
    }
}

#pragma mark - init 方法
- (MAUDWKWebView *)webView {
    if (!_webView) {
        _webView = [MAUDWKWebView initWithTarget:self.jsController delegate:self.webViewDelegate];
    }
    return _webView;
}

- (NAJSMethodController *)jsController {
    if (!_jsController) {
        _jsController = [[NAJSMethodController alloc] init];
    }
    return _jsController;
}

- (MAUDWKWVDelegate *)webViewDelegate {
    if (!_webViewDelegate) {
        _webViewDelegate = [[MAUDWKWVDelegate alloc] init];
    }
    return _webViewDelegate;
}

@end
