//
//  CallWebJSController.h
//  WKWebViewJSBridge
//
//  Created by mayzh on 7/6/20.
//  Copyright © 2020 My. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CallWebJSController : NSObject
- (instancetype)initWithWebView:(WKWebView *)webView;
- (void)setOverFlowHidden;
- (void)callBackTOWebView:(NSString *)methodName params:(NSArray *)params;
- (void)callWebViewPrintData;
- (void)callWebViewAppear;
- (void)callWebViewDisAppear;
@end

NS_ASSUME_NONNULL_END
