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
- (void)callWebViewPrintData;
@end

NS_ASSUME_NONNULL_END
