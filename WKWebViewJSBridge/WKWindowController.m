//
//  WKWindowController.m
//  WKWebViewJSBridge
//
//  Created by ma on 6/29/20.
//  Copyright © 2020 My. All rights reserved.
//

#import "WKWindowController.h"
#import "WeakWKScriptMessageHandler.h"

#import <WebKit/WebKit.h>

@interface WKWindowController () <NSWindowDelegate, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKPreferences *preference;
@property (nonatomic, strong) WKWebViewConfiguration *webViewConfig;
@property (nonatomic, strong) WKUserContentController *userContentController;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WeakWKScriptMessageHandler *weakScriptMessageDelegate;
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
    [self loadTestUrl];
}

- (void)loadTestUrl {
    NSString *fileName = @"testMouse.html";
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", [NSURL fileURLWithPath:[NSBundle mainBundle].resourcePath].absoluteString, fileName];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

#pragma mark - NSWindowDelegate
- (void)windowWillClose:(NSNotification *)notification {
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"jsToOcNoPrams"];
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:[self callNativeMethodName]];
    if ([self.closeDelegate respondsToSelector:@selector(windowWillClose)]) {
        [self.closeDelegate windowWillClose];
    }
}

#pragma mark - WKScriptMessageHandler
#pragma mark JS调用到NA端的处理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary * parameter = message.body;
    NSString *methodName = parameter[@"methodName"];
    NSString *nativeMethodName = message.name;
    if (![nativeMethodName isEqualToString:[self callNativeMethodName]]) {
        return;
    }
    if (!methodName.length) {
        return;
    }
    if ([methodName isEqualToString:@"downMethod"]) {
        //收到js调用的downMethod方法后
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
        NSString* dateString = [dateFormatter stringFromDate:[NSDate date]];

        NSString *jsString = [NSString stringWithFormat:@"callBackToJS('%@')", dateString];
        [_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
            NSLog(@"callBackToJS");
        }];

    }
}

#pragma mark - WKNavigationDelegate
// 开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"WKWebView:didStartProvisionalNavigation:");
}

// 加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"WKWebView:didFailProvisionalNavigation:");
}

// 内容开始返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"WKWebView:didCommitNavigation:");
}

// 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"WKWebView:didFinishNavigation:");
}

// 重定向时调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"WKWebView:didReceiveServerRedirectForProvisionalNavigation:");
}

// 根据Policy来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 根据response来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//进程被终止
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    NSLog(@"WKWebView:webViewWebContentProcessDidTerminate");
}

#pragma mark - WKUIDelegate
// 本页面内跳转
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - 初始化方法
- (WeakWKScriptMessageHandler *)weakScriptMessageDelegate {
    if (!_weakScriptMessageDelegate) {
        _weakScriptMessageDelegate = [[WeakWKScriptMessageHandler alloc] initWithDelegate:self];
    }
    return _weakScriptMessageDelegate;
}

- (WKPreferences *)preference {
    if (!_preference) {
        _preference = [[WKPreferences alloc] init];
        _preference.javaScriptEnabled = YES;
        _preference.javaScriptCanOpenWindowsAutomatically = YES;
    }
    return _preference;
}

- (WKWebViewConfiguration *)webViewConfig {
    if (!_webViewConfig) {
        _webViewConfig = [[WKWebViewConfiguration alloc] init];
    }
    return _webViewConfig;
}

- (WKUserContentController *)userContentController {
    if (!_userContentController) {
        _userContentController = [[WKUserContentController alloc] init];
        //注册JS调用到NA端后，NA端的统一处理函数
        [_userContentController addScriptMessageHandler:self.weakScriptMessageDelegate name:[self callNativeMethodName]];
    }
    return _userContentController;
}

- (NSString *)callNativeMethodName {
    return @"callNativeMethod";
}

- (WKWebView *)webView {
    if (!_webView) {
        self.webViewConfig.preferences = self.preference;
        self.webViewConfig.userContentController = self.userContentController;
        _webView = [[WKWebView alloc] initWithFrame:self.window.contentView.frame configuration:self.webViewConfig];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end
