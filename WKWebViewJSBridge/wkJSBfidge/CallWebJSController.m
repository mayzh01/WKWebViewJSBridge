//
//  CallWebJSController.m
//  WKWebViewJSBridge
//
//  Created by mayzh on 7/6/20.
//  Copyright © 2020 My. All rights reserved.
//

#import "CallWebJSController.h"

@interface CallWebJSController ()
@property(nonatomic, weak) WKWebView *webView;
@end

@implementation CallWebJSController

- (instancetype)initWithWebView:(WKWebView *)webView {
    self = [super init];
    if (self) {
        _webView = webView;
    }
    return self;
}

- (void)callBackTOWebView:(NSString *)methodName params:(NSArray *)params {
    if (!self.webView || !methodName.length) {
        return;
    }

    NSString *paramString = [self convertArrayToJson:params];
    NSString *jsString = [NSString stringWithFormat:@"%@('%@')", methodName, paramString];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        NSLog(@"callBackTOWebView");
    }];
}

- (void)callWebViewAppear {
    [self callBackTOWebView:@"MAUDScriptObj.page.viewDidAppear" params:@[[NSString stringWithFormat:@"view appear:%@", self.webView]]];
}

- (void)callWebViewDisAppear {
    [self callBackTOWebView:@"MAUDScriptObj.page.viewDidDisAppear" params:@[[NSString stringWithFormat:@"view disappear:%@", self.webView]]];
}

- (void)callWebViewPrintData {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSString* dateString = [dateFormatter stringFromDate:[NSDate date]];
    [self callBackTOWebView:@"callBackToJS" params:@[@"时间", dateString]];
}

- (NSString *)convertArrayToJson:(NSArray *)list {
    NSString *info = @"";
    for (NSObject *obj in list) {
        NSString *tmp = [NSString stringWithFormat:@"%@", obj];
        if (info.length) {
            info = [NSString stringWithFormat:@"%@, %@", info, obj];
        } else {
            info = tmp;
        }
    }
    return info;
}

- (void)addCustomScript:(NSString*)script {
    WKUserScript *wkScript = [[WKUserScript alloc] initWithSource:script injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    [self.webView.configuration.userContentController addUserScript:wkScript];
}

- (void)setOverFlowHidden {
    //防止滑动时显示父View
    [self addCustomScript:@"document.documentElement.style.overflow='hidden'"];
}

@end
