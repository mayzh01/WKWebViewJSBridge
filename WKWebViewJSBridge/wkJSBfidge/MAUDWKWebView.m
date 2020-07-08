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
    [[self configuration].userContentController removeAllUserScripts];
}

- (void)willOpenMenu:(NSMenu *)menu withEvent:(NSEvent *)event {
    for (NSMenuItem *item in menu.itemArray) {
        //控制item是否隐藏
        item.hidden = NO;
    }
}

+ (NSString *)customScriptString {
    return @"window.MAUDScript = {};\
    window.MAUDScript.ThrowEvent = function(method,param,callback) {\
            window.webkit.messageHandlers.ThrowEvent.postMessage({'method':method,\
                                                                    'param':param,\
                                                                'callback':callback\
            });\
    };";
}

+ (WKWebViewConfiguration *)configurationWithJSTarget:(NAJSMethodController *)jsTarget {
    WKPreferences *preference = [[WKPreferences alloc] init];
    preference.javaScriptEnabled = YES;
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    [preference setValue:@(YES) forKey:@"developerExtrasEnabled"];

    WeakWKScriptMessageHandler *weakScriptMessageDelegate = [[WeakWKScriptMessageHandler alloc] initWithDelegate:jsTarget];

    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //注册JS调用到NA端后，NA端的统一处理函数
    [userContentController addScriptMessageHandler:weakScriptMessageDelegate name:[GNAJSMethodsManager globalBaseNativeMethodName4JS]];
    {
    //JS以throwEvent的方式调用端上。端上在WKUserContentController的回调里处理throwEvent方法的参数，如method,param,callback。
        [userContentController addScriptMessageHandler:weakScriptMessageDelegate name:@"ThrowEvent"];
        WKUserScript *wkScript = [[WKUserScript alloc] initWithSource:[self customScriptString] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        [userContentController addUserScript:wkScript];
    }

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
    [webView.callWebJSController setOverFlowHidden]; //避免滑动时显示父view
    [jsTarget insertCallBackToWebJSController:webView.callWebJSController];
    return webView;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
