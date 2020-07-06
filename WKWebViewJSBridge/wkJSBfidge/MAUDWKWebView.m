//
//  MAUDWKWebView.m
//  WKWebViewJSBridge
//
//  Created by mayzh on 7/3/20.
//  Copyright © 2020 My. All rights reserved.
//

#import "MAUDWKWebView.h"
#import "WeakWKScriptMessageHandler.h"
#import "GNAJSMethodsManager.h"
#import "CallWebJSController.h"

#import <WebKit/WebKit.h>

@interface MAUDWKWebView ()
@property (nonatomic, strong) CallWebJSController *callWebJSController;
@end


@implementation MAUDWKWebView

- (void)dealloc {
    NSLog(@"MAUDWKWebView--dealloc");
}

- (void)disposeResource {
    [[self configuration].userContentController removeScriptMessageHandlerForName:[GNAJSMethodsManager globalBaseNativeMethodName4JS]];
}

+ (WKWebViewConfiguration *)configurationWithJSTarget:(NAJSMethodController *)jsTarget {
    WKPreferences *preference = [[WKPreferences alloc] init];
    preference.javaScriptEnabled = YES;
    preference.javaScriptCanOpenWindowsAutomatically = YES;

    WeakWKScriptMessageHandler *weakScriptMessageDelegate = [[WeakWKScriptMessageHandler alloc] initWithDelegate:jsTarget];

    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //注册JS调用到NA端后，NA端的统一处理函数
    [userContentController addScriptMessageHandler:weakScriptMessageDelegate name:[GNAJSMethodsManager globalBaseNativeMethodName4JS]];

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = preference;
    configuration.userContentController = userContentController;
    return configuration;
}

+ (MAUDWKWebView *)initWithTarget:(NAJSMethodController *)jsTarget delegate:(MAUDWKWVDelegate *)webViewDelegate {
    WKWebViewConfiguration *configuration = [self configurationWithJSTarget:jsTarget];
    MAUDWKWebView *webView = [[MAUDWKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    webView.UIDelegate = webViewDelegate;
    webView.navigationDelegate = webViewDelegate;
    webView.callWebJSController = [[CallWebJSController alloc] initWithWebView:webView];
    [jsTarget insertCallBackToWebJSController:webView.callWebJSController];
    return webView;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
