//
//  MAUDWKWebView.h
//  WKWebViewJSBridge
//
//  Created by mayzh on 7/3/20.
//  Copyright © 2020 My. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "NAJSMethodController.h"
#import "MAUDWKWVDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAUDWKWebView : WKWebView
+ (MAUDWKWebView *)initWithTarget:(NAJSMethodController *)jsTarget delegate:(MAUDWKWVDelegate *)webViewDelegate;
- (void)disposeResource;
@end

NS_ASSUME_NONNULL_END
