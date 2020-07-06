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


@end
