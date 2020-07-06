//
//  MAUDWKWVDelegate.m
//  WKWebViewJSBridge
//
//  Created by mayzh on 7/6/20.
//  Copyright © 2020 My. All rights reserved.
//

#import "MAUDWKWVDelegate.h"

@interface MAUDWKWVDelegate ()

@end

@implementation MAUDWKWVDelegate

- (void)dealloc {
    NSLog(@"MAUDWKWVDelegate--dealloc");
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

@end
